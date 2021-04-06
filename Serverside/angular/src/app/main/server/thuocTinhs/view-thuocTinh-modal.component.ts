import { Component, ViewChild, Injector, Output, EventEmitter } from "@angular/core";
import { ModalDirective } from "ngx-bootstrap/modal";
import { GetThuocTinhForViewDto, ThuocTinhDto } from "@shared/service-proxies/service-proxies";
import { AppComponentBase } from "@shared/common/app-component-base";

@Component({
    selector: "viewThuocTinhModal",
    templateUrl: "./view-thuocTinh-modal.component.html",
})
export class ViewThuocTinhModalComponent extends AppComponentBase {
    @ViewChild("createOrEditModal", { static: true }) modal: ModalDirective;
    @Output() modalSave: EventEmitter<any> = new EventEmitter<any>();

    active = false;
    saving = false;

    item: GetThuocTinhForViewDto;

    constructor(injector: Injector) {
        super(injector);
        this.item = new GetThuocTinhForViewDto();
        this.item.thuocTinh = new ThuocTinhDto();
    }

    show(item: GetThuocTinhForViewDto): void {
        this.item = item;
        this.active = true;
        this.modal.show();
    }

    close(): void {
        this.active = false;
        this.modal.hide();
    }
}
