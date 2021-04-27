using System.Collections.Generic;
using Abp.Runtime.Session;
using Abp.Timing.Timezone;
using Homies.RealEstate.DataExporting.Excel.NPOI;
using Homies.RealEstate.Server.Dtos;
using Homies.RealEstate.Dto;
using Homies.RealEstate.Storage;

namespace Homies.RealEstate.Server.Exporting
{
    public class ThamSosExcelExporter : NpoiExcelExporterBase, IThamSosExcelExporter
    {

        private readonly ITimeZoneConverter _timeZoneConverter;
        private readonly IAbpSession _abpSession;

        public ThamSosExcelExporter(
            ITimeZoneConverter timeZoneConverter,
            IAbpSession abpSession,
            ITempFileCacheManager tempFileCacheManager) :
    base(tempFileCacheManager)
        {
            _timeZoneConverter = timeZoneConverter;
            _abpSession = abpSession;
        }

        public FileDto ExportToFile(List<GetThamSoForViewDto> thamSos)
        {
            return CreateExcelPackage(
                "ThamSos.xlsx",
                excelPackage =>
                {

                    var sheet = excelPackage.CreateSheet(L("ThamSos"));

                    AddHeader(
                        sheet,
                        L("TenThamSo"),
                        L("KieuDuLieu"),
                        L("GiaTri")
                        );

                    AddObjects(
                        sheet, 2, thamSos,
                        _ => _.ThamSo.TenThamSo,
                        _ => _.ThamSo.KieuDuLieu,
                        _ => _.ThamSo.GiaTri
                        );

                });
        }
    }
}