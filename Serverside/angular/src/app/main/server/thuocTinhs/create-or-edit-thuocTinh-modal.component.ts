import { Component, ViewChild, Injector, Output, EventEmitter } from "@angular/core";
import { ModalDirective } from "ngx-bootstrap/modal";
import { finalize } from "rxjs/operators";
import { ThuocTinhsServiceProxy, CreateOrEditThuocTinhDto } from "@shared/service-proxies/service-proxies";
import { AppComponentBase } from "@shared/common/app-component-base";
import { DateTime } from "luxon";

import { DateTimeService } from "@app/shared/common/timing/date-time.service";

@Component({
    selector: "createOrEditThuocTinhModal",
    templateUrl: "./create-or-edit-thuocTinh-modal.component.html",
})
export class CreateOrEditThuocTinhModalComponent extends AppComponentBase {
    @ViewChild("createOrEditModal", { static: true }) modal: ModalDirective;

    @Output() modalSave: EventEmitter<any> = new EventEmitter<any>();

    active = false;
    saving = false;

    thuocTinh: CreateOrEditThuocTinhDto = new CreateOrEditThuocTinhDto();

    constructor(injector: Injector, private _thuocTinhsServiceProxy: ThuocTinhsServiceProxy, private _dateTimeService: DateTimeService) {
        super(injector);
    }

    show(thuocTinhId?: number): void {
        if (!thuocTinhId) {
            this.thuocTinh = new CreateOrEditThuocTinhDto();
            this.thuocTinh.id = thuocTinhId;

            this.active = true;
            this.modal.show();
        } else {
            this._thuocTinhsServiceProxy.getThuocTinhForEdit(thuocTinhId).subscribe((result) => {
                this.thuocTinh = result.thuocTinh;

                this.active = true;
                this.modal.show();
            });
        }
    }

    save(): void {
        this.saving = true;

        this._thuocTinhsServiceProxy
            .createOrEdit(this.thuocTinh)
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
