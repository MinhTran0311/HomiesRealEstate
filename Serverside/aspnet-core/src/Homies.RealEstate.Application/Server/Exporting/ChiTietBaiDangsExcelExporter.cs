using System.Collections.Generic;
using Abp.Runtime.Session;
using Abp.Timing.Timezone;
using Homies.RealEstate.DataExporting.Excel.NPOI;
using Homies.RealEstate.Server.Dtos;
using Homies.RealEstate.Dto;
using Homies.RealEstate.Storage;

namespace Homies.RealEstate.Server.Exporting
{
    public class ChiTietBaiDangsExcelExporter : NpoiExcelExporterBase, IChiTietBaiDangsExcelExporter
    {

        private readonly ITimeZoneConverter _timeZoneConverter;
        private readonly IAbpSession _abpSession;

        public ChiTietBaiDangsExcelExporter(
            ITimeZoneConverter timeZoneConverter,
            IAbpSession abpSession,
            ITempFileCacheManager tempFileCacheManager) :
    base(tempFileCacheManager)
        {
            _timeZoneConverter = timeZoneConverter;
            _abpSession = abpSession;
        }

        public FileDto ExportToFile(List<GetChiTietBaiDangForViewDto> chiTietBaiDangs)
        {
            return CreateExcelPackage(
                "ChiTietBaiDangs.xlsx",
                excelPackage =>
                {

                    var sheet = excelPackage.CreateSheet(L("ChiTietBaiDangs"));

                    AddHeader(
                        sheet,
                        L("GiaTri"),
                        (L("ThuocTinh")) + L("TenThuocTinh"),
                        (L("BaiDang")) + L("TieuDe")
                        );

                    AddObjects(
                        sheet, 2, chiTietBaiDangs,
                        _ => _.ChiTietBaiDang.GiaTri,
                        _ => _.ThuocTinhTenThuocTinh,
                        _ => _.BaiDangTieuDe
                        );

                });
        }
    }
}