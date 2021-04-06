import { Component, ViewChild, Injector, Output, EventEmitter } from "@angular/core";
import { ModalDirective } from "ngx-bootstrap/modal";
import { GetChiTietHoaDonBaiDangForViewDto, ChiTietHoaDonBaiDangDto } from "@shared/service-proxies/service-proxies";
import { AppComponentBase } from "@shared/common/app-component-base";

@Component({
    selector: "viewChiTietHoaDonBaiDangModal",
    templateUrl: "./view-chiTietHoaDonBaiDang-modal.component.html",
})
export class ViewChiTietHoaDonBaiDangModalComponent extends AppComponentBase {
    @ViewChild("createOrEditModal", { static: true }) modal: ModalDirective;
    @Output() modalSave: EventEmitter<any> = new EventEmitter<any>();

    active = false;
    saving = false;

    item: GetChiTietHoaDonBaiDangForViewDto;

    constructor(injector: Injector) {
        super(injector);
        this.item = new GetChiTietHoaDonBaiDangForViewDto();
        this.item.chiTietHoaDonBaiDang = new ChiTietHoaDonBaiDangDto();
    }

    show(item: GetChiTietHoaDonBaiDangForViewDto): void {
        this.item = item;
        this.active = true;
        this.modal.show();
    }

    close(): void {
        this.active = false;
        this.modal.hide();
    }
}
