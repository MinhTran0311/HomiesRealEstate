using System.Collections.Generic;
using Abp.Runtime.Session;
using Abp.Timing.Timezone;
using Homies.RealEstate.DataExporting.Excel.NPOI;
using Homies.RealEstate.Server.Dtos;
using Homies.RealEstate.Dto;
using Homies.RealEstate.Storage;

namespace Homies.RealEstate.Server.Exporting
{
    public class LichSuGiaoDichsExcelExporter : NpoiExcelExporterBase, ILichSuGiaoDichsExcelExporter
    {

        private readonly ITimeZoneConverter _timeZoneConverter;
        private readonly IAbpSession _abpSession;

        public LichSuGiaoDichsExcelExporter(
            ITimeZoneConverter timeZoneConverter,
            IAbpSession abpSession,
            ITempFileCacheManager tempFileCacheManager) :
    base(tempFileCacheManager)
        {
            _timeZoneConverter = timeZoneConverter;
            _abpSession = abpSession;
        }

        public FileDto ExportToFile(List<GetLichSuGiaoDichForViewDto> lichSuGiaoDichs)
        {
            return CreateExcelPackage(
                "LichSuGiaoDichs.xlsx",
                excelPackage =>
                {

                    var sheet = excelPackage.CreateSheet(L("LichSuGiaoDichs"));

                    AddHeader(
                        sheet,
                        L("SoTien"),
                        L("ThoiDiem"),
                        L("GhiChu"),
                        (L("User")) + L("Name"),
                        (L("ChiTietHoaDonBaiDang")) + L("GhiChu"),
                        (L("User")) + L("Name")
                        );

                    AddObjects(
                        sheet, 2, lichSuGiaoDichs,
                        _ => _.LichSuGiaoDich.SoTien,
                        _ => _timeZoneConverter.Convert(_.LichSuGiaoDich.ThoiDiem, _abpSession.TenantId, _abpSession.GetUserId()),
                        _ => _.LichSuGiaoDich.GhiChu,
                        _ => _.UserName,
                        _ => _.ChiTietHoaDonBaiDangGhiChu,
                        _ => _.UserName2
                        );

                    for (var i = 1; i <= lichSuGiaoDichs.Count; i++)
                    {
                        SetCellDataFormat(sheet.GetRow(i).Cells[2], "yyyy-mm-dd");
                    }
                    sheet.AutoSizeColumn(2);
                });
        }
    }
}