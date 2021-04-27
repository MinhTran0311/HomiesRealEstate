using System.Collections.Generic;
using Abp.Runtime.Session;
using Abp.Timing.Timezone;
using Homies.RealEstate.DataExporting.Excel.NPOI;
using Homies.RealEstate.Server.Dtos;
using Homies.RealEstate.Dto;
using Homies.RealEstate.Storage;

namespace Homies.RealEstate.Server.Exporting
{
    public class XasExcelExporter : NpoiExcelExporterBase, IXasExcelExporter
    {

        private readonly ITimeZoneConverter _timeZoneConverter;
        private readonly IAbpSession _abpSession;

        public XasExcelExporter(
            ITimeZoneConverter timeZoneConverter,
            IAbpSession abpSession,
            ITempFileCacheManager tempFileCacheManager) :
    base(tempFileCacheManager)
        {
            _timeZoneConverter = timeZoneConverter;
            _abpSession = abpSession;
        }

        public FileDto ExportToFile(List<GetXaForViewDto> xas)
        {
            return CreateExcelPackage(
                "Xas.xlsx",
                excelPackage =>
                {

                    var sheet = excelPackage.CreateSheet(L("Xas"));

                    AddHeader(
                        sheet,
                        L("TenXa"),
                        (L("Huyen")) + L("TenHuyen")
                        );

                    AddObjects(
                        sheet, 2, xas,
                        _ => _.Xa.TenXa,
                        _ => _.HuyenTenHuyen
                        );

                });
        }
    }
}