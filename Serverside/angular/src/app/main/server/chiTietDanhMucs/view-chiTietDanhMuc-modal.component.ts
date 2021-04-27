import { Component, ViewChild, Injector, Output, EventEmitter } from "@angular/core";
import { ModalDirective } from "ngx-bootstrap/modal";
import { GetChiTietDanhMucForViewDto, ChiTietDanhMucDto } from "@shared/service-proxies/service-proxies";
import { AppComponentBase } from "@shared/common/app-component-base";

@Component({
    selector: "viewChiTietDanhMucModal",
    templateUrl: "./view-chiTietDanhMuc-modal.component.html",
})
export class ViewChiTietDanhMucModalComponent extends AppComponentBase {
    @ViewChild("createOrEditModal", { static: true }) modal: ModalDirective;
    @Output() modalSave: EventEmitter<any> = new EventEmitter<any>();

    active = false;
    saving = false;

    item: GetChiTietDanhMucForViewDto;

    constructor(injector: Injector) {
        super(injector);
        this.item = new GetChiTietDanhMucForViewDto();
        this.item.chiTietDanhMuc = new ChiTietDanhMucDto();
    }

    show(item: GetChiTietDanhMucForViewDto): void {
        this.item = item;
        this.active = true;
        this.modal.show();
    }

    close(): void {
        this.active = false;
        this.modal.hide();
    }
}
