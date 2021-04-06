import { Component, ViewChild, Injector, Output, EventEmitter } from "@angular/core";
import { ModalDirective } from "ngx-bootstrap/modal";
import { GetLichSuGiaoDichForViewDto, LichSuGiaoDichDto } from "@shared/service-proxies/service-proxies";
import { AppComponentBase } from "@shared/common/app-component-base";

@Component({
    selector: "viewLichSuGiaoDichModal",
    templateUrl: "./view-lichSuGiaoDich-modal.component.html",
})
export class ViewLichSuGiaoDichModalComponent extends AppComponentBase {
    @ViewChild("createOrEditModal", { static: true }) modal: ModalDirective;
    @Output() modalSave: EventEmitter<any> = new EventEmitter<any>();

    active = false;
    saving = false;

    item: GetLichSuGiaoDichForViewDto;

    constructor(injector: Injector) {
        super(injector);
        this.item = new GetLichSuGiaoDichForViewDto();
        this.item.lichSuGiaoDich = new LichSuGiaoDichDto();
    }

    show(item: GetLichSuGiaoDichForViewDto): void {
        this.item = item;
        this.active = true;
        this.modal.show();
    }

    close(): void {
        this.active = false;
        this.modal.hide();
    }
}
