using System.Collections.Generic;
using Abp.Runtime.Session;
using Abp.Timing.Timezone;
using Homies.RealEstate.DataExporting.Excel.NPOI;
using Homies.RealEstate.Server.Dtos;
using Homies.RealEstate.Dto;
using Homies.RealEstate.Storage;

namespace Homies.RealEstate.Server.Exporting
{
    public class BaiDangsExcelExporter : NpoiExcelExporterBase, IBaiDangsExcelExporter
    {

        private readonly ITimeZoneConverter _timeZoneConverter;
        private readonly IAbpSession _abpSession;

        public BaiDangsExcelExporter(
            ITimeZoneConverter timeZoneConverter,
            IAbpSession abpSession,
            ITempFileCacheManager tempFileCacheManager) :
    base(tempFileCacheManager)
        {
            _timeZoneConverter = timeZoneConverter;
            _abpSession = abpSession;
        }

        public FileDto ExportToFile(List<GetBaiDangForViewDto> baiDangs)
        {
            return CreateExcelPackage(
                "BaiDangs.xlsx",
                excelPackage =>
                {

                    var sheet = excelPackage.CreateSheet(L("BaiDangs"));

                    AddHeader(
                        sheet,
                        L("TagLoaiBaiDang"),
                        L("ThoiDiemDang"),
                        L("ThoiHan"),
                        L("DiaChi"),
                        L("MoTa"),
                        L("ToaDoX"),
                        L("ToaDoY"),
                        L("LuotXem"),
                        L("LuotYeuThich"),
                        L("DiemBaiDang"),
                        L("TrangThai"),
                        L("TagTimKiem"),
                        L("TieuDe"),
                        (L("User")) + L("Name"),
                        (L("DanhMuc")) + L("TenDanhMuc"),
                        (L("Xa")) + L("TenXa")
                        );

                    AddObjects(
                        sheet, 2, baiDangs,
                        _ => _.BaiDang.TagLoaiBaiDang,
                        _ => _timeZoneConverter.Convert(_.BaiDang.ThoiDiemDang, _abpSession.TenantId, _abpSession.GetUserId()),
                        _ => _timeZoneConverter.Convert(_.BaiDang.ThoiHan, _abpSession.TenantId, _abpSession.GetUserId()),
                        _ => _.BaiDang.DiaChi,
                        _ => _.BaiDang.MoTa,
                        _ => _.BaiDang.ToaDoX,
                        _ => _.BaiDang.ToaDoY,
                        _ => _.BaiDang.LuotXem,
                        _ => _.BaiDang.LuotYeuThich,
                        _ => _.BaiDang.DiemBaiDang,
                        _ => _.BaiDang.TrangThai,
                        _ => _.BaiDang.TagTimKiem,
                        _ => _.BaiDang.TieuDe,
                        _ => _.UserName,
                        _ => _.DanhMucTenDanhMuc,
                        _ => _.XaTenXa
                        );

                    for (var i = 1; i <= baiDangs.Count; i++)
                    {
                        SetCellDataFormat(sheet.GetRow(i).Cells[2], "yyyy-mm-dd");
                    }
                    sheet.AutoSizeColumn(2); for (var i = 1; i <= baiDangs.Count; i++)
                    {
                        SetCellDataFormat(sheet.GetRow(i).Cells[3], "yyyy-mm-dd");
                    }
                    sheet.AutoSizeColumn(3);
                });
        }
    }
}