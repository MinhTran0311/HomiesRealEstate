import { Component, Injector, ViewEncapsulation, ViewChild } from "@angular/core";
import { ActivatedRoute, Router } from "@angular/router";
import { ThuocTinhsServiceProxy, ThuocTinhDto } from "@shared/service-proxies/service-proxies";
import { NotifyService } from "abp-ng2-module";
import { AppComponentBase } from "@shared/common/app-component-base";
import { TokenAuthServiceProxy } from "@shared/service-proxies/service-proxies";
import { CreateOrEditThuocTinhModalComponent } from "./create-or-edit-thuocTinh-modal.component";

import { ViewThuocTinhModalComponent } from "./view-thuocTinh-modal.component";
import { appModuleAnimation } from "@shared/animations/routerTransition";
import { Table } from "primeng/table";
import { Paginator } from "primeng/paginator";
import { LazyLoadEvent } from "primeng/api/public_api";
import { FileDownloadService } from "@shared/utils/file-download.service";
import { filter as _filter } from "lodash-es";
import { DateTime } from "luxon";

import { DateTimeService } from "@app/shared/common/timing/date-time.service";

@Component({
    templateUrl: "./thuocTinhs.component.html",
    encapsulation: ViewEncapsulation.None,
    animations: [appModuleAnimation()],
})
export class ThuocTinhsComponent extends AppComponentBase {
    @ViewChild("createOrEditThuocTinhModal", { static: true }) createOrEditThuocTinhModal: CreateOrEditThuocTinhModalComponent;
    @ViewChild("viewThuocTinhModalComponent", { static: true }) viewThuocTinhModal: ViewThuocTinhModalComponent;

    @ViewChild("dataTable", { static: true }) dataTable: Table;
    @ViewChild("paginator", { static: true }) paginator: Paginator;

    advancedFiltersAreShown = false;
    filterText = "";
    tenThuocTinhFilter = "";
    kieuDuLieuFilter = "";
    trangThaiFilter = "";

    constructor(
        injector: Injector,
        private _thuocTinhsServiceProxy: ThuocTinhsServiceProxy,
        private _notifyService: NotifyService,
        private _tokenAuth: TokenAuthServiceProxy,
        private _activatedRoute: ActivatedRoute,
        private _fileDownloadService: FileDownloadService,
        private _dateTimeService: DateTimeService
    ) {
        super(injector);
    }

    getThuocTinhs(event?: LazyLoadEvent) {
        if (this.primengTableHelper.shouldResetPaging(event)) {
            this.paginator.changePage(0);
            return;
        }

        this.primengTableHelper.showLoadingIndicator();

        this._thuocTinhsServiceProxy
            .getAll(
                this.filterText,
                this.tenThuocTinhFilter,
                this.kieuDuLieuFilter,
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

    createThuocTinh(): void {
        this.createOrEditThuocTinhModal.show();
    }

    deleteThuocTinh(thuocTinh: ThuocTinhDto): void {
        this.message.confirm("", this.l("AreYouSure"), (isConfirmed) => {
            if (isConfirmed) {
                this._thuocTinhsServiceProxy.delete(thuocTinh.id).subscribe(() => {
                    this.reloadPage();
                    this.notify.success(this.l("SuccessfullyDeleted"));
                });
            }
        });
    }

    exportToExcel(): void {
        this._thuocTinhsServiceProxy
            .getThuocTinhsToExcel(this.filterText, this.tenThuocTinhFilter, this.kieuDuLieuFilter, this.trangThaiFilter)
            .subscribe((result) => {
                this._fileDownloadService.downloadTempFile(result);
            });
    }
}
