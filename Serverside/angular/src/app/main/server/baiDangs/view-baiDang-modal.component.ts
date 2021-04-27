import { Component, ViewChild, Injector, Output, EventEmitter } from "@angular/core";
import { ModalDirective } from "ngx-bootstrap/modal";
import { GetBaiDangForViewDto, BaiDangDto } from "@shared/service-proxies/service-proxies";
import { AppComponentBase } from "@shared/common/app-component-base";

@Component({
    selector: "viewBaiDangModal",
    templateUrl: "./view-baiDang-modal.component.html",
})
export class ViewBaiDangModalComponent extends AppComponentBase {
    @ViewChild("createOrEditModal", { static: true }) modal: ModalDirective;
    @Output() modalSave: EventEmitter<any> = new EventEmitter<any>();

    active = false;
    saving = false;

    item: GetBaiDangForViewDto;

    constructor(injector: Injector) {
        super(injector);
        this.item = new GetBaiDangForViewDto();
        this.item.baiDang = new BaiDangDto();
    }

    show(item: GetBaiDangForViewDto): void {
        this.item = item;
        this.active = true;
        this.modal.show();
    }

    close(): void {
        this.active = false;
        this.modal.hide();
    }
}
