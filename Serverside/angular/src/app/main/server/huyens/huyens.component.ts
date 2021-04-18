import { Component, Injector, ViewEncapsulation, ViewChild } from "@angular/core";
import { ActivatedRoute, Router } from "@angular/router";
import { HuyensServiceProxy, HuyenDto } from "@shared/service-proxies/service-proxies";
import { NotifyService } from "abp-ng2-module";
import { AppComponentBase } from "@shared/common/app-component-base";
import { TokenAuthServiceProxy } from "@shared/service-proxies/service-proxies";
import { CreateOrEditHuyenModalComponent } from "./create-or-edit-huyen-modal.component";

import { ViewHuyenModalComponent } from "./view-huyen-modal.component";
import { appModuleAnimation } from "@shared/animations/routerTransition";
import { Table } from "primeng/table";
import { Paginator } from "primeng/paginator";
import { LazyLoadEvent } from "primeng/api/public_api";
import { FileDownloadService } from "@shared/utils/file-download.service";
import { filter as _filter } from "lodash-es";
import { DateTime } from "luxon";

import { DateTimeService } from "@app/shared/common/timing/date-time.service";

@Component({
    templateUrl: "./huyens.component.html",
    encapsulation: ViewEncapsulation.None,
    animations: [appModuleAnimation()],
})
export class HuyensComponent extends AppComponentBase {
    @ViewChild("createOrEditHuyenModal", { static: true }) createOrEditHuyenModal: CreateOrEditHuyenModalComponent;
    @ViewChild("viewHuyenModalComponent", { static: true }) viewHuyenModal: ViewHuyenModalComponent;

    @ViewChild("dataTable", { static: true }) dataTable: Table;
    @ViewChild("paginator", { static: true }) paginator: Paginator;

    advancedFiltersAreShown = false;
    filterText = "";
    tenHuyenFilter = "";
    tinhTenTinhFilter = "";

    constructor(
        injector: Injector,
        private _huyensServiceProxy: HuyensServiceProxy,
        private _notifyService: NotifyService,
        private _tokenAuth: TokenAuthServiceProxy,
        private _activatedRoute: ActivatedRoute,
        private _fileDownloadService: FileDownloadService,
        private _dateTimeService: DateTimeService
    ) {
        super(injector);
    }

    getHuyens(event?: LazyLoadEvent) {
        if (this.primengTableHelper.shouldResetPaging(event)) {
            this.paginator.changePage(0);
            return;
        }

        this.primengTableHelper.showLoadingIndicator();

        this._huyensServiceProxy
            .getAll(
                this.filterText,
                this.tenHuyenFilter,
                this.tinhTenTinhFilter,
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

    createHuyen(): void {
        this.createOrEditHuyenModal.show();
    }

    deleteHuyen(huyen: HuyenDto): void {
        this.message.confirm("", this.l("AreYouSure"), (isConfirmed) => {
            if (isConfirmed) {
                this._huyensServiceProxy.delete(huyen.id).subscribe(() => {
                    this.reloadPage();
                    this.notify.success(this.l("SuccessfullyDeleted"));
                });
            }
        });
    }

    exportToExcel(): void {
        this._huyensServiceProxy.getHuyensToExcel(this.filterText, this.tenHuyenFilter, this.tinhTenTinhFilter).subscribe((result) => {
            this._fileDownloadService.downloadTempFile(result);
        });
    }
}
