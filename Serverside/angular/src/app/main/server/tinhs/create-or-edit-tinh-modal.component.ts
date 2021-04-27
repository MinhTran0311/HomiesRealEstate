import { Component, ViewChild, Injector, Output, EventEmitter } from "@angular/core";
import { ModalDirective } from "ngx-bootstrap/modal";
import { finalize } from "rxjs/operators";
import { TinhsServiceProxy, CreateOrEditTinhDto } from "@shared/service-proxies/service-proxies";
import { AppComponentBase } from "@shared/common/app-component-base";
import { DateTime } from "luxon";

import { DateTimeService } from "@app/shared/common/timing/date-time.service";

@Component({
    selector: "createOrEditTinhModal",
    templateUrl: "./create-or-edit-tinh-modal.component.html",
})
export class CreateOrEditTinhModalComponent extends AppComponentBase {
    @ViewChild("createOrEditModal", { static: true }) modal: ModalDirective;

    @Output() modalSave: EventEmitter<any> = new EventEmitter<any>();

    active = false;
    saving = false;

    tinh: CreateOrEditTinhDto = new CreateOrEditTinhDto();

    constructor(injector: Injector, private _tinhsServiceProxy: TinhsServiceProxy, private _dateTimeService: DateTimeService) {
        super(injector);
    }

    show(tinhId?: number): void {
        if (!tinhId) {
            this.tinh = new CreateOrEditTinhDto();
            this.tinh.id = tinhId;

            this.active = true;
            this.modal.show();
        } else {
            this._tinhsServiceProxy.getTinhForEdit(tinhId).subscribe((result) => {
                this.tinh = result.tinh;

                this.active = true;
                this.modal.show();
            });
        }
    }

    save(): void {
        this.saving = true;

        this._tinhsServiceProxy
            .createOrEdit(this.tinh)
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
