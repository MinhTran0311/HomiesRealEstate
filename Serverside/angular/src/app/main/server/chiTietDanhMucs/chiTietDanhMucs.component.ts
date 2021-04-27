import { Component, Injector, ViewEncapsulation, ViewChild } from "@angular/core";
import { ActivatedRoute, Router } from "@angular/router";
import { ChiTietDanhMucsServiceProxy, ChiTietDanhMucDto } from "@shared/service-proxies/service-proxies";
import { NotifyService } from "abp-ng2-module";
import { AppComponentBase } from "@shared/common/app-component-base";
import { TokenAuthServiceProxy } from "@shared/service-proxies/service-proxies";
import { CreateOrEditChiTietDanhMucModalComponent } from "./create-or-edit-chiTietDanhMuc-modal.component";

import { ViewChiTietDanhMucModalComponent } from "./view-chiTietDanhMuc-modal.component";
import { appModuleAnimation } from "@shared/animations/routerTransition";
import { Table } from "primeng/table";
import { Paginator } from "primeng/paginator";
import { LazyLoadEvent } from "primeng/api/public_api";
import { FileDownloadService } from "@shared/utils/file-download.service";
import { filter as _filter } from "lodash-es";
import { DateTime } from "luxon";

import { DateTimeService } from "@app/shared/common/timing/date-time.service";

@Component({
    templateUrl: "./chiTietDanhMucs.component.html",
    encapsulation: ViewEncapsulation.None,
    animations: [appModuleAnimation()],
})
export class ChiTietDanhMucsComponent extends AppComponentBase {
    @ViewChild("createOrEditChiTietDanhMucModal", { static: true }) createOrEditChiTietDanhMucModal: CreateOrEditChiTietDanhMucModalComponent;
    @ViewChild("viewChiTietDanhMucModalComponent", { static: true }) viewChiTietDanhMucModal: ViewChiTietDanhMucModalComponent;

    @ViewChild("dataTable", { static: true }) dataTable: Table;
    @ViewChild("paginator", { static: true }) paginator: Paginator;

    advancedFiltersAreShown = false;
    filterText = "";
    ghiChuFilter = "";
    thuocTinhTenThuocTinhFilter = "";
    danhMucTenDanhMucFilter = "";

    constructor(
        injector: Injector,
        private _chiTietDanhMucsServiceProxy: ChiTietDanhMucsServiceProxy,
        private _notifyService: NotifyService,
        private _tokenAuth: TokenAuthServiceProxy,
        private _activatedRoute: ActivatedRoute,
        private _fileDownloadService: FileDownloadService,
        private _dateTimeService: DateTimeService
    ) {
        super(injector);
    }

    getChiTietDanhMucs(event?: LazyLoadEvent) {
        if (this.primengTableHelper.shouldResetPaging(event)) {
            this.paginator.changePage(0);
            return;
        }

        this.primengTableHelper.showLoadingIndicator();

        this._chiTietDanhMucsServiceProxy
            .getAll(
                this.filterText,
                this.ghiChuFilter,
                this.thuocTinhTenThuocTinhFilter,
                this.danhMucTenDanhMucFilter,
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

    createChiTietDanhMuc(): void {
        this.createOrEditChiTietDanhMucModal.show();
    }

    deleteChiTietDanhMuc(chiTietDanhMuc: ChiTietDanhMucDto): void {
        this.message.confirm("", this.l("AreYouSure"), (isConfirmed) => {
            if (isConfirmed) {
                this._chiTietDanhMucsServiceProxy.delete(chiTietDanhMuc.id).subscribe(() => {
                    this.reloadPage();
                    this.notify.success(this.l("SuccessfullyDeleted"));
                });
            }
        });
    }

    exportToExcel(): void {
        this._chiTietDanhMucsServiceProxy
            .getChiTietDanhMucsToExcel(this.filterText, this.ghiChuFilter, this.thuocTinhTenThuocTinhFilter, this.danhMucTenDanhMucFilter)
            .subscribe((result) => {
                this._fileDownloadService.downloadTempFile(result);
            });
    }
}
