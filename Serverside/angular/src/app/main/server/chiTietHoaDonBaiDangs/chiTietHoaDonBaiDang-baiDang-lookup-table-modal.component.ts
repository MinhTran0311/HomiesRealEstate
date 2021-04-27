import { Component, ViewChild, Injector, Output, EventEmitter, ViewEncapsulation } from "@angular/core";
import { ModalDirective } from "ngx-bootstrap/modal";
import { ChiTietHoaDonBaiDangsServiceProxy, ChiTietHoaDonBaiDangBaiDangLookupTableDto } from "@shared/service-proxies/service-proxies";
import { AppComponentBase } from "@shared/common/app-component-base";
import { Table } from "primeng/table";
import { Paginator } from "primeng/paginator";
import { LazyLoadEvent } from "primeng/api/public_api";
@Component({
    selector: "chiTietHoaDonBaiDangBaiDangLookupTableModal",
    styleUrls: ["./chiTietHoaDonBaiDang-baiDang-lookup-table-modal.component.less"],
    encapsulation: ViewEncapsulation.None,
    templateUrl: "./chiTietHoaDonBaiDang-baiDang-lookup-table-modal.component.html",
})
export class ChiTietHoaDonBaiDangBaiDangLookupTableModalComponent extends AppComponentBase {
    @ViewChild("createOrEditModal", { static: true }) modal: ModalDirective;
    @ViewChild("dataTable", { static: true }) dataTable: Table;
    @ViewChild("paginator", { static: true }) paginator: Paginator;

    filterText = "";
    id: number;
    displayName: string;

    @Output() modalSave: EventEmitter<any> = new EventEmitter<any>();
    active = false;
    saving = false;

    constructor(injector: Injector, private _chiTietHoaDonBaiDangsServiceProxy: ChiTietHoaDonBaiDangsServiceProxy) {
        super(injector);
    }

    show(): void {
        this.active = true;
        this.paginator.rows = 5;
        this.getAll();
        this.modal.show();
    }

    getAll(event?: LazyLoadEvent) {
        if (!this.active) {
            return;
        }

        if (this.primengTableHelper.shouldResetPaging(event)) {
            this.paginator.changePage(0);
            return;
        }

        this.primengTableHelper.showLoadingIndicator();

        this._chiTietHoaDonBaiDangsServiceProxy
            .getAllBaiDangForLookupTable(
                this.filterText,
                this.primengTableHelper.getSorting(this.dataTable),
                this.primengTableHelper.getSkipCount(this.paginator, event),
                this.primengTableHelper.getMaxResultCount(this.paginator, event)
            )
            .subscribe((result) => {
                this.primengTableHelper.totalRecordsCount = result.totalCount;
                this.primengTableHelper.records = result.items;
                this.primengTableHelper.hideLoadingIndicator();
            });
    }

    reloadPage(): void {
        this.paginator.changePage(this.paginator.getPage());
    }

    setAndSave(baiDang: ChiTietHoaDonBaiDangBaiDangLookupTableDto) {
        this.id = baiDang.id;
        this.displayName = baiDang.displayName;
        this.active = false;
        this.modal.hide();
        this.modalSave.emit(null);
    }

    close(): void {
        this.active = false;
        this.modal.hide();
        this.modalSave.emit(null);
    }
}
