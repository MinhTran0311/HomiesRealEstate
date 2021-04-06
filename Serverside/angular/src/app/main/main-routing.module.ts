import { NgModule } from '@angular/core';
import { RouterModule } from '@angular/router';
import { BaiGhimYeuThichsComponent } from './server/baiGhimYeuThichs/baiGhimYeuThichs.component';
import { HinhAnhsComponent } from './server/hinhAnhs/hinhAnhs.component';
import { GoiBaiDangsComponent } from './server/goiBaiDangs/goiBaiDangs.component';
import { BaiDangsComponent } from './server/baiDangs/baiDangs.component';
import { ChiTietDanhMucsComponent } from './server/chiTietDanhMucs/chiTietDanhMucs.component';
import { DanhMucsComponent } from './server/danhMucs/danhMucs.component';
import { ThuocTinhsComponent } from './server/thuocTinhs/thuocTinhs.component';
import { ThamSosComponent } from './server/thamSos/thamSos.component';
import { XasComponent } from './server/xas/xas.component';
import { HuyensComponent } from './server/huyens/huyens.component';
import { TinhsComponent } from './server/tinhs/tinhs.component';
import { DashboardComponent } from './dashboard/dashboard.component';

@NgModule({
    imports: [
        RouterModule.forChild([
            {
                path: '',
                children: [
                    { path: 'server/baiGhimYeuThichs', component: BaiGhimYeuThichsComponent, data: { permission: 'Pages.BaiGhimYeuThichs' }  },
                    { path: 'server/hinhAnhs', component: HinhAnhsComponent, data: { permission: 'Pages.HinhAnhs' }  },
                    { path: 'server/goiBaiDangs', component: GoiBaiDangsComponent, data: { permission: 'Pages.GoiBaiDangs' }  },
                    { path: 'server/baiDangs', component: BaiDangsComponent, data: { permission: 'Pages.BaiDangs' }  },
                    { path: 'server/chiTietDanhMucs', component: ChiTietDanhMucsComponent, data: { permission: 'Pages.ChiTietDanhMucs' }  },
                    { path: 'server/danhMucs', component: DanhMucsComponent, data: { permission: 'Pages.DanhMucs' }  },
                    { path: 'server/thuocTinhs', component: ThuocTinhsComponent, data: { permission: 'Pages.ThuocTinhs' }  },
                    { path: 'server/thamSos', component: ThamSosComponent, data: { permission: 'Pages.ThamSos' }  },
                    { path: 'server/xas', component: XasComponent, data: { permission: 'Pages.Xas' }  },
                    { path: 'server/huyens', component: HuyensComponent, data: { permission: 'Pages.Huyens' }  },
                    { path: 'server/tinhs', component: TinhsComponent, data: { permission: 'Pages.Tinhs' }  },
                    { path: 'dashboard', component: DashboardComponent, data: { permission: 'Pages.Tenant.Dashboard' } },
                    { path: '', redirectTo: 'dashboard', pathMatch: 'full' },
                    { path: '**', redirectTo: 'dashboard' }
                ]
            }
        ])
    ],
    exports: [
        RouterModule
    ]
})
export class MainRoutingModule { }
