import { Component, ViewChild, Injector, Output, EventEmitter } from "@angular/core";
import { ModalDirective } from "ngx-bootstrap/modal";
import { finalize } from "rxjs/operators";
import { DanhMucsServiceProxy, CreateOrEditDanhMucDto } from "@shared/service-proxies/service-proxies";
import { AppComponentBase } from "@shared/common/app-component-base";
import { DateTime } from "luxon";

import { DateTimeService } from "@app/shared/common/timing/date-time.service";

@Component({
    selector: "createOrEditDanhMucModal",
    templateUrl: "./create-or-edit-danhMuc-modal.component.html",
})
export class CreateOrEditDanhMucModalComponent extends AppComponentBase {
    @ViewChild("createOrEditModal", { static: true }) modal: ModalDirective;

    @Output() modalSave: EventEmitter<any> = new EventEmitter<any>();

    active = false;
    saving = false;

    danhMuc: CreateOrEditDanhMucDto = new CreateOrEditDanhMucDto();

    constructor(injector: Injector, private _danhMucsServiceProxy: DanhMucsServiceProxy, private _dateTimeService: DateTimeService) {
        super(injector);
    }

    show(danhMucId?: number): void {
        if (!danhMucId) {
            this.danhMuc = new CreateOrEditDanhMucDto();
            this.danhMuc.id = danhMucId;

            this.active = true;
            this.modal.show();
        } else {
            this._danhMucsServiceProxy.getDanhMucForEdit(danhMucId).subscribe((result) => {
                this.danhMuc = result.danhMuc;

                this.active = true;
                this.modal.show();
            });
        }
    }

    save(): void {
        this.saving = true;

        this._danhMucsServiceProxy
            .createOrEdit(this.danhMuc)
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
