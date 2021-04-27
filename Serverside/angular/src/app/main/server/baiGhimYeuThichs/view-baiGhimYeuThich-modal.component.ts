import { Component, ViewChild, Injector, Output, EventEmitter } from "@angular/core";
import { ModalDirective } from "ngx-bootstrap/modal";
import { GetBaiGhimYeuThichForViewDto, BaiGhimYeuThichDto } from "@shared/service-proxies/service-proxies";
import { AppComponentBase } from "@shared/common/app-component-base";

@Component({
    selector: "viewBaiGhimYeuThichModal",
    templateUrl: "./view-baiGhimYeuThich-modal.component.html",
})
export class ViewBaiGhimYeuThichModalComponent extends AppComponentBase {
    @ViewChild("createOrEditModal", { static: true }) modal: ModalDirective;
    @Output() modalSave: EventEmitter<any> = new EventEmitter<any>();

    active = false;
    saving = false;

    item: GetBaiGhimYeuThichForViewDto;

    constructor(injector: Injector) {
        super(injector);
        this.item = new GetBaiGhimYeuThichForViewDto();
        this.item.baiGhimYeuThich = new BaiGhimYeuThichDto();
    }

    show(item: GetBaiGhimYeuThichForViewDto): void {
        this.item = item;
        this.active = true;
        this.modal.show();
    }

    close(): void {
        this.active = false;
        this.modal.hide();
    }
}
