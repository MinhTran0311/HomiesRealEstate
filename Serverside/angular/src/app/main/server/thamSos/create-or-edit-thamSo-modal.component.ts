import { Component, ViewChild, Injector, Output, EventEmitter } from "@angular/core";
import { ModalDirective } from "ngx-bootstrap/modal";
import { finalize } from "rxjs/operators";
import { ThamSosServiceProxy, CreateOrEditThamSoDto } from "@shared/service-proxies/service-proxies";
import { AppComponentBase } from "@shared/common/app-component-base";
import { DateTime } from "luxon";

import { DateTimeService } from "@app/shared/common/timing/date-time.service";

@Component({
    selector: "createOrEditThamSoModal",
    templateUrl: "./create-or-edit-thamSo-modal.component.html",
})
export class CreateOrEditThamSoModalComponent extends AppComponentBase {
    @ViewChild("createOrEditModal", { static: true }) modal: ModalDirective;

    @Output() modalSave: EventEmitter<any> = new EventEmitter<any>();

    active = false;
    saving = false;

    thamSo: CreateOrEditThamSoDto = new CreateOrEditThamSoDto();

    constructor(injector: Injector, private _thamSosServiceProxy: ThamSosServiceProxy, private _dateTimeService: DateTimeService) {
        super(injector);
    }

    show(thamSoId?: number): void {
        if (!thamSoId) {
            this.thamSo = new CreateOrEditThamSoDto();
            this.thamSo.id = thamSoId;

            this.active = true;
            this.modal.show();
        } else {
            this._thamSosServiceProxy.getThamSoForEdit(thamSoId).subscribe((result) => {
                this.thamSo = result.thamSo;

                this.active = true;
                this.modal.show();
            });
        }
    }

    save(): void {
        this.saving = true;

        this._thamSosServiceProxy
            .createOrEdit(this.thamSo)
            .pipe(
                finalize(() => {
                    this.saving = false;
                })
            )
            .subscribe(() => {
                this.notify.info(this.l("SavedSuccessfully"));
                this.close();
                this.modalSave.emit(null);
            });
    }

    close(): void {
        this.active = false;
        this.modal.hide();
    }
}
