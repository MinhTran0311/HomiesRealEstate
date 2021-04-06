import { Component, Injector, ViewEncapsulation, ViewChild } from "@angular/core";
import { ActivatedRoute, Router } from "@angular/router";
import { ChiTietHoaDonBaiDangsServiceProxy, ChiTietHoaDonBaiDangDto } from "@shared/service-proxies/service-proxies";
import { NotifyService } from "abp-ng2-module";
import { AppComponentBase } from "@shared/common/app-component-base";
import { TokenAuthServiceProxy } from "@shared/service-proxies/service-proxies";
import { CreateOrEditChiTietHoaDonBaiDangModalComponent } from "./create-or-edit-chiTietHoaDonBaiDang-modal.component";

import { ViewChiTietHoaDonBaiDangModalComponent } from "./view-chiTietHoaDonBaiDang-modal.component";
import { appModuleAnimation } from "@shared/animations/routerTransition";
import { Table } from "primeng/table";
import { Paginator } from "primeng/paginator";
import { LazyLoadEvent } from "primeng/public_api";
import { FileDownloadService } from "@shared/utils/file-download.service";
import { filter as _filter } from "lodash-es";
import { DateTime } from "luxon";

import { DateTimeService } from "@app/shared/common/timing/date-time.service";

@Component({
    templateUrl: "./chiTietHoaDonBaiDangs.component.html",
    encapsulation: ViewEncapsulation.None,
    animations: [appModuleAnimation()],
})
export class ChiTietHoaDonBaiDangsComponent extends AppComponentBase {
    @ViewChild("createOrEditChiTietHoaDonBaiDangModal", { static: true })
    createOrEditChiTietHoaDonBaiDangModal: CreateOrEditChiTietHoaDonBaiDangModalComponent;
    @ViewChild("viewChiTietHoaDonBaiDangModalComponent", { static: true }) viewChiTietHoaDonBaiDangModal: ViewChiTietHoaDonBaiDangModalComponent;

    @ViewChild("dataTable", { static: true }) dataTable: Table;
    @ViewChild("paginator", { static: true }) paginator: Paginator;

    advancedFiltersAreShown = false;
    filterText = "";
    maxThoiDiemFilter: DateTime;
    minThoiDiemFilter: DateTime;
    maxGiaGoiFilter: number;
    maxGiaGoiFilterEmpty: number;
    minGiaGoiFilter: number;
    minGiaGoiFilterEmpty: number;
    maxSoNgayMuaFilter: number;
    maxSoNgayMuaFilterEmpty: number;
    minSoNgayMuaFilter: number;
    minSoNgayMuaFilterEmpty: number;
    maxTongTienFilter: number;
    maxTongTienFilterEmpty: number;
    minTongTienFilter: number;
    minTongTienFilterEmpty: number;
    ghiChuFilter = "";
    baiDangTieuDeFilter = "";
    goiBaiDangTenGoiFilter = "";
    userNameFilter = "";

    constructor(
        injector: Injector,
        private _chiTietHoaDonBaiDangsServiceProxy: ChiTietHoaDonBaiDangsServiceProxy,
        private _notifyService: NotifyService,
        private _tokenAuth: TokenAuthServiceProxy,
        private _activatedRoute: ActivatedRoute,
        private _fileDownloadService: FileDownloadService,
        private _dateTimeService: DateTimeService
    ) {
        super(injector);
    }

    getChiTietHoaDonBaiDangs(event?: LazyLoadEvent) {
        if (this.primengTableHelper.shouldResetPaging(event)) {
            this.paginator.changePage(0);
            return;
        }

        this.primengTableHelper.showLoadingIndicator();

        this._chiTietHoaDonBaiDangsServiceProxy
            .getAll(
                this.filterText,
                this.maxThoiDiemFilter === undefined ? this.maxThoiDiemFilter : this._dateTimeService.getEndOfDayForDate(this.maxThoiDiemFilter),
                this.minThoiDiemFilter === undefined ? this.minThoiDiemFilter : this._dateTimeService.getStartOfDayForDate(this.minThoiDiemFilter),
                this.maxGiaGoiFilter == null ? this.maxGiaGoiFilterEmpty : this.maxGiaGoiFilter,
                this.minGiaGoiFilter == null ? this.minGiaGoiFilterEmpty : this.minGiaGoiFilter,
                this.maxSoNgayMuaFilter == null ? this.maxSoNgayMuaFilterEmpty : this.maxSoNgayMuaFilter,
                this.minSoNgayMuaFilter == null ? this.minSoNgayMuaFilterEmpty : this.minSoNgayMuaFilter,
                this.maxTongTienFilter == null ? this.maxTongTienFilterEmpty : this.maxTongTienFilter,
                this.minTongTienFilter == null ? this.minTongTienFilterEmpty : this.minTongTienFilter,
                this.ghiChuFilter,
                this.baiDangTieuDeFilter,
                this.goiBaiDangTenGoiFilter,
                this.userNameFilter,
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

    createChiTietHoaDonBaiDang(): void {
        this.createOrEditChiTietHoaDonBaiDangModal.show();
    }

    deleteChiTietHoaDonBaiDang(chiTietHoaDonBaiDang: ChiTietHoaDonBaiDangDto): void {
        this.message.confirm("", this.l("AreYouSure"), (isConfirmed) => {
            if (isConfirmed) {
                this._chiTietHoaDonBaiDangsServiceProxy.delete(chiTietHoaDonBaiDang.id).subscribe(() => {
                    this.reloadPage();
                    this.notify.success(this.l("SuccessfullyDeleted"));
                });
            }
        });
    }

    exportToExcel(): void {
        this._chiTietHoaDonBaiDangsServiceProxy
            .getChiTietHoaDonBaiDangsToExcel(
                this.filterText,
                this.maxThoiDiemFilter === undefined ? this.maxThoiDiemFilter : this._dateTimeService.getEndOfDayForDate(this.maxThoiDiemFilter),
                this.minThoiDiemFilter === undefined ? this.minThoiDiemFilter : this._dateTimeService.getStartOfDayForDate(this.minThoiDiemFilter),
                this.maxGiaGoiFilter == null ? this.maxGiaGoiFilterEmpty : this.maxGiaGoiFilter,
                this.minGiaGoiFilter == null ? this.minGiaGoiFilterEmpty : this.minGiaGoiFilter,
                this.maxSoNgayMuaFilter == null ? this.maxSoNgayMuaFilterEmpty : this.maxSoNgayMuaFilter,
                this.minSoNgayMuaFilter == null ? this.minSoNgayMuaFilterEmpty : this.minSoNgayMuaFilter,
                this.maxTongTienFilter == null ? this.maxTongTienFilterEmpty : this.maxTongTienFilter,
                this.minTongTienFilter == null ? this.minTongTienFilterEmpty : this.minTongTienFilter,
                this.ghiChuFilter,
                this.baiDangTieuDeFilter,
                this.goiBaiDangTenGoiFilter,
                this.userNameFilter
            )
            .subscribe((result) => {
                this._fileDownloadService.downloadTempFile(result);
            });
    }
}
