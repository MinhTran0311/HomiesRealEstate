import { Component, ViewChild, Injector, Output, EventEmitter, ViewEncapsulation } from "@angular/core";
import { ModalDirective } from "ngx-bootstrap/modal";
import { BaiDangsServiceProxy, BaiDangDanhMucLookupTableDto } from "@shared/service-proxies/service-proxies";
import { AppComponentBase } from "@shared/common/app-component-base";
import { Table } from "primeng/table";
import { Paginator } from "primeng/paginator";
import { LazyLoadEvent } from "primeng/public_api";
@Component({
    selector: "baiDangDanhMucLookupTableModal",
    styleUrls: ["./baiDang-danhMuc-lookup-table-modal.component.less"],
    encapsulation: ViewEncapsulation.None,
    templateUrl: "./baiDang-danhMuc-lookup-table-modal.component.html",
})
export class BaiDangDanhMucLookupTableModalComponent extends AppComponentBase {
    @ViewChild("createOrEditModal", { static: true }) modal: ModalDirective;
    @ViewChild("dataTable", { static: true }) dataTable: Table;
    @ViewChild("paginator", { static: true }) paginator: Paginator;

    filterText = "";
    id: number;
    displayName: string;

    @Output() modalSave: EventEmitter<any> = new EventEmitter<any>();
    active = false;
    saving = false;

    constructor(injector: Injector, private _baiDangsServiceProxy: BaiDangsServiceProxy) {
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

        this._baiDangsServiceProxy
            .getAllDanhMucForLookupTable(
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

    setAndSave(danhMuc: BaiDangDanhMucLookupTableDto) {
        this.id = danhMuc.id;
        this.displayName = danhMuc.displayName;
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
