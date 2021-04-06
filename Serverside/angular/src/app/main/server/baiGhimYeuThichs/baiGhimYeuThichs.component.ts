import { Component, Injector, ViewEncapsulation, ViewChild } from "@angular/core";
import { ActivatedRoute, Router } from "@angular/router";
import { BaiGhimYeuThichsServiceProxy, BaiGhimYeuThichDto } from "@shared/service-proxies/service-proxies";
import { NotifyService } from "abp-ng2-module";
import { AppComponentBase } from "@shared/common/app-component-base";
import { TokenAuthServiceProxy } from "@shared/service-proxies/service-proxies";
import { CreateOrEditBaiGhimYeuThichModalComponent } from "./create-or-edit-baiGhimYeuThich-modal.component";

import { ViewBaiGhimYeuThichModalComponent } from "./view-baiGhimYeuThich-modal.component";
import { appModuleAnimation } from "@shared/animations/routerTransition";
import { Table } from "primeng/table";
import { Paginator } from "primeng/paginator";
import { LazyLoadEvent } from "primeng/public_api";
import { FileDownloadService } from "@shared/utils/file-download.service";
import { filter as _filter } from "lodash-es";
import { DateTime } from "luxon";

import { DateTimeService } from "@app/shared/common/timing/date-time.service";

@Component({
    templateUrl: "./baiGhimYeuThichs.component.html",
    encapsulation: ViewEncapsulation.None,
    animations: [appModuleAnimation()],
})
export class BaiGhimYeuThichsComponent extends AppComponentBase {
    @ViewChild("createOrEditBaiGhimYeuThichModal", { static: true }) createOrEditBaiGhimYeuThichModal: CreateOrEditBaiGhimYeuThichModalComponent;
    @ViewChild("viewBaiGhimYeuThichModalComponent", { static: true }) viewBaiGhimYeuThichModal: ViewBaiGhimYeuThichModalComponent;

    @ViewChild("dataTable", { static: true }) dataTable: Table;
    @ViewChild("paginator", { static: true }) paginator: Paginator;

    advancedFiltersAreShown = false;
    filterText = "";
    maxThoiGianFilter: DateTime;
    minThoiGianFilter: DateTime;
    trangThaiFilter = "";
    userNameFilter = "";
    baiDangTieuDeFilter = "";

    constructor(
        injector: Injector,
        private _baiGhimYeuThichsServiceProxy: BaiGhimYeuThichsServiceProxy,
        private _notifyService: NotifyService,
        private _tokenAuth: TokenAuthServiceProxy,
        private _activatedRoute: ActivatedRoute,
        private _fileDownloadService: FileDownloadService,
        private _dateTimeService: DateTimeService
    ) {
        super(injector);
    }

    getBaiGhimYeuThichs(event?: LazyLoadEvent) {
        if (this.primengTableHelper.shouldResetPaging(event)) {
            this.paginator.changePage(0);
            return;
        }

        this.primengTableHelper.showLoadingIndicator();

        this._baiGhimYeuThichsServiceProxy
            .getAll(
                this.filterText,
                this.maxThoiGianFilter === undefined ? this.maxThoiGianFilter : this._dateTimeService.getEndOfDayForDate(this.maxThoiGianFilter),
                this.minThoiGianFilter === undefined ? this.minThoiGianFilter : this._dateTimeService.getStartOfDayForDate(this.minThoiGianFilter),
                this.trangThaiFilter,
                this.userNameFilter,
                this.baiDangTieuDeFilter,
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

    createBaiGhimYeuThich(): void {
        this.createOrEditBaiGhimYeuThichModal.show();
    }

    deleteBaiGhimYeuThich(baiGhimYeuThich: BaiGhimYeuThichDto): void {
        this.message.confirm("", this.l("AreYouSure"), (isConfirmed) => {
            if (isConfirmed) {
                this._baiGhimYeuThichsServiceProxy.delete(baiGhimYeuThich.id).subscribe(() => {
                    this.reloadPage();
                    this.notify.success(this.l("SuccessfullyDeleted"));
                });
            }
        });
    }

    exportToExcel(): void {
        this._baiGhimYeuThichsServiceProxy
            .getBaiGhimYeuThichsToExcel(
                this.filterText,
                this.maxThoiGianFilter === undefined ? this.maxThoiGianFilter : this._dateTimeService.getEndOfDayForDate(this.maxThoiGianFilter),
                this.minThoiGianFilter === undefined ? this.minThoiGianFilter : this._dateTimeService.getStartOfDayForDate(this.minThoiGianFilter),
                this.trangThaiFilter,
                this.userNameFilter,
                this.baiDangTieuDeFilter
            )
            .subscribe((result) => {
                this._fileDownloadService.downloadTempFile(result);
            });
    }
}
