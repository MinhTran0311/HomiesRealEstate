import { Component, Injector, ViewEncapsulation, ViewChild } from "@angular/core";
import { ActivatedRoute, Router } from "@angular/router";
import { ChiTietBaiDangsServiceProxy, ChiTietBaiDangDto } from "@shared/service-proxies/service-proxies";
import { NotifyService } from "abp-ng2-module";
import { AppComponentBase } from "@shared/common/app-component-base";
import { TokenAuthServiceProxy } from "@shared/service-proxies/service-proxies";
import { CreateOrEditChiTietBaiDangModalComponent } from "./create-or-edit-chiTietBaiDang-modal.component";

import { ViewChiTietBaiDangModalComponent } from "./view-chiTietBaiDang-modal.component";
import { appModuleAnimation } from "@shared/animations/routerTransition";
import { Table } from "primeng/table";
import { Paginator } from "primeng/paginator";
import { LazyLoadEvent } from "primeng/public_api";
import { FileDownloadService } from "@shared/utils/file-download.service";
import { filter as _filter } from "lodash-es";
import { DateTime } from "luxon";

import { DateTimeService } from "@app/shared/common/timing/date-time.service";

@Component({
    templateUrl: "./chiTietBaiDangs.component.html",
    encapsulation: ViewEncapsulation.None,
    animations: [appModuleAnimation()],
})
export class ChiTietBaiDangsComponent extends AppComponentBase {
    @ViewChild("createOrEditChiTietBaiDangModal", { static: true }) createOrEditChiTietBaiDangModal: CreateOrEditChiTietBaiDangModalComponent;
    @ViewChild("viewChiTietBaiDangModalComponent", { static: true }) viewChiTietBaiDangModal: ViewChiTietBaiDangModalComponent;

    @ViewChild("dataTable", { static: true }) dataTable: Table;
    @ViewChild("paginator", { static: true }) paginator: Paginator;

    advancedFiltersAreShown = false;
    filterText = "";
    giaTriFilter = "";
    thuocTinhTenThuocTinhFilter = "";
    baiDangTieuDeFilter = "";

    constructor(
        injector: Injector,
        private _chiTietBaiDangsServiceProxy: ChiTietBaiDangsServiceProxy,
        private _notifyService: NotifyService,
        private _tokenAuth: TokenAuthServiceProxy,
        private _activatedRoute: ActivatedRoute,
        private _fileDownloadService: FileDownloadService,
        private _dateTimeService: DateTimeService
    ) {
        super(injector);
    }

    getChiTietBaiDangs(event?: LazyLoadEvent) {
        if (this.primengTableHelper.shouldResetPaging(event)) {
            this.paginator.changePage(0);
            return;
        }

        this.primengTableHelper.showLoadingIndicator();

        this._chiTietBaiDangsServiceProxy
            .getAll(
                this.filterText,
                this.giaTriFilter,
                this.thuocTinhTenThuocTinhFilter,
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

    createChiTietBaiDang(): void {
        this.createOrEditChiTietBaiDangModal.show();
    }

    deleteChiTietBaiDang(chiTietBaiDang: ChiTietBaiDangDto): void {
        this.message.confirm("", this.l("AreYouSure"), (isConfirmed) => {
            if (isConfirmed) {
                this._chiTietBaiDangsServiceProxy.delete(chiTietBaiDang.id).subscribe(() => {
                    this.reloadPage();
                    this.notify.success(this.l("SuccessfullyDeleted"));
                });
            }
        });
    }

    exportToExcel(): void {
        this._chiTietBaiDangsServiceProxy
            .getChiTietBaiDangsToExcel(this.filterText, this.giaTriFilter, this.thuocTinhTenThuocTinhFilter, this.baiDangTieuDeFilter)
            .subscribe((result) => {
                this._fileDownloadService.downloadTempFile(result);
            });
    }
}
