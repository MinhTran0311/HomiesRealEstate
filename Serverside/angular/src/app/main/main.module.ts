import { CommonModule } from '@angular/common';
import { NgModule } from '@angular/core';
import { FormsModule } from '@angular/forms';
import { AppCommonModule } from '@app/shared/common/app-common.module';
import { LichSuGiaoDichsComponent } from './server/lichSuGiaoDichs/lichSuGiaoDichs.component';
import { ViewLichSuGiaoDichModalComponent } from './server/lichSuGiaoDichs/view-lichSuGiaoDich-modal.component';
import { CreateOrEditLichSuGiaoDichModalComponent } from './server/lichSuGiaoDichs/create-or-edit-lichSuGiaoDich-modal.component';
import { LichSuGiaoDichUserLookupTableModalComponent } from './server/lichSuGiaoDichs/lichSuGiaoDich-user-lookup-table-modal.component';
import { LichSuGiaoDichChiTietHoaDonBaiDangLookupTableModalComponent } from './server/lichSuGiaoDichs/lichSuGiaoDich-chiTietHoaDonBaiDang-lookup-table-modal.component';
import { LichSuGiaoDichUserLookupTableModalComponent } from './server/lichSuGiaoDichs/lichSuGiaoDich-user-lookup-table-modal.component';

import { ChiTietBaiDangsComponent } from './server/chiTietBaiDangs/chiTietBaiDangs.component';
import { ViewChiTietBaiDangModalComponent } from './server/chiTietBaiDangs/view-chiTietBaiDang-modal.component';
import { CreateOrEditChiTietBaiDangModalComponent } from './server/chiTietBaiDangs/create-or-edit-chiTietBaiDang-modal.component';
import { ChiTietBaiDangThuocTinhLookupTableModalComponent } from './server/chiTietBaiDangs/chiTietBaiDang-thuocTinh-lookup-table-modal.component';
import { ChiTietBaiDangBaiDangLookupTableModalComponent } from './server/chiTietBaiDangs/chiTietBaiDang-baiDang-lookup-table-modal.component';

import { ChiTietHoaDonBaiDangsComponent } from './server/chiTietHoaDonBaiDangs/chiTietHoaDonBaiDangs.component';
import { ViewChiTietHoaDonBaiDangModalComponent } from './server/chiTietHoaDonBaiDangs/view-chiTietHoaDonBaiDang-modal.component';
import { CreateOrEditChiTietHoaDonBaiDangModalComponent } from './server/chiTietHoaDonBaiDangs/create-or-edit-chiTietHoaDonBaiDang-modal.component';
import { ChiTietHoaDonBaiDangBaiDangLookupTableModalComponent } from './server/chiTietHoaDonBaiDangs/chiTietHoaDonBaiDang-baiDang-lookup-table-modal.component';
import { ChiTietHoaDonBaiDangGoiBaiDangLookupTableModalComponent } from './server/chiTietHoaDonBaiDangs/chiTietHoaDonBaiDang-goiBaiDang-lookup-table-modal.component';
import { ChiTietHoaDonBaiDangUserLookupTableModalComponent } from './server/chiTietHoaDonBaiDangs/chiTietHoaDonBaiDang-user-lookup-table-modal.component';

import { BaiGhimYeuThichsComponent } from './server/baiGhimYeuThichs/baiGhimYeuThichs.component';
import { ViewBaiGhimYeuThichModalComponent } from './server/baiGhimYeuThichs/view-baiGhimYeuThich-modal.component';
import { CreateOrEditBaiGhimYeuThichModalComponent } from './server/baiGhimYeuThichs/create-or-edit-baiGhimYeuThich-modal.component';
import { BaiGhimYeuThichUserLookupTableModalComponent } from './server/baiGhimYeuThichs/baiGhimYeuThich-user-lookup-table-modal.component';
import { BaiGhimYeuThichBaiDangLookupTableModalComponent } from './server/baiGhimYeuThichs/baiGhimYeuThich-baiDang-lookup-table-modal.component';

import { HinhAnhsComponent } from './server/hinhAnhs/hinhAnhs.component';
import { ViewHinhAnhModalComponent } from './server/hinhAnhs/view-hinhAnh-modal.component';
import { CreateOrEditHinhAnhModalComponent } from './server/hinhAnhs/create-or-edit-hinhAnh-modal.component';
import { HinhAnhBaiDangLookupTableModalComponent } from './server/hinhAnhs/hinhAnh-baiDang-lookup-table-modal.component';

import { GoiBaiDangsComponent } from './server/goiBaiDangs/goiBaiDangs.component';
import { ViewGoiBaiDangModalComponent } from './server/goiBaiDangs/view-goiBaiDang-modal.component';
import { CreateOrEditGoiBaiDangModalComponent } from './server/goiBaiDangs/create-or-edit-goiBaiDang-modal.component';

import { BaiDangsComponent } from './server/baiDangs/baiDangs.component';
import { ViewBaiDangModalComponent } from './server/baiDangs/view-baiDang-modal.component';
import { CreateOrEditBaiDangModalComponent } from './server/baiDangs/create-or-edit-baiDang-modal.component';
import { BaiDangUserLookupTableModalComponent } from './server/baiDangs/baiDang-user-lookup-table-modal.component';
import { BaiDangDanhMucLookupTableModalComponent } from './server/baiDangs/baiDang-danhMuc-lookup-table-modal.component';
import { BaiDangXaLookupTableModalComponent } from './server/baiDangs/baiDang-xa-lookup-table-modal.component';

import { ChiTietDanhMucsComponent } from './server/chiTietDanhMucs/chiTietDanhMucs.component';
import { ViewChiTietDanhMucModalComponent } from './server/chiTietDanhMucs/view-chiTietDanhMuc-modal.component';
import { CreateOrEditChiTietDanhMucModalComponent } from './server/chiTietDanhMucs/create-or-edit-chiTietDanhMuc-modal.component';
import { ChiTietDanhMucThuocTinhLookupTableModalComponent } from './server/chiTietDanhMucs/chiTietDanhMuc-thuocTinh-lookup-table-modal.component';
import { ChiTietDanhMucDanhMucLookupTableModalComponent } from './server/chiTietDanhMucs/chiTietDanhMuc-danhMuc-lookup-table-modal.component';

import { DanhMucsComponent } from './server/danhMucs/danhMucs.component';
import { ViewDanhMucModalComponent } from './server/danhMucs/view-danhMuc-modal.component';
import { CreateOrEditDanhMucModalComponent } from './server/danhMucs/create-or-edit-danhMuc-modal.component';

import { ThuocTinhsComponent } from './server/thuocTinhs/thuocTinhs.component';
import { ViewThuocTinhModalComponent } from './server/thuocTinhs/view-thuocTinh-modal.component';
import { CreateOrEditThuocTinhModalComponent } from './server/thuocTinhs/create-or-edit-thuocTinh-modal.component';

import { ThamSosComponent } from './server/thamSos/thamSos.component';
import { ViewThamSoModalComponent } from './server/thamSos/view-thamSo-modal.component';
import { CreateOrEditThamSoModalComponent } from './server/thamSos/create-or-edit-thamSo-modal.component';

import { XasComponent } from './server/xas/xas.component';
import { ViewXaModalComponent } from './server/xas/view-xa-modal.component';
import { CreateOrEditXaModalComponent } from './server/xas/create-or-edit-xa-modal.component';
import { XaHuyenLookupTableModalComponent } from './server/xas/xa-huyen-lookup-table-modal.component';

import { HuyensComponent } from './server/huyens/huyens.component';
import { ViewHuyenModalComponent } from './server/huyens/view-huyen-modal.component';
import { CreateOrEditHuyenModalComponent } from './server/huyens/create-or-edit-huyen-modal.component';
import { HuyenTinhLookupTableModalComponent } from './server/huyens/huyen-tinh-lookup-table-modal.component';

import { TinhsComponent } from './server/tinhs/tinhs.component';
import { ViewTinhModalComponent } from './server/tinhs/view-tinh-modal.component';
import { CreateOrEditTinhModalComponent } from './server/tinhs/create-or-edit-tinh-modal.component';
import { AutoCompleteModule } from 'primeng/autocomplete';
import { PaginatorModule } from 'primeng/paginator';
import { EditorModule } from 'primeng/editor';
import { InputMaskModule } from 'primeng/inputmask';import { FileUploadModule } from 'primeng/fileupload';
import { TableModule } from 'primeng/table';

import { UtilsModule } from '@shared/utils/utils.module';
import { CountoModule } from 'angular2-counto';
import { ModalModule } from 'ngx-bootstrap/modal';
import { TabsModule } from 'ngx-bootstrap/tabs';
import { TooltipModule } from 'ngx-bootstrap/tooltip';
import { BsDropdownModule } from 'ngx-bootstrap/dropdown';
import { PopoverModule } from 'ngx-bootstrap/popover';
import { DashboardComponent } from './dashboard/dashboard.component';
import { MainRoutingModule } from './main-routing.module';

import { BsDatepickerConfig, BsDaterangepickerConfig, BsLocaleService } from 'ngx-bootstrap/datepicker';
import { BsDatepickerModule } from 'ngx-bootstrap/datepicker';
import { NgxBootstrapDatePickerConfigService } from 'assets/ngx-bootstrap/ngx-bootstrap-datepicker-config.service';

NgxBootstrapDatePickerConfigService.registerNgxBootstrapDatePickerLocales();

@NgModule({
    imports: [
		FileUploadModule,
		AutoCompleteModule,
		PaginatorModule,
		EditorModule,
		InputMaskModule,		TableModule,

        CommonModule,
        FormsModule,
        ModalModule,
        TabsModule,
        TooltipModule,
        AppCommonModule,
        UtilsModule,
        MainRoutingModule,
        CountoModule,
        BsDatepickerModule.forRoot(),
        BsDropdownModule.forRoot(),
        PopoverModule.forRoot()
    ],
    declarations: [
		LichSuGiaoDichsComponent,

		ViewLichSuGiaoDichModalComponent,
		CreateOrEditLichSuGiaoDichModalComponent,
    LichSuGiaoDichUserLookupTableModalComponent,
    LichSuGiaoDichChiTietHoaDonBaiDangLookupTableModalComponent,
    LichSuGiaoDichUserLookupTableModalComponent,
		ChiTietBaiDangsComponent,

		ViewChiTietBaiDangModalComponent,
		CreateOrEditChiTietBaiDangModalComponent,
    ChiTietBaiDangThuocTinhLookupTableModalComponent,
    ChiTietBaiDangBaiDangLookupTableModalComponent,
		ChiTietHoaDonBaiDangsComponent,

		ViewChiTietHoaDonBaiDangModalComponent,
		CreateOrEditChiTietHoaDonBaiDangModalComponent,
    ChiTietHoaDonBaiDangBaiDangLookupTableModalComponent,
    ChiTietHoaDonBaiDangGoiBaiDangLookupTableModalComponent,
    ChiTietHoaDonBaiDangUserLookupTableModalComponent,
		BaiGhimYeuThichsComponent,

		ViewBaiGhimYeuThichModalComponent,
		CreateOrEditBaiGhimYeuThichModalComponent,
    BaiGhimYeuThichUserLookupTableModalComponent,
    BaiGhimYeuThichBaiDangLookupTableModalComponent,
		HinhAnhsComponent,

		ViewHinhAnhModalComponent,
		CreateOrEditHinhAnhModalComponent,
    HinhAnhBaiDangLookupTableModalComponent,
		GoiBaiDangsComponent,

		ViewGoiBaiDangModalComponent,
		CreateOrEditGoiBaiDangModalComponent,
		BaiDangsComponent,

		ViewBaiDangModalComponent,
		CreateOrEditBaiDangModalComponent,
    BaiDangUserLookupTableModalComponent,
    BaiDangDanhMucLookupTableModalComponent,
    BaiDangXaLookupTableModalComponent,
		ChiTietDanhMucsComponent,

		ViewChiTietDanhMucModalComponent,
		CreateOrEditChiTietDanhMucModalComponent,
    ChiTietDanhMucThuocTinhLookupTableModalComponent,
    ChiTietDanhMucDanhMucLookupTableModalComponent,
		DanhMucsComponent,

		ViewDanhMucModalComponent,
		CreateOrEditDanhMucModalComponent,
		ThuocTinhsComponent,

		ViewThuocTinhModalComponent,
		CreateOrEditThuocTinhModalComponent,
		ThamSosComponent,

		ViewThamSoModalComponent,
		CreateOrEditThamSoModalComponent,
		XasComponent,

		ViewXaModalComponent,
		CreateOrEditXaModalComponent,
    XaHuyenLookupTableModalComponent,
		HuyensComponent,

		ViewHuyenModalComponent,
		CreateOrEditHuyenModalComponent,
    HuyenTinhLookupTableModalComponent,
		TinhsComponent,

		ViewTinhModalComponent,
		CreateOrEditTinhModalComponent,
        DashboardComponent
    ],
    providers: [
        { provide: BsDatepickerConfig, useFactory: NgxBootstrapDatePickerConfigService.getDatepickerConfig },
        { provide: BsDaterangepickerConfig, useFactory: NgxBootstrapDatePickerConfigService.getDaterangepickerConfig },
        { provide: BsLocaleService, useFactory: NgxBootstrapDatePickerConfigService.getDatepickerLocale }
    ]
})
export class MainModule { }
