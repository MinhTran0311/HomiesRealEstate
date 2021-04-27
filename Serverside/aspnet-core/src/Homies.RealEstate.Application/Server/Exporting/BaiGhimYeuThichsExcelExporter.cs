using System.Collections.Generic;
using Abp.Runtime.Session;
using Abp.Timing.Timezone;
using Homies.RealEstate.DataExporting.Excel.NPOI;
using Homies.RealEstate.Server.Dtos;
using Homies.RealEstate.Dto;
using Homies.RealEstate.Storage;

namespace Homies.RealEstate.Server.Exporting
{
    public class BaiGhimYeuThichsExcelExporter : NpoiExcelExporterBase, IBaiGhimYeuThichsExcelExporter
    {

        private readonly ITimeZoneConverter _timeZoneConverter;
        private readonly IAbpSession _abpSession;

        public BaiGhimYeuThichsExcelExporter(
            ITimeZoneConverter timeZoneConverter,
            IAbpSession abpSession,
            ITempFileCacheManager tempFileCacheManager) :
    base(tempFileCacheManager)
        {
            _timeZoneConverter = timeZoneConverter;
            _abpSession = abpSession;
        }

        public FileDto ExportToFile(List<GetBaiGhimYeuThichForViewDto> baiGhimYeuThichs)
        {
            return CreateExcelPackage(
                "BaiGhimYeuThichs.xlsx",
                excelPackage =>
                {

                    var sheet = excelPackage.CreateSheet(L("BaiGhimYeuThichs"));

                    AddHeader(
                        sheet,
                        L("ThoiGian"),
                        L("TrangThai"),
                        (L("User")) + L("Name"),
                        (L("BaiDang")) + L("TieuDe")
                        );

                    AddObjects(
                        sheet, 2, baiGhimYeuThichs,
                        _ => _timeZoneConverter.Convert(_.BaiGhimYeuThich.ThoiGian, _abpSession.TenantId, _abpSession.GetUserId()),
                        _ => _.BaiGhimYeuThich.TrangThai,
                        _ => _.UserName,
                        _ => _.BaiDangTieuDe
                        );

                    for (var i = 1; i <= baiGhimYeuThichs.Count; i++)
                    {
                        SetCellDataFormat(sheet.GetRow(i).Cells[1], "yyyy-mm-dd");
                    }
                    sheet.AutoSizeColumn(1);
                });
        }
    }
}