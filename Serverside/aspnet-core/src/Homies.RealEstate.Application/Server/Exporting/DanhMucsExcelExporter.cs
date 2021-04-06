using System.Collections.Generic;
using Abp.Runtime.Session;
using Abp.Timing.Timezone;
using Homies.RealEstate.DataExporting.Excel.NPOI;
using Homies.RealEstate.Server.Dtos;
using Homies.RealEstate.Dto;
using Homies.RealEstate.Storage;

namespace Homies.RealEstate.Server.Exporting
{
    public class DanhMucsExcelExporter : NpoiExcelExporterBase, IDanhMucsExcelExporter
    {

        private readonly ITimeZoneConverter _timeZoneConverter;
        private readonly IAbpSession _abpSession;

        public DanhMucsExcelExporter(
            ITimeZoneConverter timeZoneConverter,
            IAbpSession abpSession,
            ITempFileCacheManager tempFileCacheManager) :
    base(tempFileCacheManager)
        {
            _timeZoneConverter = timeZoneConverter;
            _abpSession = abpSession;
        }

        public FileDto ExportToFile(List<GetDanhMucForViewDto> danhMucs)
        {
            return CreateExcelPackage(
                "DanhMucs.xlsx",
                excelPackage =>
                {

                    var sheet = excelPackage.CreateSheet(L("DanhMucs"));

                    AddHeader(
                        sheet,
                        L("TenDanhMuc"),
                        L("Tag"),
                        L("TrangThai"),
                        L("DanhMucCha")
                        );

                    AddObjects(
                        sheet, 2, danhMucs,
                        _ => _.DanhMuc.TenDanhMuc,
                        _ => _.DanhMuc.Tag,
                        _ => _.DanhMuc.TrangThai,
                        _ => _.DanhMuc.DanhMucCha
                        );

                });
        }
    }
}