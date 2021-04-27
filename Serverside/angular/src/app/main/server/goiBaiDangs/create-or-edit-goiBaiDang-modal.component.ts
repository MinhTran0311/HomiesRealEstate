import { Component, ViewChild, Injector, Output, EventEmitter } from "@angular/core";
import { ModalDirective } from "ngx-bootstrap/modal";
import { finalize } from "rxjs/operators";
import { GoiBaiDangsServiceProxy, CreateOrEditGoiBaiDangDto } from "@shared/service-proxies/service-proxies";
import { AppComponentBase } from "@shared/common/app-component-base";
import { DateTime } from "luxon";

import { DateTimeService } from "@app/shared/common/timing/date-time.service";

@Component({
    selector: "createOrEditGoiBaiDangModal",
    templateUrl: "./create-or-edit-goiBaiDang-modal.component.html",
})
export class CreateOrEditGoiBaiDangModalComponent extends AppComponentBase {
    @ViewChild("createOrEditModal", { static: true }) modal: ModalDirective;

    @Output() modalSave: EventEmitter<any> = new EventEmitter<any>();

    active = false;
    saving = false;

    goiBaiDang: CreateOrEditGoiBaiDangDto = new CreateOrEditGoiBaiDangDto();

    constructor(injector: Injector, private _goiBaiDangsServiceProxy: GoiBaiDangsServiceProxy, private _dateTimeService: DateTimeService) {
        super(injector);
    }

    show(goiBaiDangId?: number): void {
        if (!goiBaiDangId) {
            this.goiBaiDang = new CreateOrEditGoiBaiDangDto();
            this.goiBaiDang.id = goiBaiDangId;

            this.active = true;
            this.modal.show();
        } else {
            this._goiBaiDangsServiceProxy.getGoiBaiDangForEdit(goiBaiDangId).subscribe((result) => {
                this.goiBaiDang = result.goiBaiDang;

                this.active = true;
                this.modal.show();
            });
        }
    }

    save(): void {
        this.saving = true;

        this._goiBaiDangsServiceProxy
            .createOrEdit(this.goiBaiDang)
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
