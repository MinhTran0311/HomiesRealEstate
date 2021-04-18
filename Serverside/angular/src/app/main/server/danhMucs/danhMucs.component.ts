import { Component, Injector, ViewEncapsulation, ViewChild } from "@angular/core";
import { ActivatedRoute, Router } from "@angular/router";
import { DanhMucsServiceProxy, DanhMucDto } from "@shared/service-proxies/service-proxies";
import { NotifyService } from "abp-ng2-module";
import { AppComponentBase } from "@shared/common/app-component-base";
import { TokenAuthServiceProxy } from "@shared/service-proxies/service-proxies";
import { CreateOrEditDanhMucModalComponent } from "./create-or-edit-danhMuc-modal.component";

import { ViewDanhMucModalComponent } from "./view-danhMuc-modal.component";
import { appModuleAnimation } from "@shared/animations/routerTransition";
import { Table } from "primeng/table";
import { Paginator } from "primeng/paginator";
import { LazyLoadEvent } from "primeng/api/public_api";
import { FileDownloadService } from "@shared/utils/file-download.service";
import { filter as _filter } from "lodash-es";
import { DateTime } from "luxon";

import { DateTimeService } from "@app/shared/common/timing/date-time.service";

@Component({
    templateUrl: "./danhMucs.component.html",
    encapsulation: ViewEncapsulation.None,
    animations: [appModuleAnimation()],
})
export class DanhMucsComponent extends AppComponentBase {
    @ViewChild("createOrEditDanhMucModal", { static: true }) createOrEditDanhMucModal: CreateOrEditDanhMucModalComponent;
    @ViewChild("viewDanhMucModalComponent", { static: true }) viewDanhMucModal: ViewDanhMucModalComponent;

    @ViewChild("dataTable", { static: true }) dataTable: Table;
    @ViewChild("paginator", { static: true }) paginator: Paginator;

    advancedFiltersAreShown = false;
    filterText = "";
    tenDanhMucFilter = "";
    tagFilter = "";
    trangThaiFilter = "";
    maxDanhMucChaFilter: number;
    maxDanhMucChaFilterEmpty: number;
    minDanhMucChaFilter: number;
    minDanhMucChaFilterEmpty: number;

    constructor(
        injector: Injector,
        private _danhMucsServiceProxy: DanhMucsServiceProxy,
        private _notifyService: NotifyService,
        private _tokenAuth: TokenAuthServiceProxy,
        private _activatedRoute: ActivatedRoute,
        private _fileDownloadService: FileDownloadService,
        private _dateTimeService: DateTimeService
    ) {
        super(injector);
    }

    getDanhMucs(event?: LazyLoadEvent) {
        if (this.primengTableHelper.shouldResetPaging(event)) {
            this.paginator.changePage(0);
            return;
        }

        this.primengTableHelper.showLoadingIndicator();

        this._danhMucsServiceProxy
            .getAll(
                this.filterText,
                this.tenDanhMucFilter,
                this.tagFilter,
                this.trangThaiFilter,
                this.maxDanhMucChaFilter == null ? this.maxDanhMucChaFilterEmpty : this.maxDanhMucChaFilter,
                this.minDanhMucChaFilter == null ? this.minDanhMucChaFilterEmpty : this.minDanhMucChaFilter,
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

    createDanhMuc(): void {
        this.createOrEditDanhMucModal.show();
    }

    deleteDanhMuc(danhMuc: DanhMucDto): void {
        this.message.confirm("", this.l("AreYouSure"), (isConfirmed) => {
            if (isConfirmed) {
                this._danhMucsServiceProxy.delete(danhMuc.id).subscribe(() => {
                    this.reloadPage();
                    this.notify.success(this.l("SuccessfullyDeleted"));
                });
            }
        });
    }

    exportToExcel(): void {
        this._danhMucsServiceProxy
            .getDanhMucsToExcel(
                this.filterText,
                this.tenDanhMucFilter,
                this.tagFilter,
                this.trangThaiFilter,
                this.maxDanhMucChaFilter == null ? this.maxDanhMucChaFilterEmpty : this.maxDanhMucChaFilter,
                this.minDanhMucChaFilter == null ? this.minDanhMucChaFilterEmpty : this.minDanhMucChaFilter
            )
            .subscribe((result) => {
                this._fileDownloadService.downloadTempFile(result);
            });
    }
}
