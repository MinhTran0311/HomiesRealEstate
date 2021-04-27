using System.Collections.Generic;
using Abp.Runtime.Session;
using Abp.Timing.Timezone;
using Homies.RealEstate.DataExporting.Excel.NPOI;
using Homies.RealEstate.Server.Dtos;
using Homies.RealEstate.Dto;
using Homies.RealEstate.Storage;

namespace Homies.RealEstate.Server.Exporting
{
    public class ChiTietDanhMucsExcelExporter : NpoiExcelExporterBase, IChiTietDanhMucsExcelExporter
    {

        private readonly ITimeZoneConverter _timeZoneConverter;
        private readonly IAbpSession _abpSession;

        public ChiTietDanhMucsExcelExporter(
            ITimeZoneConverter timeZoneConverter,
            IAbpSession abpSession,
            ITempFileCacheManager tempFileCacheManager) :
    base(tempFileCacheManager)
        {
            _timeZoneConverter = timeZoneConverter;
            _abpSession = abpSession;
        }

        public FileDto ExportToFile(List<GetChiTietDanhMucForViewDto> chiTietDanhMucs)
        {
            return CreateExcelPackage(
                "ChiTietDanhMucs.xlsx",
                excelPackage =>
                {

                    var sheet = excelPackage.CreateSheet(L("ChiTietDanhMucs"));

                    AddHeader(
                        sheet,
                        L("GhiChu"),
                        (L("ThuocTinh")) + L("TenThuocTinh"),
                        (L("DanhMuc")) + L("TenDanhMuc")
                        );

                    AddObjects(
                        sheet, 2, chiTietDanhMucs,
                        _ => _.ChiTietDanhMuc.GhiChu,
                        _ => _.ThuocTinhTenThuocTinh,
                        _ => _.DanhMucTenDanhMuc
                        );

                });
        }
    }
}