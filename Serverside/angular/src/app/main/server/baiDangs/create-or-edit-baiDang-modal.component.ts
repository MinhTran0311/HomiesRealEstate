import { Component, ViewChild, Injector, Output, EventEmitter } from "@angular/core";
import { ModalDirective } from "ngx-bootstrap/modal";
import { finalize } from "rxjs/operators";
import { BaiDangsServiceProxy, CreateOrEditBaiDangDto } from "@shared/service-proxies/service-proxies";
import { AppComponentBase } from "@shared/common/app-component-base";
import { DateTime } from "luxon";

import { DateTimeService } from "@app/shared/common/timing/date-time.service";
import { BaiDangUserLookupTableModalComponent } from "./baiDang-user-lookup-table-modal.component";
import { BaiDangDanhMucLookupTableModalComponent } from "./baiDang-danhMuc-lookup-table-modal.component";
import { BaiDangXaLookupTableModalComponent } from "./baiDang-xa-lookup-table-modal.component";

@Component({
    selector: "createOrEditBaiDangModal",
    templateUrl: "./create-or-edit-baiDang-modal.component.html",
})
export class CreateOrEditBaiDangModalComponent extends AppComponentBase {
    @ViewChild("createOrEditModal", { static: true }) modal: ModalDirective;
    @ViewChild("baiDangUserLookupTableModal", { static: true }) baiDangUserLookupTableModal: BaiDangUserLookupTableModalComponent;
    @ViewChild("baiDangDanhMucLookupTableModal", { static: true }) baiDangDanhMucLookupTableModal: BaiDangDanhMucLookupTableModalComponent;
    @ViewChild("baiDangXaLookupTableModal", { static: true }) baiDangXaLookupTableModal: BaiDangXaLookupTableModalComponent;

    @Output() modalSave: EventEmitter<any> = new EventEmitter<any>();

    active = false;
    saving = false;

    baiDang: CreateOrEditBaiDangDto = new CreateOrEditBaiDangDto();

    userName = "";
    danhMucTenDanhMuc = "";
    xaTenXa = "";

    constructor(injector: Injector, private _baiDangsServiceProxy: BaiDangsServiceProxy, private _dateTimeService: DateTimeService) {
        super(injector);
    }

    show(baiDangId?: number): void {
        if (!baiDangId) {
            this.baiDang = new CreateOrEditBaiDangDto();
            this.baiDang.id = baiDangId;
            this.baiDang.thoiDiemDang = this._dateTimeService.getStartOfDay();
            this.baiDang.thoiHan = this._dateTimeService.getStartOfDay();
            this.userName = "";
            this.danhMucTenDanhMuc = "";
            this.xaTenXa = "";

            this.active = true;
            this.modal.show();
        } else {
            this._baiDangsServiceProxy.getBaiDangForEdit(baiDangId).subscribe((result) => {
                this.baiDang = result.baiDang;

                this.userName = result.userName;
                this.danhMucTenDanhMuc = result.danhMucTenDanhMuc;
                this.xaTenXa = result.xaTenXa;

                this.active = true;
                this.modal.show();
            });
        }
    }

    save(): void {
        this.saving = true;

        this._baiDangsServiceProxy
            .createOrEdit(this.baiDang)
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
        this.baiDangUserLookupTableModal.id = this.baiDang.userId;
        this.baiDangUserLookupTableModal.displayName = this.userName;
        this.baiDangUserLookupTableModal.show();
    }
    openSelectDanhMucModal() {
        this.baiDangDanhMucLookupTableModal.id = this.baiDang.danhMucId;
        this.baiDangDanhMucLookupTableModal.displayName = this.danhMucTenDanhMuc;
        this.baiDangDanhMucLookupTableModal.show();
    }
    openSelectXaModal() {
        this.baiDangXaLookupTableModal.id = this.baiDang.xaId;
        this.baiDangXaLookupTableModal.displayName = this.xaTenXa;
        this.baiDangXaLookupTableModal.show();
    }

    setUserIdNull() {
        this.baiDang.userId = null;
        this.userName = "";
    }
    setDanhMucIdNull() {
        this.baiDang.danhMucId = null;
        this.danhMucTenDanhMuc = "";
    }
    setXaIdNull() {
        this.baiDang.xaId = null;
        this.xaTenXa = "";
    }

    getNewUserId() {
        this.baiDang.userId = this.baiDangUserLookupTableModal.id;
        this.userName = this.baiDangUserLookupTableModal.displayName;
    }
    getNewDanhMucId() {
        this.baiDang.danhMucId = this.baiDangDanhMucLookupTableModal.id;
        this.danhMucTenDanhMuc = this.baiDangDanhMucLookupTableModal.displayName;
    }
    getNewXaId() {
        this.baiDang.xaId = this.baiDangXaLookupTableModal.id;
        this.xaTenXa = this.baiDangXaLookupTableModal.displayName;
    }

    close(): void {
        this.active = false;
        this.modal.hide();
    }
}
