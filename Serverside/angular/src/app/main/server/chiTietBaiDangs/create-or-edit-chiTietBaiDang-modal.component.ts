import { Component, ViewChild, Injector, Output, EventEmitter } from "@angular/core";
import { ModalDirective } from "ngx-bootstrap/modal";
import { finalize } from "rxjs/operators";
import { ChiTietBaiDangsServiceProxy, CreateOrEditChiTietBaiDangDto } from "@shared/service-proxies/service-proxies";
import { AppComponentBase } from "@shared/common/app-component-base";
import { DateTime } from "luxon";

import { DateTimeService } from "@app/shared/common/timing/date-time.service";
import { ChiTietBaiDangThuocTinhLookupTableModalComponent } from "./chiTietBaiDang-thuocTinh-lookup-table-modal.component";
import { ChiTietBaiDangBaiDangLookupTableModalComponent } from "./chiTietBaiDang-baiDang-lookup-table-modal.component";

@Component({
    selector: "createOrEditChiTietBaiDangModal",
    templateUrl: "./create-or-edit-chiTietBaiDang-modal.component.html",
})
export class CreateOrEditChiTietBaiDangModalComponent extends AppComponentBase {
    @ViewChild("createOrEditModal", { static: true }) modal: ModalDirective;
    @ViewChild("chiTietBaiDangThuocTinhLookupTableModal", { static: true })
    chiTietBaiDangThuocTinhLookupTableModal: ChiTietBaiDangThuocTinhLookupTableModalComponent;
    @ViewChild("chiTietBaiDangBaiDangLookupTableModal", { static: true })
    chiTietBaiDangBaiDangLookupTableModal: ChiTietBaiDangBaiDangLookupTableModalComponent;

    @Output() modalSave: EventEmitter<any> = new EventEmitter<any>();

    active = false;
    saving = false;

    chiTietBaiDang: CreateOrEditChiTietBaiDangDto = new CreateOrEditChiTietBaiDangDto();

    thuocTinhTenThuocTinh = "";
    baiDangTieuDe = "";

    constructor(injector: Injector, private _chiTietBaiDangsServiceProxy: ChiTietBaiDangsServiceProxy, private _dateTimeService: DateTimeService) {
        super(injector);
    }

    show(chiTietBaiDangId?: number): void {
        if (!chiTietBaiDangId) {
            this.chiTietBaiDang = new CreateOrEditChiTietBaiDangDto();
            this.chiTietBaiDang.id = chiTietBaiDangId;
            this.thuocTinhTenThuocTinh = "";
            this.baiDangTieuDe = "";

            this.active = true;
            this.modal.show();
        } else {
            this._chiTietBaiDangsServiceProxy.getChiTietBaiDangForEdit(chiTietBaiDangId).subscribe((result) => {
                this.chiTietBaiDang = result.chiTietBaiDang;

                this.thuocTinhTenThuocTinh = result.thuocTinhTenThuocTinh;
                this.baiDangTieuDe = result.baiDangTieuDe;

                this.active = true;
                this.modal.show();
            });
        }
    }

    save(): void {
        this.saving = true;

        this._chiTietBaiDangsServiceProxy
            .createOrEdit(this.chiTietBaiDang)
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
        this.chiTietBaiDangThuocTinhLookupTableModal.id = this.chiTietBaiDang.thuocTinhId;
        this.chiTietBaiDangThuocTinhLookupTableModal.displayName = this.thuocTinhTenThuocTinh;
        this.chiTietBaiDangThuocTinhLookupTableModal.show();
    }
    openSelectBaiDangModal() {
        this.chiTietBaiDangBaiDangLookupTableModal.id = this.chiTietBaiDang.baiDangId;
        this.chiTietBaiDangBaiDangLookupTableModal.displayName = this.baiDangTieuDe;
        this.chiTietBaiDangBaiDangLookupTableModal.show();
    }

    setThuocTinhIdNull() {
        this.chiTietBaiDang.thuocTinhId = null;
        this.thuocTinhTenThuocTinh = "";
    }
    setBaiDangIdNull() {
        this.chiTietBaiDang.baiDangId = null;
        this.baiDangTieuDe = "";
    }

    getNewThuocTinhId() {
        this.chiTietBaiDang.thuocTinhId = this.chiTietBaiDangThuocTinhLookupTableModal.id;
        this.thuocTinhTenThuocTinh = this.chiTietBaiDangThuocTinhLookupTableModal.displayName;
    }
    getNewBaiDangId() {
        this.chiTietBaiDang.baiDangId = this.chiTietBaiDangBaiDangLookupTableModal.id;
        this.baiDangTieuDe = this.chiTietBaiDangBaiDangLookupTableModal.displayName;
    }

    close(): void {
        this.active = false;
        this.modal.hide();
    }
}
