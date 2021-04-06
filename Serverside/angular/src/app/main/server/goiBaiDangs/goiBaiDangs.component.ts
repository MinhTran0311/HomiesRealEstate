import { Component, Injector, ViewEncapsulation, ViewChild } from "@angular/core";
import { ActivatedRoute, Router } from "@angular/router";
import { GoiBaiDangsServiceProxy, GoiBaiDangDto } from "@shared/service-proxies/service-proxies";
import { NotifyService } from "abp-ng2-module";
import { AppComponentBase } from "@shared/common/app-component-base";
import { TokenAuthServiceProxy } from "@shared/service-proxies/service-proxies";
import { CreateOrEditGoiBaiDangModalComponent } from "./create-or-edit-goiBaiDang-modal.component";

import { ViewGoiBaiDangModalComponent } from "./view-goiBaiDang-modal.component";
import { appModuleAnimation } from "@shared/animations/routerTransition";
import { Table } from "primeng/table";
import { Paginator } from "primeng/paginator";
import { LazyLoadEvent } from "primeng/public_api";
import { FileDownloadService } from "@shared/utils/file-download.service";
import { filter as _filter } from "lodash-es";
import { DateTime } from "luxon";

import { DateTimeService } from "@app/shared/common/timing/date-time.service";

@Component({
    templateUrl: "./goiBaiDangs.component.html",
    encapsulation: ViewEncapsulation.None,
    animations: [appModuleAnimation()],
})
export class GoiBaiDangsComponent extends AppComponentBase {
    @ViewChild("createOrEditGoiBaiDangModal", { static: true }) createOrEditGoiBaiDangModal: CreateOrEditGoiBaiDangModalComponent;
    @ViewChild("viewGoiBaiDangModalComponent", { static: true }) viewGoiBaiDangModal: ViewGoiBaiDangModalComponent;

    @ViewChild("dataTable", { static: true }) dataTable: Table;
    @ViewChild("paginator", { static: true }) paginator: Paginator;

    advancedFiltersAreShown = false;
    filterText = "";
    tenGoiFilter = "";
    maxPhiFilter: number;
    maxPhiFilterEmpty: number;
    minPhiFilter: number;
    minPhiFilterEmpty: number;
    maxDoUuTienFilter: number;
    maxDoUuTienFilterEmpty: number;
    minDoUuTienFilter: number;
    minDoUuTienFilterEmpty: number;
    maxThoiGianToiThieuFilter: number;
    maxThoiGianToiThieuFilterEmpty: number;
    minThoiGianToiThieuFilter: number;
    minThoiGianToiThieuFilterEmpty: number;
    moTaFilter = "";
    trangThaiFilter = "";

    constructor(
        injector: Injector,
        private _goiBaiDangsServiceProxy: GoiBaiDangsServiceProxy,
        private _notifyService: NotifyService,
        private _tokenAuth: TokenAuthServiceProxy,
        private _activatedRoute: ActivatedRoute,
        private _fileDownloadService: FileDownloadService,
        private _dateTimeService: DateTimeService
    ) {
        super(injector);
    }

    getGoiBaiDangs(event?: LazyLoadEvent) {
        if (this.primengTableHelper.shouldResetPaging(event)) {
            this.paginator.changePage(0);
            return;
        }

        this.primengTableHelper.showLoadingIndicator();

        this._goiBaiDangsServiceProxy
            .getAll(
                this.filterText,
                this.tenGoiFilter,
                this.maxPhiFilter == null ? this.maxPhiFilterEmpty : this.maxPhiFilter,
                this.minPhiFilter == null ? this.minPhiFilterEmpty : this.minPhiFilter,
                this.maxDoUuTienFilter == null ? this.maxDoUuTienFilterEmpty : this.maxDoUuTienFilter,
                this.minDoUuTienFilter == null ? this.minDoUuTienFilterEmpty : this.minDoUuTienFilter,
                this.maxThoiGianToiThieuFilter == null ? this.maxThoiGianToiThieuFilterEmpty : this.maxThoiGianToiThieuFilter,
                this.minThoiGianToiThieuFilter == null ? this.minThoiGianToiThieuFilterEmpty : this.minThoiGianToiThieuFilter,
                this.moTaFilter,
                this.trangThaiFilter,
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

    createGoiBaiDang(): void {
        this.createOrEditGoiBaiDangModal.show();
    }

    deleteGoiBaiDang(goiBaiDang: GoiBaiDangDto): void {
        this.message.confirm("", this.l("AreYouSure"), (isConfirmed) => {
            if (isConfirmed) {
                this._goiBaiDangsServiceProxy.delete(goiBaiDang.id).subscribe(() => {
                    this.reloadPage();
                    this.notify.success(this.l("SuccessfullyDeleted"));
                });
            }
        });
    }

    exportToExcel(): void {
        this._goiBaiDangsServiceProxy
            .getGoiBaiDangsToExcel(
                this.filterText,
                this.tenGoiFilter,
                this.maxPhiFilter == null ? this.maxPhiFilterEmpty : this.maxPhiFilter,
                this.minPhiFilter == null ? this.minPhiFilterEmpty : this.minPhiFilter,
                this.maxDoUuTienFilter == null ? this.maxDoUuTienFilterEmpty : this.maxDoUuTienFilter,
                this.minDoUuTienFilter == null ? this.minDoUuTienFilterEmpty : this.minDoUuTienFilter,
                this.maxThoiGianToiThieuFilter == null ? this.maxThoiGianToiThieuFilterEmpty : this.maxThoiGianToiThieuFilter,
                this.minThoiGianToiThieuFilter == null ? this.minThoiGianToiThieuFilterEmpty : this.minThoiGianToiThieuFilter,
                this.moTaFilter,
                this.trangThaiFilter
            )
            .subscribe((result) => {
                this._fileDownloadService.downloadTempFile(result);
            });
    }
}
