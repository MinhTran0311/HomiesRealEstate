import { Component, ViewChild, Injector, Output, EventEmitter } from "@angular/core";
import { ModalDirective } from "ngx-bootstrap/modal";
import { finalize } from "rxjs/operators";
import { XasServiceProxy, CreateOrEditXaDto } from "@shared/service-proxies/service-proxies";
import { AppComponentBase } from "@shared/common/app-component-base";
import { DateTime } from "luxon";

import { DateTimeService } from "@app/shared/common/timing/date-time.service";
import { XaHuyenLookupTableModalComponent } from "./xa-huyen-lookup-table-modal.component";

@Component({
    selector: "createOrEditXaModal",
    templateUrl: "./create-or-edit-xa-modal.component.html",
})
export class CreateOrEditXaModalComponent extends AppComponentBase {
    @ViewChild("createOrEditModal", { static: true }) modal: ModalDirective;
    @ViewChild("xaHuyenLookupTableModal", { static: true }) xaHuyenLookupTableModal: XaHuyenLookupTableModalComponent;

    @Output() modalSave: EventEmitter<any> = new EventEmitter<any>();

    active = false;
    saving = false;

    xa: CreateOrEditXaDto = new CreateOrEditXaDto();

    huyenTenHuyen = "";

    constructor(injector: Injector, private _xasServiceProxy: XasServiceProxy, private _dateTimeService: DateTimeService) {
        super(injector);
    }

    show(xaId?: number): void {
        if (!xaId) {
            this.xa = new CreateOrEditXaDto();
            this.xa.id = xaId;
            this.huyenTenHuyen = "";

            this.active = true;
            this.modal.show();
        } else {
            this._xasServiceProxy.getXaForEdit(xaId).subscribe((result) => {
                this.xa = result.xa;

                this.huyenTenHuyen = result.huyenTenHuyen;

                this.active = true;
                this.modal.show();
            });
        }
    }

    save(): void {
        this.saving = true;

        this._xasServiceProxy
            .createOrEdit(this.xa)
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

    openSelectHuyenModal() {
        this.xaHuyenLookupTableModal.id = this.xa.huyenId;
        this.xaHuyenLookupTableModal.displayName = this.huyenTenHuyen;
        this.xaHuyenLookupTableModal.show();
    }

    setHuyenIdNull() {
        this.xa.huyenId = null;
        this.huyenTenHuyen = "";
    }

    getNewHuyenId() {
        this.xa.huyenId = this.xaHuyenLookupTableModal.id;
        this.huyenTenHuyen = this.xaHuyenLookupTableModal.displayName;
    }

    close(): void {
        this.active = false;
        this.modal.hide();
    }
}
