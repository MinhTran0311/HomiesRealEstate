import { Component, ViewChild, Injector, Output, EventEmitter } from "@angular/core";
import { ModalDirective } from "ngx-bootstrap/modal";
import { GetGoiBaiDangForViewDto, GoiBaiDangDto } from "@shared/service-proxies/service-proxies";
import { AppComponentBase } from "@shared/common/app-component-base";

@Component({
    selector: "viewGoiBaiDangModal",
    templateUrl: "./view-goiBaiDang-modal.component.html",
})
export class ViewGoiBaiDangModalComponent extends AppComponentBase {
    @ViewChild("createOrEditModal", { static: true }) modal: ModalDirective;
    @Output() modalSave: EventEmitter<any> = new EventEmitter<any>();

    active = false;
    saving = false;

    item: GetGoiBaiDangForViewDto;

    constructor(injector: Injector) {
        super(injector);
        this.item = new GetGoiBaiDangForViewDto();
        this.item.goiBaiDang = new GoiBaiDangDto();
    }

    show(item: GetGoiBaiDangForViewDto): void {
        this.item = item;
        this.active = true;
        this.modal.show();
    }

    close(): void {
        this.active = false;
        this.modal.hide();
    }
}
