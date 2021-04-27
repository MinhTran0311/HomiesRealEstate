import { Component, ViewChild, Injector, Output, EventEmitter } from "@angular/core";
import { ModalDirective } from "ngx-bootstrap/modal";
import { GetDanhMucForViewDto, DanhMucDto } from "@shared/service-proxies/service-proxies";
import { AppComponentBase } from "@shared/common/app-component-base";

@Component({
    selector: "viewDanhMucModal",
    templateUrl: "./view-danhMuc-modal.component.html",
})
export class ViewDanhMucModalComponent extends AppComponentBase {
    @ViewChild("createOrEditModal", { static: true }) modal: ModalDirective;
    @Output() modalSave: EventEmitter<any> = new EventEmitter<any>();

    active = false;
    saving = false;

    item: GetDanhMucForViewDto;

    constructor(injector: Injector) {
        super(injector);
        this.item = new GetDanhMucForViewDto();
        this.item.danhMuc = new DanhMucDto();
    }

    show(item: GetDanhMucForViewDto): void {
        this.item = item;
        this.active = true;
        this.modal.show();
    }

    close(): void {
        this.active = false;
        this.modal.hide();
    }
}
