using System.Collections.Generic;
using Abp.Runtime.Session;
using Abp.Timing.Timezone;
using Homies.RealEstate.DataExporting.Excel.NPOI;
using Homies.RealEstate.Server.Dtos;
using Homies.RealEstate.Dto;
using Homies.RealEstate.Storage;

namespace Homies.RealEstate.Server.Exporting
{
    public class HinhAnhsExcelExporter : NpoiExcelExporterBase, IHinhAnhsExcelExporter
    {

        private readonly ITimeZoneConverter _timeZoneConverter;
        private readonly IAbpSession _abpSession;

        public HinhAnhsExcelExporter(
            ITimeZoneConverter timeZoneConverter,
            IAbpSession abpSession,
            ITempFileCacheManager tempFileCacheManager) :
    base(tempFileCacheManager)
        {
            _timeZoneConverter = timeZoneConverter;
            _abpSession = abpSession;
        }

        public FileDto ExportToFile(List<GetHinhAnhForViewDto> hinhAnhs)
        {
            return CreateExcelPackage(
                "HinhAnhs.xlsx",
                excelPackage =>
                {

                    var sheet = excelPackage.CreateSheet(L("HinhAnhs"));

                    AddHeader(
                        sheet,
                        L("DuongDan"),
                        (L("BaiDang")) + L("TieuDe")
                        );

                    AddObjects(
                        sheet, 2, hinhAnhs,
                        _ => _.HinhAnh.DuongDan,
                        _ => _.BaiDangTieuDe
                        );

                });
        }
    }
}