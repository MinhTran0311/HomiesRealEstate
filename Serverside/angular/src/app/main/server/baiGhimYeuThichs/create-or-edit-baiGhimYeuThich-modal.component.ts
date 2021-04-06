import { Component, ViewChild, Injector, Output, EventEmitter } from "@angular/core";
import { ModalDirective } from "ngx-bootstrap/modal";
import { finalize } from "rxjs/operators";
import { BaiGhimYeuThichsServiceProxy, CreateOrEditBaiGhimYeuThichDto } from "@shared/service-proxies/service-proxies";
import { AppComponentBase } from "@shared/common/app-component-base";
import { DateTime } from "luxon";

import { DateTimeService } from "@app/shared/common/timing/date-time.service";
import { BaiGhimYeuThichUserLookupTableModalComponent } from "./baiGhimYeuThich-user-lookup-table-modal.component";
import { BaiGhimYeuThichBaiDangLookupTableModalComponent } from "./baiGhimYeuThich-baiDang-lookup-table-modal.component";

@Component({
    selector: "createOrEditBaiGhimYeuThichModal",
    templateUrl: "./create-or-edit-baiGhimYeuThich-modal.component.html",
})
export class CreateOrEditBaiGhimYeuThichModalComponent extends AppComponentBase {
    @ViewChild("createOrEditModal", { static: true }) modal: ModalDirective;
    @ViewChild("baiGhimYeuThichUserLookupTableModal", { static: true })
    baiGhimYeuThichUserLookupTableModal: BaiGhimYeuThichUserLookupTableModalComponent;
    @ViewChild("baiGhimYeuThichBaiDangLookupTableModal", { static: true })
    baiGhimYeuThichBaiDangLookupTableModal: BaiGhimYeuThichBaiDangLookupTableModalComponent;

    @Output() modalSave: EventEmitter<any> = new EventEmitter<any>();

    active = false;
    saving = false;

    baiGhimYeuThich: CreateOrEditBaiGhimYeuThichDto = new CreateOrEditBaiGhimYeuThichDto();

    userName = "";
    baiDangTieuDe = "";

    constructor(injector: Injector, private _baiGhimYeuThichsServiceProxy: BaiGhimYeuThichsServiceProxy, private _dateTimeService: DateTimeService) {
        super(injector);
    }

    show(baiGhimYeuThichId?: number): void {
        if (!baiGhimYeuThichId) {
            this.baiGhimYeuThich = new CreateOrEditBaiGhimYeuThichDto();
            this.baiGhimYeuThich.id = baiGhimYeuThichId;
            this.baiGhimYeuThich.thoiGian = this._dateTimeService.getStartOfDay();
            this.userName = "";
            this.baiDangTieuDe = "";

            this.active = true;
            this.modal.show();
        } else {
            this._baiGhimYeuThichsServiceProxy.getBaiGhimYeuThichForEdit(baiGhimYeuThichId).subscribe((result) => {
                this.baiGhimYeuThich = result.baiGhimYeuThich;

                this.userName = result.userName;
                this.baiDangTieuDe = result.baiDangTieuDe;

                this.active = true;
                this.modal.show();
            });
        }
    }

    save(): void {
        this.saving = true;

        this._baiGhimYeuThichsServiceProxy
            .createOrEdit(this.baiGhimYeuThich)
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
        this.baiGhimYeuThichUserLookupTableModal.id = this.baiGhimYeuThich.userId;
        this.baiGhimYeuThichUserLookupTableModal.displayName = this.userName;
        this.baiGhimYeuThichUserLookupTableModal.show();
    }
    openSelectBaiDangModal() {
        this.baiGhimYeuThichBaiDangLookupTableModal.id = this.baiGhimYeuThich.baiDangId;
        this.baiGhimYeuThichBaiDangLookupTableModal.displayName = this.baiDangTieuDe;
        this.baiGhimYeuThichBaiDangLookupTableModal.show();
    }

    setUserIdNull() {
        this.baiGhimYeuThich.userId = null;
        this.userName = "";
    }
    setBaiDangIdNull() {
        this.baiGhimYeuThich.baiDangId = null;
        this.baiDangTieuDe = "";
    }

    getNewUserId() {
        this.baiGhimYeuThich.userId = this.baiGhimYeuThichUserLookupTableModal.id;
        this.userName = this.baiGhimYeuThichUserLookupTableModal.displayName;
    }
    getNewBaiDangId() {
        this.baiGhimYeuThich.baiDangId = this.baiGhimYeuThichBaiDangLookupTableModal.id;
        this.baiDangTieuDe = this.baiGhimYeuThichBaiDangLookupTableModal.displayName;
    }

    close(): void {
        this.active = false;
        this.modal.hide();
    }
}
