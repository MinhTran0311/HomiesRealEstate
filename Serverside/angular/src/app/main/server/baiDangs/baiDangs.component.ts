import { AppConsts } from "@shared/AppConsts";
import { Component, Injector, ViewEncapsulation, ViewChild } from "@angular/core";
import { ActivatedRoute, Router } from "@angular/router";
import { BaiDangsServiceProxy, BaiDangDto } from "@shared/service-proxies/service-proxies";
import { NotifyService } from "abp-ng2-module";
import { AppComponentBase } from "@shared/common/app-component-base";
import { TokenAuthServiceProxy } from "@shared/service-proxies/service-proxies";
import { CreateOrEditBaiDangModalComponent } from "./create-or-edit-baiDang-modal.component";

import { ViewBaiDangModalComponent } from "./view-baiDang-modal.component";
import { appModuleAnimation } from "@shared/animations/routerTransition";
import { Table } from "primeng/table";
import { Paginator } from "primeng/paginator";
import { LazyLoadEvent } from "primeng/api";
import { FileDownloadService } from "@shared/utils/file-download.service";
import { filter as _filter } from "lodash-es";
import { DateTime } from "luxon";

import { DateTimeService } from "@app/shared/common/timing/date-time.service";

@Component({
    templateUrl: "./baiDangs.component.html",
    encapsulation: ViewEncapsulation.None,
    animations: [appModuleAnimation()],
})
export class BaiDangsComponent extends AppComponentBase {
    @ViewChild("createOrEditBaiDangModal", { static: true }) createOrEditBaiDangModal: CreateOrEditBaiDangModalComponent;
    @ViewChild("viewBaiDangModalComponent", { static: true }) viewBaiDangModal: ViewBaiDangModalComponent;

    @ViewChild("dataTable", { static: true }) dataTable: Table;
    @ViewChild("paginator", { static: true }) paginator: Paginator;

    advancedFiltersAreShown = false;
    filterText = "";
    tagLoaiBaiDangFilter = "";
    maxThoiDiemDangFilter: DateTime;
    minThoiDiemDangFilter: DateTime;
    maxThoiHanFilter: DateTime;
    minThoiHanFilter: DateTime;
    diaChiFilter = "";
    moTaFilter = "";
    toaDoXFilter = "";
    toaDoYFilter = "";
    maxLuotXemFilter: number;
    maxLuotXemFilterEmpty: number;
    minLuotXemFilter: number;
    minLuotXemFilterEmpty: number;
    maxLuotYeuThichFilter: number;
    maxLuotYeuThichFilterEmpty: number;
    minLuotYeuThichFilter: number;
    minLuotYeuThichFilterEmpty: number;
    maxDiemBaiDangFilter: number;
    maxDiemBaiDangFilterEmpty: number;
    minDiemBaiDangFilter: number;
    minDiemBaiDangFilterEmpty: number;
    trangThaiFilter = "";
    tagTimKiemFilter = "";
    tieuDeFilter = "";
    userNameFilter = "";
    danhMucTenDanhMucFilter = "";
    xaTenXaFilter = "";

    constructor(
        injector: Injector,
        private _baiDangsServiceProxy: BaiDangsServiceProxy,
        private _notifyService: NotifyService,
        private _tokenAuth: TokenAuthServiceProxy,
        private _activatedRoute: ActivatedRoute,
        private _fileDownloadService: FileDownloadService,
        private _dateTimeService: DateTimeService
    ) {
        super(injector);
    }

    getBaiDangs(event?: LazyLoadEvent) {
        if (this.primengTableHelper.shouldResetPaging(event)) {
            this.paginator.changePage(0);
            return;
        }

        this.primengTableHelper.showLoadingIndicator();

        this._baiDangsServiceProxy
            .getAll(
                this.filterText,
                this.tagLoaiBaiDangFilter,
                this.maxThoiDiemDangFilter === undefined
                    ? this.maxThoiDiemDangFilter
                    : this._dateTimeService.getEndOfDayForDate(this.maxThoiDiemDangFilter),
                this.minThoiDiemDangFilter === undefined
                    ? this.minThoiDiemDangFilter
                    : this._dateTimeService.getStartOfDayForDate(this.minThoiDiemDangFilter),
                this.maxThoiHanFilter === undefined ? this.maxThoiHanFilter : this._dateTimeService.getEndOfDayForDate(this.maxThoiHanFilter),
                this.minThoiHanFilter === undefined ? this.minThoiHanFilter : this._dateTimeService.getStartOfDayForDate(this.minThoiHanFilter),
                this.diaChiFilter,
                this.moTaFilter,
                this.toaDoXFilter,
                this.toaDoYFilter,
                this.maxLuotXemFilter == null ? this.maxLuotXemFilterEmpty : this.maxLuotXemFilter,
                this.minLuotXemFilter == null ? this.minLuotXemFilterEmpty : this.minLuotXemFilter,
                this.maxLuotYeuThichFilter == null ? this.maxLuotYeuThichFilterEmpty : this.maxLuotYeuThichFilter,
                this.minLuotYeuThichFilter == null ? this.minLuotYeuThichFilterEmpty : this.minLuotYeuThichFilter,
                this.maxDiemBaiDangFilter == null ? this.maxDiemBaiDangFilterEmpty : this.maxDiemBaiDangFilter,
                this.minDiemBaiDangFilter == null ? this.minDiemBaiDangFilterEmpty : this.minDiemBaiDangFilter,
                this.trangThaiFilter,
                this.tagTimKiemFilter,
                this.tieuDeFilter,
                this.userNameFilter,
                this.danhMucTenDanhMucFilter,
                this.xaTenXaFilter,
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

    createBaiDang(): void {
        this.createOrEditBaiDangModal.show();
    }

    deleteBaiDang(baiDang: BaiDangDto): void {
        this.message.confirm("", this.l("AreYouSure"), (isConfirmed) => {
            if (isConfirmed) {
                this._baiDangsServiceProxy.delete(baiDang.id).subscribe(() => {
                    this.reloadPage();
                    this.notify.success(this.l("SuccessfullyDeleted"));
                });
            }
        });
    }

    exportToExcel(): void {
        this._baiDangsServiceProxy
            .getBaiDangsToExcel(
                this.filterText,
                this.tagLoaiBaiDangFilter,
                this.maxThoiDiemDangFilter === undefined
                    ? this.maxThoiDiemDangFilter
                    : this._dateTimeService.getEndOfDayForDate(this.maxThoiDiemDangFilter),
                this.minThoiDiemDangFilter === undefined
                    ? this.minThoiDiemDangFilter
                    : this._dateTimeService.getStartOfDayForDate(this.minThoiDiemDangFilter),
                this.maxThoiHanFilter === undefined ? this.maxThoiHanFilter : this._dateTimeService.getEndOfDayForDate(this.maxThoiHanFilter),
                this.minThoiHanFilter === undefined ? this.minThoiHanFilter : this._dateTimeService.getStartOfDayForDate(this.minThoiHanFilter),
                this.diaChiFilter,
                this.moTaFilter,
                this.toaDoXFilter,
                this.toaDoYFilter,
                this.maxLuotXemFilter == null ? this.maxLuotXemFilterEmpty : this.maxLuotXemFilter,
                this.minLuotXemFilter == null ? this.minLuotXemFilterEmpty : this.minLuotXemFilter,
                this.maxLuotYeuThichFilter == null ? this.maxLuotYeuThichFilterEmpty : this.maxLuotYeuThichFilter,
                this.minLuotYeuThichFilter == null ? this.minLuotYeuThichFilterEmpty : this.minLuotYeuThichFilter,
                this.maxDiemBaiDangFilter == null ? this.maxDiemBaiDangFilterEmpty : this.maxDiemBaiDangFilter,
                this.minDiemBaiDangFilter == null ? this.minDiemBaiDangFilterEmpty : this.minDiemBaiDangFilter,
                this.trangThaiFilter,
                this.tagTimKiemFilter,
                this.tieuDeFilter,
                this.userNameFilter,
                this.danhMucTenDanhMucFilter,
                this.xaTenXaFilter
            )
            .subscribe((result) => {
                this._fileDownloadService.downloadTempFile(result);
            });
    }
}
