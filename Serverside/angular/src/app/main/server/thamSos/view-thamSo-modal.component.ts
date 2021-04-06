import { Component, ViewChild, Injector, Output, EventEmitter } from "@angular/core";
import { ModalDirective } from "ngx-bootstrap/modal";
import { GetThamSoForViewDto, ThamSoDto } from "@shared/service-proxies/service-proxies";
import { AppComponentBase } from "@shared/common/app-component-base";

@Component({
    selector: "viewThamSoModal",
    templateUrl: "./view-thamSo-modal.component.html",
})
export class ViewThamSoModalComponent extends AppComponentBase {
    @ViewChild("createOrEditModal", { static: true }) modal: ModalDirective;
    @Output() modalSave: EventEmitter<any> = new EventEmitter<any>();

    active = false;
    saving = false;

    item: GetThamSoForViewDto;

    constructor(injector: Injector) {
        super(injector);
        this.item = new GetThamSoForViewDto();
        this.item.thamSo = new ThamSoDto();
    }

    show(item: GetThamSoForViewDto): void {
        this.item = item;
        this.active = true;
        this.modal.show();
    }

    close(): void {
        this.active = false;
        this.modal.hide();
    }
}
