using System.Collections.Generic;
using Abp.Runtime.Session;
using Abp.Timing.Timezone;
using Homies.RealEstate.DataExporting.Excel.NPOI;
using Homies.RealEstate.Server.Dtos;
using Homies.RealEstate.Dto;
using Homies.RealEstate.Storage;

namespace Homies.RealEstate.Server.Exporting
{
    public class TinhsExcelExporter : NpoiExcelExporterBase, ITinhsExcelExporter
    {

        private readonly ITimeZoneConverter _timeZoneConverter;
        private readonly IAbpSession _abpSession;

        public TinhsExcelExporter(
            ITimeZoneConverter timeZoneConverter,
            IAbpSession abpSession,
            ITempFileCacheManager tempFileCacheManager) :
    base(tempFileCacheManager)
        {
            _timeZoneConverter = timeZoneConverter;
            _abpSession = abpSession;
        }

        public FileDto ExportToFile(List<GetTinhForViewDto> tinhs)
        {
            return CreateExcelPackage(
                "Tinhs.xlsx",
                excelPackage =>
                {

                    var sheet = excelPackage.CreateSheet(L("Tinhs"));

                    AddHeader(
                        sheet,
                        L("TenTinh")
                        );

                    AddObjects(
                        sheet, 2, tinhs,
                        _ => _.Tinh.TenTinh
                        );

                });
        }
    }
}