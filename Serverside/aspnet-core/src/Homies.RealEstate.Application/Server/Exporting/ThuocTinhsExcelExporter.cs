using System.Collections.Generic;
using Abp.Runtime.Session;
using Abp.Timing.Timezone;
using Homies.RealEstate.DataExporting.Excel.NPOI;
using Homies.RealEstate.Server.Dtos;
using Homies.RealEstate.Dto;
using Homies.RealEstate.Storage;

namespace Homies.RealEstate.Server.Exporting
{
    public class ThuocTinhsExcelExporter : NpoiExcelExporterBase, IThuocTinhsExcelExporter
    {

        private readonly ITimeZoneConverter _timeZoneConverter;
        private readonly IAbpSession _abpSession;

        public ThuocTinhsExcelExporter(
            ITimeZoneConverter timeZoneConverter,
            IAbpSession abpSession,
            ITempFileCacheManager tempFileCacheManager) :
    base(tempFileCacheManager)
        {
            _timeZoneConverter = timeZoneConverter;
            _abpSession = abpSession;
        }

        public FileDto ExportToFile(List<GetThuocTinhForViewDto> thuocTinhs)
        {
            return CreateExcelPackage(
                "ThuocTinhs.xlsx",
                excelPackage =>
                {

                    var sheet = excelPackage.CreateSheet(L("ThuocTinhs"));

                    AddHeader(
                        sheet,
                        L("TenThuocTinh"),
                        L("KieuDuLieu"),
                        L("TrangThai")
                        );

                    AddObjects(
                        sheet, 2, thuocTinhs,
                        _ => _.ThuocTinh.TenThuocTinh,
                        _ => _.ThuocTinh.KieuDuLieu,
                        _ => _.ThuocTinh.TrangThai
                        );

                });
        }
    }
}