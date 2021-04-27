import { Component, ViewChild, Injector, Output, EventEmitter } from "@angular/core";
import { ModalDirective } from "ngx-bootstrap/modal";
import { finalize } from "rxjs/operators";
import { HinhAnhsServiceProxy, CreateOrEditHinhAnhDto } from "@shared/service-proxies/service-proxies";
import { AppComponentBase } from "@shared/common/app-component-base";
import { DateTime } from "luxon";

import { DateTimeService } from "@app/shared/common/timing/date-time.service";
import { HinhAnhBaiDangLookupTableModalComponent } from "./hinhAnh-baiDang-lookup-table-modal.component";

@Component({
    selector: "createOrEditHinhAnhModal",
    templateUrl: "./create-or-edit-hinhAnh-modal.component.html",
})
export class CreateOrEditHinhAnhModalComponent extends AppComponentBase {
    @ViewChild("createOrEditModal", { static: true }) modal: ModalDirective;
    @ViewChild("hinhAnhBaiDangLookupTableModal", { static: true }) hinhAnhBaiDangLookupTableModal: HinhAnhBaiDangLookupTableModalComponent;

    @Output() modalSave: EventEmitter<any> = new EventEmitter<any>();

    active = false;
    saving = false;

    hinhAnh: CreateOrEditHinhAnhDto = new CreateOrEditHinhAnhDto();

    baiDangTieuDe = "";

    constructor(injector: Injector, private _hinhAnhsServiceProxy: HinhAnhsServiceProxy, private _dateTimeService: DateTimeService) {
        super(injector);
    }

    show(hinhAnhId?: number): void {
        if (!hinhAnhId) {
            this.hinhAnh = new CreateOrEditHinhAnhDto();
            this.hinhAnh.id = hinhAnhId;
            this.baiDangTieuDe = "";

            this.active = true;
            this.modal.show();
        } else {
            this._hinhAnhsServiceProxy.getHinhAnhForEdit(hinhAnhId).subscribe((result) => {
                this.hinhAnh = result.hinhAnh;

                this.baiDangTieuDe = result.baiDangTieuDe;

                this.active = true;
                this.modal.show();
            });
        }
    }

    save(): void {
        this.saving = true;

        this._hinhAnhsServiceProxy
            .createOrEdit(this.hinhAnh)
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
        this.hinhAnhBaiDangLookupTableModal.id = this.hinhAnh.baiDangId;
        this.hinhAnhBaiDangLookupTableModal.displayName = this.baiDangTieuDe;
        this.hinhAnhBaiDangLookupTableModal.show();
    }

    setBaiDangIdNull() {
        this.hinhAnh.baiDangId = null;
        this.baiDangTieuDe = "";
    }

    getNewBaiDangId() {
        this.hinhAnh.baiDangId = this.hinhAnhBaiDangLookupTableModal.id;
        this.baiDangTieuDe = this.hinhAnhBaiDangLookupTableModal.displayName;
    }

    close(): void {
        this.active = false;
        this.modal.hide();
    }
}
