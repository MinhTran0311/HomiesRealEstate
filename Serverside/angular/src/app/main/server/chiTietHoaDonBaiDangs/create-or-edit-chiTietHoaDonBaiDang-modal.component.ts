import { Component, ViewChild, Injector, Output, EventEmitter } from "@angular/core";
import { ModalDirective } from "ngx-bootstrap/modal";
import { finalize } from "rxjs/operators";
import { ChiTietHoaDonBaiDangsServiceProxy, CreateOrEditChiTietHoaDonBaiDangDto } from "@shared/service-proxies/service-proxies";
import { AppComponentBase } from "@shared/common/app-component-base";
import { DateTime } from "luxon";

import { DateTimeService } from "@app/shared/common/timing/date-time.service";
import { ChiTietHoaDonBaiDangBaiDangLookupTableModalComponent } from "./chiTietHoaDonBaiDang-baiDang-lookup-table-modal.component";
import { ChiTietHoaDonBaiDangGoiBaiDangLookupTableModalComponent } from "./chiTietHoaDonBaiDang-goiBaiDang-lookup-table-modal.component";
import { ChiTietHoaDonBaiDangUserLookupTableModalComponent } from "./chiTietHoaDonBaiDang-user-lookup-table-modal.component";

@Component({
    selector: "createOrEditChiTietHoaDonBaiDangModal",
    templateUrl: "./create-or-edit-chiTietHoaDonBaiDang-modal.component.html",
})
export class CreateOrEditChiTietHoaDonBaiDangModalComponent extends AppComponentBase {
    @ViewChild("createOrEditModal", { static: true }) modal: ModalDirective;
    @ViewChild("chiTietHoaDonBaiDangBaiDangLookupTableModal", { static: true })
    chiTietHoaDonBaiDangBaiDangLookupTableModal: ChiTietHoaDonBaiDangBaiDangLookupTableModalComponent;
    @ViewChild("chiTietHoaDonBaiDangGoiBaiDangLookupTableModal", { static: true })
    chiTietHoaDonBaiDangGoiBaiDangLookupTableModal: ChiTietHoaDonBaiDangGoiBaiDangLookupTableModalComponent;
    @ViewChild("chiTietHoaDonBaiDangUserLookupTableModal", { static: true })
    chiTietHoaDonBaiDangUserLookupTableModal: ChiTietHoaDonBaiDangUserLookupTableModalComponent;

    @Output() modalSave: EventEmitter<any> = new EventEmitter<any>();

    active = false;
    saving = false;

    chiTietHoaDonBaiDang: CreateOrEditChiTietHoaDonBaiDangDto = new CreateOrEditChiTietHoaDonBaiDangDto();

    baiDangTieuDe = "";
    goiBaiDangTenGoi = "";
    userName = "";

    constructor(
        injector: Injector,
        private _chiTietHoaDonBaiDangsServiceProxy: ChiTietHoaDonBaiDangsServiceProxy,
        private _dateTimeService: DateTimeService
    ) {
        super(injector);
    }

    show(chiTietHoaDonBaiDangId?: string): void {
        if (!chiTietHoaDonBaiDangId) {
            this.chiTietHoaDonBaiDang = new CreateOrEditChiTietHoaDonBaiDangDto();
            this.chiTietHoaDonBaiDang.id = chiTietHoaDonBaiDangId;
            this.chiTietHoaDonBaiDang.thoiDiem = this._dateTimeService.getStartOfDay();
            this.baiDangTieuDe = "";
            this.goiBaiDangTenGoi = "";
            this.userName = "";

            this.active = true;
            this.modal.show();
        } else {
            this._chiTietHoaDonBaiDangsServiceProxy.getChiTietHoaDonBaiDangForEdit(chiTietHoaDonBaiDangId).subscribe((result) => {
                this.chiTietHoaDonBaiDang = result.chiTietHoaDonBaiDang;

                this.baiDangTieuDe = result.baiDangTieuDe;
                this.goiBaiDangTenGoi = result.goiBaiDangTenGoi;
                this.userName = result.userName;

                this.active = true;
                this.modal.show();
            });
        }
    }

    save(): void {
        this.saving = true;

        this._chiTietHoaDonBaiDangsServiceProxy
            .createOrEdit(this.chiTietHoaDonBaiDang)
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

    openSelectBaiDangModal() {
        this.chiTietHoaDonBaiDangBaiDangLookupTableModal.id = this.chiTietHoaDonBaiDang.baiDangId;
        this.chiTietHoaDonBaiDangBaiDangLookupTableModal.displayName = this.baiDangTieuDe;
        this.chiTietHoaDonBaiDangBaiDangLookupTableModal.show();
    }
    openSelectGoiBaiDangModal() {
        this.chiTietHoaDonBaiDangGoiBaiDangLookupTableModal.id = this.chiTietHoaDonBaiDang.goiBaiDangId;
        this.chiTietHoaDonBaiDangGoiBaiDangLookupTableModal.displayName = this.goiBaiDangTenGoi;
        this.chiTietHoaDonBaiDangGoiBaiDangLookupTableModal.show();
    }
    openSelectUserModal() {
        this.chiTietHoaDonBaiDangUserLookupTableModal.id = this.chiTietHoaDonBaiDang.userId;
        this.chiTietHoaDonBaiDangUserLookupTableModal.displayName = this.userName;
        this.chiTietHoaDonBaiDangUserLookupTableModal.show();
    }

    setBaiDangIdNull() {
        this.chiTietHoaDonBaiDang.baiDangId = null;
        this.baiDangTieuDe = "";
    }
    setGoiBaiDangIdNull() {
        this.chiTietHoaDonBaiDang.goiBaiDangId = null;
        this.goiBaiDangTenGoi = "";
    }
    setUserIdNull() {
        this.chiTietHoaDonBaiDang.userId = null;
        this.userName = "";
    }

    getNewBaiDangId() {
        this.chiTietHoaDonBaiDang.baiDangId = this.chiTietHoaDonBaiDangBaiDangLookupTableModal.id;
        this.baiDangTieuDe = this.chiTietHoaDonBaiDangBaiDangLookupTableModal.displayName;
    }
    getNewGoiBaiDangId() {
        this.chiTietHoaDonBaiDang.goiBaiDangId = this.chiTietHoaDonBaiDangGoiBaiDangLookupTableModal.id;
        this.goiBaiDangTenGoi = this.chiTietHoaDonBaiDangGoiBaiDangLookupTableModal.displayName;
    }
    getNewUserId() {
        this.chiTietHoaDonBaiDang.userId = this.chiTietHoaDonBaiDangUserLookupTableModal.id;
        this.userName = this.chiTietHoaDonBaiDangUserLookupTableModal.displayName;
    }

    close(): void {
        this.active = false;
        this.modal.hide();
    }
}
