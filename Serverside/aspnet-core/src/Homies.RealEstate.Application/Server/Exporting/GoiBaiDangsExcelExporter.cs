using System.Collections.Generic;
using Abp.Runtime.Session;
using Abp.Timing.Timezone;
using Homies.RealEstate.DataExporting.Excel.NPOI;
using Homies.RealEstate.Server.Dtos;
using Homies.RealEstate.Dto;
using Homies.RealEstate.Storage;

namespace Homies.RealEstate.Server.Exporting
{
    public class GoiBaiDangsExcelExporter : NpoiExcelExporterBase, IGoiBaiDangsExcelExporter
    {

        private readonly ITimeZoneConverter _timeZoneConverter;
        private readonly IAbpSession _abpSession;

        public GoiBaiDangsExcelExporter(
            ITimeZoneConverter timeZoneConverter,
            IAbpSession abpSession,
            ITempFileCacheManager tempFileCacheManager) :
    base(tempFileCacheManager)
        {
            _timeZoneConverter = timeZoneConverter;
            _abpSession = abpSession;
        }

        public FileDto ExportToFile(List<GetGoiBaiDangForViewDto> goiBaiDangs)
        {
            return CreateExcelPackage(
                "GoiBaiDangs.xlsx",
                excelPackage =>
                {

                    var sheet = excelPackage.CreateSheet(L("GoiBaiDangs"));

                    AddHeader(
                        sheet,
                        L("TenGoi"),
                        L("Phi"),
                        L("DoUuTien"),
                        L("ThoiGianToiThieu"),
                        L("MoTa"),
                        L("TrangThai")
                        );

                    AddObjects(
                        sheet, 2, goiBaiDangs,
                        _ => _.GoiBaiDang.TenGoi,
                        _ => _.GoiBaiDang.Phi,
                        _ => _.GoiBaiDang.DoUuTien,
                        _ => _.GoiBaiDang.ThoiGianToiThieu,
                        _ => _.GoiBaiDang.MoTa,
                        _ => _.GoiBaiDang.TrangThai
                        );

                });
        }
    }
}