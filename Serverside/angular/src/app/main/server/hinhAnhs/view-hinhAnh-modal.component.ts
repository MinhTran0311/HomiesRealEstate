import { Component, ViewChild, Injector, Output, EventEmitter } from "@angular/core";
import { ModalDirective } from "ngx-bootstrap/modal";
import { GetHinhAnhForViewDto, HinhAnhDto } from "@shared/service-proxies/service-proxies";
import { AppComponentBase } from "@shared/common/app-component-base";

@Component({
    selector: "viewHinhAnhModal",
    templateUrl: "./view-hinhAnh-modal.component.html",
})
export class ViewHinhAnhModalComponent extends AppComponentBase {
    @ViewChild("createOrEditModal", { static: true }) modal: ModalDirective;
    @Output() modalSave: EventEmitter<any> = new EventEmitter<any>();

    active = false;
    saving = false;

    item: GetHinhAnhForViewDto;

    constructor(injector: Injector) {
        super(injector);
        this.item = new GetHinhAnhForViewDto();
        this.item.hinhAnh = new HinhAnhDto();
    }

    show(item: GetHinhAnhForViewDto): void {
        this.item = item;
        this.active = true;
        this.modal.show();
    }

    close(): void {
        this.active = false;
        this.modal.hide();
    }
}
