import { Component, ViewChild, Injector, Output, EventEmitter } from "@angular/core";
import { ModalDirective } from "ngx-bootstrap/modal";
import { finalize } from "rxjs/operators";
import { LichSuGiaoDichsServiceProxy, CreateOrEditLichSuGiaoDichDto } from "@shared/service-proxies/service-proxies";
import { AppComponentBase } from "@shared/common/app-component-base";
import { DateTime } from "luxon";

import { DateTimeService } from "@app/shared/common/timing/date-time.service";
import { LichSuGiaoDichUserLookupTableModalComponent } from "./lichSuGiaoDich-user-lookup-table-modal.component";
import { LichSuGiaoDichChiTietHoaDonBaiDangLookupTableModalComponent } from "./lichSuGiaoDich-chiTietHoaDonBaiDang-lookup-table-modal.component";

@Component({
    selector: "createOrEditLichSuGiaoDichModal",
    templateUrl: "./create-or-edit-lichSuGiaoDich-modal.component.html",
})
export class CreateOrEditLichSuGiaoDichModalComponent extends AppComponentBase {
    @ViewChild("createOrEditModal", { static: true }) modal: ModalDirective;
    @ViewChild("lichSuGiaoDichUserLookupTableModal", { static: true })
    lichSuGiaoDichUserLookupTableModal: LichSuGiaoDichUserLookupTableModalComponent;
    @ViewChild("lichSuGiaoDichChiTietHoaDonBaiDangLookupTableModal", { static: true })
    lichSuGiaoDichChiTietHoaDonBaiDangLookupTableModal: LichSuGiaoDichChiTietHoaDonBaiDangLookupTableModalComponent;
    @ViewChild("lichSuGiaoDichUserLookupTableModal2", { static: true })
    lichSuGiaoDichUserLookupTableModal2: LichSuGiaoDichUserLookupTableModalComponent;

    @Output() modalSave: EventEmitter<any> = new EventEmitter<any>();

    active = false;
    saving = false;

    lichSuGiaoDich: CreateOrEditLichSuGiaoDichDto = new CreateOrEditLichSuGiaoDichDto();

    userName = "";
    chiTietHoaDonBaiDangGhiChu = "";
    userName2 = "";

    constructor(injector: Injector, private _lichSuGiaoDichsServiceProxy: LichSuGiaoDichsServiceProxy, private _dateTimeService: DateTimeService) {
        super(injector);
    }

    show(lichSuGiaoDichId?: string): void {
        if (!lichSuGiaoDichId) {
            this.lichSuGiaoDich = new CreateOrEditLichSuGiaoDichDto();
            this.lichSuGiaoDich.id = lichSuGiaoDichId;
            this.lichSuGiaoDich.thoiDiem = this._dateTimeService.getStartOfDay();
            this.userName = "";
            this.chiTietHoaDonBaiDangGhiChu = "";
            this.userName2 = "";

            this.active = true;
            this.modal.show();
        } else {
            this._lichSuGiaoDichsServiceProxy.getLichSuGiaoDichForEdit(lichSuGiaoDichId).subscribe((result) => {
                this.lichSuGiaoDich = result.lichSuGiaoDich;

                this.userName = result.userName;
                this.chiTietHoaDonBaiDangGhiChu = result.chiTietHoaDonBaiDangGhiChu;
                this.userName2 = result.userName2;

                this.active = true;
                this.modal.show();
            });
        }
    }

    save(): void {
        this.saving = true;

        this._lichSuGiaoDichsServiceProxy
            .createOrEdit(this.lichSuGiaoDich)
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

    openSelectUserModal() {
        this.lichSuGiaoDichUserLookupTableModal.id = this.lichSuGiaoDich.userId;
        this.lichSuGiaoDichUserLookupTableModal.displayName = this.userName;
        this.lichSuGiaoDichUserLookupTableModal.show();
    }
    openSelectChiTietHoaDonBaiDangModal() {
        this.lichSuGiaoDichChiTietHoaDonBaiDangLookupTableModal.id = this.lichSuGiaoDich.chiTietHoaDonBaiDangId;
        this.lichSuGiaoDichChiTietHoaDonBaiDangLookupTableModal.displayName = this.chiTietHoaDonBaiDangGhiChu;
        this.lichSuGiaoDichChiTietHoaDonBaiDangLookupTableModal.show();
    }
    openSelectUserModal2() {
        this.lichSuGiaoDichUserLookupTableModal2.id = this.lichSuGiaoDich.kiemDuyetVienId;
        this.lichSuGiaoDichUserLookupTableModal2.displayName = this.userName;
        this.lichSuGiaoDichUserLookupTableModal2.show();
    }

    setUserIdNull() {
        this.lichSuGiaoDich.userId = null;
        this.userName = "";
    }
    setChiTietHoaDonBaiDangIdNull() {
        this.lichSuGiaoDich.chiTietHoaDonBaiDangId = null;
        this.chiTietHoaDonBaiDangGhiChu = "";
    }
    setKiemDuyetVienIdNull() {
        this.lichSuGiaoDich.kiemDuyetVienId = null;
        this.userName2 = "";
    }

    getNewUserId() {
        this.lichSuGiaoDich.userId = this.lichSuGiaoDichUserLookupTableModal.id;
        this.userName = this.lichSuGiaoDichUserLookupTableModal.displayName;
    }
    getNewChiTietHoaDonBaiDangId() {
        this.lichSuGiaoDich.chiTietHoaDonBaiDangId = this.lichSuGiaoDichChiTietHoaDonBaiDangLookupTableModal.id;
        this.chiTietHoaDonBaiDangGhiChu = this.lichSuGiaoDichChiTietHoaDonBaiDangLookupTableModal.displayName;
    }
    getNewKiemDuyetVienId() {
        this.lichSuGiaoDich.kiemDuyetVienId = this.lichSuGiaoDichUserLookupTableModal2.id;
        this.userName2 = this.lichSuGiaoDichUserLookupTableModal2.displayName;
    }

    close(): void {
        this.active = false;
        this.modal.hide();
    }
}
