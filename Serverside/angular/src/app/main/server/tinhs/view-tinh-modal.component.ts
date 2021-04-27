import { Component, ViewChild, Injector, Output, EventEmitter } from "@angular/core";
import { ModalDirective } from "ngx-bootstrap/modal";
import { GetTinhForViewDto, TinhDto } from "@shared/service-proxies/service-proxies";
import { AppComponentBase } from "@shared/common/app-component-base";

@Component({
    selector: "viewTinhModal",
    templateUrl: "./view-tinh-modal.component.html",
})
export class ViewTinhModalComponent extends AppComponentBase {
    @ViewChild("createOrEditModal", { static: true }) modal: ModalDirective;
    @Output() modalSave: EventEmitter<any> = new EventEmitter<any>();

    active = false;
    saving = false;

    item: GetTinhForViewDto;

    constructor(injector: Injector) {
        super(injector);
        this.item = new GetTinhForViewDto();
        this.item.tinh = new TinhDto();
    }

    show(item: GetTinhForViewDto): void {
        this.item = item;
        this.active = true;
        this.modal.show();
    }

    close(): void {
        this.active = false;
        this.modal.hide();
    }
}
