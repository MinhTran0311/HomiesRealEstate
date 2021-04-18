import { Component, Injector, ViewEncapsulation, ViewChild } from "@angular/core";
import { ActivatedRoute, Router } from "@angular/router";
import { TinhsServiceProxy, TinhDto } from "@shared/service-proxies/service-proxies";
import { NotifyService } from "abp-ng2-module";
import { AppComponentBase } from "@shared/common/app-component-base";
import { TokenAuthServiceProxy } from "@shared/service-proxies/service-proxies";
import { CreateOrEditTinhModalComponent } from "./create-or-edit-tinh-modal.component";

import { ViewTinhModalComponent } from "./view-tinh-modal.component";
import { appModuleAnimation } from "@shared/animations/routerTransition";
import { Table } from "primeng/table";
import { Paginator } from "primeng/paginator";
import { LazyLoadEvent } from "primeng/api/public_api";
import { FileDownloadService } from "@shared/utils/file-download.service";
import { filter as _filter } from "lodash-es";
import { DateTime } from "luxon";

import { DateTimeService } from "@app/shared/common/timing/date-time.service";

@Component({
    templateUrl: "./tinhs.component.html",
    encapsulation: ViewEncapsulation.None,
    animations: [appModuleAnimation()],
})
export class TinhsComponent extends AppComponentBase {
    @ViewChild("createOrEditTinhModal", { static: true }) createOrEditTinhModal: CreateOrEditTinhModalComponent;
    @ViewChild("viewTinhModalComponent", { static: true }) viewTinhModal: ViewTinhModalComponent;

    @ViewChild("dataTable", { static: true }) dataTable: Table;
    @ViewChild("paginator", { static: true }) paginator: Paginator;

    advancedFiltersAreShown = false;
    filterText = "";
    tenTinhFilter = "";

    constructor(
        injector: Injector,
        private _tinhsServiceProxy: TinhsServiceProxy,
        private _notifyService: NotifyService,
        private _tokenAuth: TokenAuthServiceProxy,
        private _activatedRoute: ActivatedRoute,
        private _fileDownloadService: FileDownloadService,
        private _dateTimeService: DateTimeService
    ) {
        super(injector);
    }

    getTinhs(event?: LazyLoadEvent) {
        if (this.primengTableHelper.shouldResetPaging(event)) {
            this.paginator.changePage(0);
            return;
        }

        this.primengTableHelper.showLoadingIndicator();

        this._tinhsServiceProxy
            .getAll(
                this.filterText,
                this.tenTinhFilter,
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

    createTinh(): void {
        this.createOrEditTinhModal.show();
    }

    deleteTinh(tinh: TinhDto): void {
        this.message.confirm("", this.l("AreYouSure"), (isConfirmed) => {
            if (isConfirmed) {
                this._tinhsServiceProxy.delete(tinh.id).subscribe(() => {
                    this.reloadPage();
                    this.notify.success(this.l("SuccessfullyDeleted"));
                });
            }
        });
    }

    exportToExcel(): void {
        this._tinhsServiceProxy.getTinhsToExcel(this.filterText, this.tenTinhFilter).subscribe((result) => {
            this._fileDownloadService.downloadTempFile(result);
        });
    }
}
