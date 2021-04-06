using System.Collections.Generic;
using Abp.Runtime.Session;
using Abp.Timing.Timezone;
using Homies.RealEstate.DataExporting.Excel.NPOI;
using Homies.RealEstate.Server.Dtos;
using Homies.RealEstate.Dto;
using Homies.RealEstate.Storage;

namespace Homies.RealEstate.Server.Exporting
{
    public class HuyensExcelExporter : NpoiExcelExporterBase, IHuyensExcelExporter
    {

        private readonly ITimeZoneConverter _timeZoneConverter;
        private readonly IAbpSession _abpSession;

        public HuyensExcelExporter(
            ITimeZoneConverter timeZoneConverter,
            IAbpSession abpSession,
            ITempFileCacheManager tempFileCacheManager) :
    base(tempFileCacheManager)
        {
            _timeZoneConverter = timeZoneConverter;
            _abpSession = abpSession;
        }

        public FileDto ExportToFile(List<GetHuyenForViewDto> huyens)
        {
            return CreateExcelPackage(
                "Huyens.xlsx",
                excelPackage =>
                {

                    var sheet = excelPackage.CreateSheet(L("Huyens"));

                    AddHeader(
                        sheet,
                        L("TenHuyen"),
                        (L("Tinh")) + L("TenTinh")
                        );

                    AddObjects(
                        sheet, 2, huyens,
                        _ => _.Huyen.TenHuyen,
                        _ => _.TinhTenTinh
                        );

                });
        }
    }
}