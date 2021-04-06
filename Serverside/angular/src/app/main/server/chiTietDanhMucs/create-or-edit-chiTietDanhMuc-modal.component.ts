import { Component, ViewChild, Injector, Output, EventEmitter } from "@angular/core";
import { ModalDirective } from "ngx-bootstrap/modal";
import { finalize } from "rxjs/operators";
import { ChiTietDanhMucsServiceProxy, CreateOrEditChiTietDanhMucDto } from "@shared/service-proxies/service-proxies";
import { AppComponentBase } from "@shared/common/app-component-base";
import { DateTime } from "luxon";

import { DateTimeService } from "@app/shared/common/timing/date-time.service";
import { ChiTietDanhMucThuocTinhLookupTableModalComponent } from "./chiTietDanhMuc-thuocTinh-lookup-table-modal.component";
import { ChiTietDanhMucDanhMucLookupTableModalComponent } from "./chiTietDanhMuc-danhMuc-lookup-table-modal.component";

@Component({
    selector: "createOrEditChiTietDanhMucModal",
    templateUrl: "./create-or-edit-chiTietDanhMuc-modal.component.html",
})
export class CreateOrEditChiTietDanhMucModalComponent extends AppComponentBase {
    @ViewChild("createOrEditModal", { static: true }) modal: ModalDirective;
    @ViewChild("chiTietDanhMucThuocTinhLookupTableModal", { static: true })
    chiTietDanhMucThuocTinhLookupTableModal: ChiTietDanhMucThuocTinhLookupTableModalComponent;
    @ViewChild("chiTietDanhMucDanhMucLookupTableModal", { static: true })
    chiTietDanhMucDanhMucLookupTableModal: ChiTietDanhMucDanhMucLookupTableModalComponent;

    @Output() modalSave: EventEmitter<any> = new EventEmitter<any>();

    active = false;
    saving = false;

    chiTietDanhMuc: CreateOrEditChiTietDanhMucDto = new CreateOrEditChiTietDanhMucDto();

    thuocTinhTenThuocTinh = "";
    danhMucTenDanhMuc = "";

    constructor(injector: Injector, private _chiTietDanhMucsServiceProxy: ChiTietDanhMucsServiceProxy, private _dateTimeService: DateTimeService) {
        super(injector);
    }

    show(chiTietDanhMucId?: number): void {
        if (!chiTietDanhMucId) {
            this.chiTietDanhMuc = new CreateOrEditChiTietDanhMucDto();
            this.chiTietDanhMuc.id = chiTietDanhMucId;
            this.thuocTinhTenThuocTinh = "";
            this.danhMucTenDanhMuc = "";

            this.active = true;
            this.modal.show();
        } else {
            this._chiTietDanhMucsServiceProxy.getChiTietDanhMucForEdit(chiTietDanhMucId).subscribe((result) => {
                this.chiTietDanhMuc = result.chiTietDanhMuc;

                this.thuocTinhTenThuocTinh = result.thuocTinhTenThuocTinh;
                this.danhMucTenDanhMuc = result.danhMucTenDanhMuc;

                this.active = true;
                this.modal.show();
            });
        }
    }

    save(): void {
        this.saving = true;

        this._chiTietDanhMucsServiceProxy
            .createOrEdit(this.chiTietDanhMuc)
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

    openSelectThuocTinhModal() {
        this.chiTietDanhMucThuocTinhLookupTableModal.id = this.chiTietDanhMuc.thuocTinhId;
        this.chiTietDanhMucThuocTinhLookupTableModal.displayName = this.thuocTinhTenThuocTinh;
        this.chiTietDanhMucThuocTinhLookupTableModal.show();
    }
    openSelectDanhMucModal() {
        this.chiTietDanhMucDanhMucLookupTableModal.id = this.chiTietDanhMuc.danhMucId;
        this.chiTietDanhMucDanhMucLookupTableModal.displayName = this.danhMucTenDanhMuc;
        this.chiTietDanhMucDanhMucLookupTableModal.show();
    }

    setThuocTinhIdNull() {
        this.chiTietDanhMuc.thuocTinhId = null;
        this.thuocTinhTenThuocTinh = "";
    }
    setDanhMucIdNull() {
        this.chiTietDanhMuc.danhMucId = null;
        this.danhMucTenDanhMuc = "";
    }

    getNewThuocTinhId() {
        this.chiTietDanhMuc.thuocTinhId = this.chiTietDanhMucThuocTinhLookupTableModal.id;
        this.thuocTinhTenThuocTinh = this.chiTietDanhMucThuocTinhLookupTableModal.displayName;
    }
    getNewDanhMucId() {
        this.chiTietDanhMuc.danhMucId = this.chiTietDanhMucDanhMucLookupTableModal.id;
        this.danhMucTenDanhMuc = this.chiTietDanhMucDanhMucLookupTableModal.displayName;
    }

    close(): void {
        this.active = false;
        this.modal.hide();
    }
}
