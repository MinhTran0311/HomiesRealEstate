import { Component, Injector, ViewEncapsulation, ViewChild } from "@angular/core";
import { ActivatedRoute, Router } from "@angular/router";
import { HinhAnhsServiceProxy, HinhAnhDto } from "@shared/service-proxies/service-proxies";
import { NotifyService } from "abp-ng2-module";
import { AppComponentBase } from "@shared/common/app-component-base";
import { TokenAuthServiceProxy } from "@shared/service-proxies/service-proxies";
import { CreateOrEditHinhAnhModalComponent } from "./create-or-edit-hinhAnh-modal.component";

import { ViewHinhAnhModalComponent } from "./view-hinhAnh-modal.component";
import { appModuleAnimation } from "@shared/animations/routerTransition";
import { Table } from "primeng/table";
import { Paginator } from "primeng/paginator";
import { LazyLoadEvent } from "primeng/public_api";
import { FileDownloadService } from "@shared/utils/file-download.service";
import { filter as _filter } from "lodash-es";
import { DateTime } from "luxon";

import { DateTimeService } from "@app/shared/common/timing/date-time.service";

@Component({
    templateUrl: "./hinhAnhs.component.html",
    encapsulation: ViewEncapsulation.None,
    animations: [appModuleAnimation()],
})
export class HinhAnhsComponent extends AppComponentBase {
    @ViewChild("createOrEditHinhAnhModal", { static: true }) createOrEditHinhAnhModal: CreateOrEditHinhAnhModalComponent;
    @ViewChild("viewHinhAnhModalComponent", { static: true }) viewHinhAnhModal: ViewHinhAnhModalComponent;

    @ViewChild("dataTable", { static: true }) dataTable: Table;
    @ViewChild("paginator", { static: true }) paginator: Paginator;

    advancedFiltersAreShown = false;
    filterText = "";
    duongDanFilter = "";
    baiDangTieuDeFilter = "";

    constructor(
        injector: Injector,
        private _hinhAnhsServiceProxy: HinhAnhsServiceProxy,
        private _notifyService: NotifyService,
        private _tokenAuth: TokenAuthServiceProxy,
        private _activatedRoute: ActivatedRoute,
        private _fileDownloadService: FileDownloadService,
        private _dateTimeService: DateTimeService
    ) {
        super(injector);
    }

    getHinhAnhs(event?: LazyLoadEvent) {
        if (this.primengTableHelper.shouldResetPaging(event)) {
            this.paginator.changePage(0);
            return;
        }

        this.primengTableHelper.showLoadingIndicator();

        this._hinhAnhsServiceProxy
            .getAll(
                this.filterText,
                this.duongDanFilter,
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

    createHinhAnh(): void {
        this.createOrEditHinhAnhModal.show();
    }

    deleteHinhAnh(hinhAnh: HinhAnhDto): void {
        this.message.confirm("", this.l("AreYouSure"), (isConfirmed) => {
            if (isConfirmed) {
                this._hinhAnhsServiceProxy.delete(hinhAnh.id).subscribe(() => {
                    this.reloadPage();
                    this.notify.success(this.l("SuccessfullyDeleted"));
                });
            }
        });
    }

    exportToExcel(): void {
        this._hinhAnhsServiceProxy.getHinhAnhsToExcel(this.filterText, this.duongDanFilter, this.baiDangTieuDeFilter).subscribe((result) => {
            this._fileDownloadService.downloadTempFile(result);
        });
    }
}
