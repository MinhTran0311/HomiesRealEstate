import { Component, ViewChild, Injector, Output, EventEmitter } from "@angular/core";
import { ModalDirective } from "ngx-bootstrap/modal";
import { GetHuyenForViewDto, HuyenDto } from "@shared/service-proxies/service-proxies";
import { AppComponentBase } from "@shared/common/app-component-base";

@Component({
    selector: "viewHuyenModal",
    templateUrl: "./view-huyen-modal.component.html",
})
export class ViewHuyenModalComponent extends AppComponentBase {
    @ViewChild("createOrEditModal", { static: true }) modal: ModalDirective;
    @Output() modalSave: EventEmitter<any> = new EventEmitter<any>();

    active = false;
    saving = false;

    item: GetHuyenForViewDto;

    constructor(injector: Injector) {
        super(injector);
        this.item = new GetHuyenForViewDto();
        this.item.huyen = new HuyenDto();
    }

    show(item: GetHuyenForViewDto): void {
        this.item = item;
        this.active = true;
        this.modal.show();
    }

    close(): void {
        this.active = false;
        this.modal.hide();
    }
}
