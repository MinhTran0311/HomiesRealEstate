import { Component, ViewChild, Injector, Output, EventEmitter } from "@angular/core";
import { ModalDirective } from "ngx-bootstrap/modal";
import { GetChiTietBaiDangForViewDto, ChiTietBaiDangDto } from "@shared/service-proxies/service-proxies";
import { AppComponentBase } from "@shared/common/app-component-base";

@Component({
    selector: "viewChiTietBaiDangModal",
    templateUrl: "./view-chiTietBaiDang-modal.component.html",
})
export class ViewChiTietBaiDangModalComponent extends AppComponentBase {
    @ViewChild("createOrEditModal", { static: true }) modal: ModalDirective;
    @Output() modalSave: EventEmitter<any> = new EventEmitter<any>();

    active = false;
    saving = false;

    item: GetChiTietBaiDangForViewDto;

    constructor(injector: Injector) {
        super(injector);
        this.item = new GetChiTietBaiDangForViewDto();
        this.item.chiTietBaiDang = new ChiTietBaiDangDto();
    }

    show(item: GetChiTietBaiDangForViewDto): void {
        this.item = item;
        this.active = true;
        this.modal.show();
    }

    close(): void {
        this.active = false;
        this.modal.hide();
    }
}
