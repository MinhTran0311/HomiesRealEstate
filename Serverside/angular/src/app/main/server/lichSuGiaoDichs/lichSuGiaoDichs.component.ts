import { Component, Injector, ViewEncapsulation, ViewChild } from "@angular/core";
import { ActivatedRoute, Router } from "@angular/router";
import { LichSuGiaoDichsServiceProxy, LichSuGiaoDichDto } from "@shared/service-proxies/service-proxies";
import { NotifyService } from "abp-ng2-module";
import { AppComponentBase } from "@shared/common/app-component-base";
import { TokenAuthServiceProxy } from "@shared/service-proxies/service-proxies";
import { CreateOrEditLichSuGiaoDichModalComponent } from "./create-or-edit-lichSuGiaoDich-modal.component";

import { ViewLichSuGiaoDichModalComponent } from "./view-lichSuGiaoDich-modal.component";
import { appModuleAnimation } from "@shared/animations/routerTransition";
import { Table } from "primeng/table";
import { Paginator } from "primeng/paginator";
import { LazyLoadEvent } from "primeng/public_api";
import { FileDownloadService } from "@shared/utils/file-download.service";
import { filter as _filter } from "lodash-es";
import { DateTime } from "luxon";

import { DateTimeService } from "@app/shared/common/timing/date-time.service";

@Component({
    templateUrl: "./lichSuGiaoDichs.component.html",
    encapsulation: ViewEncapsulation.None,
    animations: [appModuleAnimation()],
})
export class LichSuGiaoDichsComponent extends AppComponentBase {
    @ViewChild("createOrEditLichSuGiaoDichModal", { static: true }) createOrEditLichSuGiaoDichModal: CreateOrEditLichSuGiaoDichModalComponent;
    @ViewChild("viewLichSuGiaoDichModalComponent", { static: true }) viewLichSuGiaoDichModal: ViewLichSuGiaoDichModalComponent;

    @ViewChild("dataTable", { static: true }) dataTable: Table;
    @ViewChild("paginator", { static: true }) paginator: Paginator;

    advancedFiltersAreShown = false;
    filterText = "";
    maxSoTienFilter: number;
    maxSoTienFilterEmpty: number;
    minSoTienFilter: number;
    minSoTienFilterEmpty: number;
    maxThoiDiemFilter: DateTime;
    minThoiDiemFilter: DateTime;
    ghiChuFilter = "";
    userNameFilter = "";
    chiTietHoaDonBaiDangGhiChuFilter = "";
    userName2Filter = "";

    constructor(
        injector: Injector,
        private _lichSuGiaoDichsServiceProxy: LichSuGiaoDichsServiceProxy,
        private _notifyService: NotifyService,
        private _tokenAuth: TokenAuthServiceProxy,
        private _activatedRoute: ActivatedRoute,
        private _fileDownloadService: FileDownloadService,
        private _dateTimeService: DateTimeService
    ) {
        super(injector);
    }

    getLichSuGiaoDichs(event?: LazyLoadEvent) {
        if (this.primengTableHelper.shouldResetPaging(event)) {
            this.paginator.changePage(0);
            return;
        }

        this.primengTableHelper.showLoadingIndicator();

        this._lichSuGiaoDichsServiceProxy
            .getAll(
                this.filterText,
                this.maxSoTienFilter == null ? this.maxSoTienFilterEmpty : this.maxSoTienFilter,
                this.minSoTienFilter == null ? this.minSoTienFilterEmpty : this.minSoTienFilter,
                this.maxThoiDiemFilter === undefined ? this.maxThoiDiemFilter : this._dateTimeService.getEndOfDayForDate(this.maxThoiDiemFilter),
                this.minThoiDiemFilter === undefined ? this.minThoiDiemFilter : this._dateTimeService.getStartOfDayForDate(this.minThoiDiemFilter),
                this.ghiChuFilter,
                this.userNameFilter,
                this.chiTietHoaDonBaiDangGhiChuFilter,
                this.userName2Filter,
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

    createLichSuGiaoDich(): void {
        this.createOrEditLichSuGiaoDichModal.show();
    }

    deleteLichSuGiaoDich(lichSuGiaoDich: LichSuGiaoDichDto): void {
        this.message.confirm("", this.l("AreYouSure"), (isConfirmed) => {
            if (isConfirmed) {
                this._lichSuGiaoDichsServiceProxy.delete(lichSuGiaoDich.id).subscribe(() => {
                    this.reloadPage();
                    this.notify.success(this.l("SuccessfullyDeleted"));
                });
            }
        });
    }

    exportToExcel(): void {
        this._lichSuGiaoDichsServiceProxy
            .getLichSuGiaoDichsToExcel(
                this.filterText,
                this.maxSoTienFilter == null ? this.maxSoTienFilterEmpty : this.maxSoTienFilter,
                this.minSoTienFilter == null ? this.minSoTienFilterEmpty : this.minSoTienFilter,
                this.maxThoiDiemFilter === undefined ? this.maxThoiDiemFilter : this._dateTimeService.getEndOfDayForDate(this.maxThoiDiemFilter),
                this.minThoiDiemFilter === undefined ? this.minThoiDiemFilter : this._dateTimeService.getStartOfDayForDate(this.minThoiDiemFilter),
                this.ghiChuFilter,
                this.userNameFilter,
                this.chiTietHoaDonBaiDangGhiChuFilter,
                this.userName2Filter
            )
            .subscribe((result) => {
                this._fileDownloadService.downloadTempFile(result);
            });
    }
}
