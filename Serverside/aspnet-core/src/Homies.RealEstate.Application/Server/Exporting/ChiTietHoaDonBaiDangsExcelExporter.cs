using System.Collections.Generic;
using Abp.Runtime.Session;
using Abp.Timing.Timezone;
using Homies.RealEstate.DataExporting.Excel.NPOI;
using Homies.RealEstate.Server.Dtos;
using Homies.RealEstate.Dto;
using Homies.RealEstate.Storage;

namespace Homies.RealEstate.Server.Exporting
{
    public class ChiTietHoaDonBaiDangsExcelExporter : NpoiExcelExporterBase, IChiTietHoaDonBaiDangsExcelExporter
    {

        private readonly ITimeZoneConverter _timeZoneConverter;
        private readonly IAbpSession _abpSession;

        public ChiTietHoaDonBaiDangsExcelExporter(
            ITimeZoneConverter timeZoneConverter,
            IAbpSession abpSession,
            ITempFileCacheManager tempFileCacheManager) :
    base(tempFileCacheManager)
        {
            _timeZoneConverter = timeZoneConverter;
            _abpSession = abpSession;
        }

        public FileDto ExportToFile(List<GetChiTietHoaDonBaiDangForViewDto> chiTietHoaDonBaiDangs)
        {
            return CreateExcelPackage(
                "ChiTietHoaDonBaiDangs.xlsx",
                excelPackage =>
                {

                    var sheet = excelPackage.CreateSheet(L("ChiTietHoaDonBaiDangs"));

                    AddHeader(
                        sheet,
                        L("ThoiDiem"),
                        L("GiaGoi"),
                        L("SoNgayMua"),
                        L("TongTien"),
                        L("GhiChu"),
                        (L("BaiDang")) + L("TieuDe"),
                        (L("GoiBaiDang")) + L("TenGoi"),
                        (L("User")) + L("Name")
                        );

                    AddObjects(
                        sheet, 2, chiTietHoaDonBaiDangs,
                        _ => _timeZoneConverter.Convert(_.ChiTietHoaDonBaiDang.ThoiDiem, _abpSession.TenantId, _abpSession.GetUserId()),
                        _ => _.ChiTietHoaDonBaiDang.GiaGoi,
                        _ => _.ChiTietHoaDonBaiDang.SoNgayMua,
                        _ => _.ChiTietHoaDonBaiDang.TongTien,
                        _ => _.ChiTietHoaDonBaiDang.GhiChu,
                        _ => _.BaiDangTieuDe,
                        _ => _.GoiBaiDangTenGoi,
                        _ => _.UserName
                        );

                    for (var i = 1; i <= chiTietHoaDonBaiDangs.Count; i++)
                    {
                        SetCellDataFormat(sheet.GetRow(i).Cells[1], "yyyy-mm-dd");
                    }
                    sheet.AutoSizeColumn(1);
                });
        }
    }
}