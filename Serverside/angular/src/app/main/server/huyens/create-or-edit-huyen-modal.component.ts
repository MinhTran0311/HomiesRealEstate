import { Component, ViewChild, Injector, Output, EventEmitter } from "@angular/core";
import { ModalDirective } from "ngx-bootstrap/modal";
import { finalize } from "rxjs/operators";
import { HuyensServiceProxy, CreateOrEditHuyenDto } from "@shared/service-proxies/service-proxies";
import { AppComponentBase } from "@shared/common/app-component-base";
import { DateTime } from "luxon";

import { DateTimeService } from "@app/shared/common/timing/date-time.service";
import { HuyenTinhLookupTableModalComponent } from "./huyen-tinh-lookup-table-modal.component";

@Component({
    selector: "createOrEditHuyenModal",
    templateUrl: "./create-or-edit-huyen-modal.component.html",
})
export class CreateOrEditHuyenModalComponent extends AppComponentBase {
    @ViewChild("createOrEditModal", { static: true }) modal: ModalDirective;
    @ViewChild("huyenTinhLookupTableModal", { static: true }) huyenTinhLookupTableModal: HuyenTinhLookupTableModalComponent;

    @Output() modalSave: EventEmitter<any> = new EventEmitter<any>();

    active = false;
    saving = false;

    huyen: CreateOrEditHuyenDto = new CreateOrEditHuyenDto();

    tinhTenTinh = "";

    constructor(injector: Injector, private _huyensServiceProxy: HuyensServiceProxy, private _dateTimeService: DateTimeService) {
        super(injector);
    }

    show(huyenId?: number): void {
        if (!huyenId) {
            this.huyen = new CreateOrEditHuyenDto();
            this.huyen.id = huyenId;
            this.tinhTenTinh = "";

            this.active = true;
            this.modal.show();
        } else {
            this._huyensServiceProxy.getHuyenForEdit(huyenId).subscribe((result) => {
                this.huyen = result.huyen;

                this.tinhTenTinh = result.tinhTenTinh;

                this.active = true;
                this.modal.show();
            });
        }
    }

    save(): void {
        this.saving = true;

        this._huyensServiceProxy
            .createOrEdit(this.huyen)
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

    openSelectTinhModal() {
        this.huyenTinhLookupTableModal.id = this.huyen.tinhId;
        this.huyenTinhLookupTableModal.displayName = this.tinhTenTinh;
        this.huyenTinhLookupTableModal.show();
    }

    setTinhIdNull() {
        this.huyen.tinhId = null;
        this.tinhTenTinh = "";
    }

    getNewTinhId() {
        this.huyen.tinhId = this.huyenTinhLookupTableModal.id;
        this.tinhTenTinh = this.huyenTinhLookupTableModal.displayName;
    }

    close(): void {
        this.active = false;
        this.modal.hide();
    }
}
