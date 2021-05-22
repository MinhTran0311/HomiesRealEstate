using Homies.RealEstate.Authorization.Users;
using Homies.RealEstate.Server;
using Homies.RealEstate.Server;

using System;
using System.Linq;
using System.Linq.Dynamic.Core;
using Abp.Linq.Extensions;
using System.Collections.Generic;
using System.Threading.Tasks;
using Abp.Domain.Repositories;
using Homies.RealEstate.Server.Exporting;
using Homies.RealEstate.Server.Dtos;
using Homies.RealEstate.Dto;
using Abp.Application.Services.Dto;
using Homies.RealEstate.Authorization;
using Abp.Extensions;
using Abp.Authorization;
using Microsoft.EntityFrameworkCore;

namespace Homies.RealEstate.Server
{
    [AbpAuthorize(AppPermissions.Pages_BaiDangs)]
    public class BaiDangsAppService : RealEstateAppServiceBase, IBaiDangsAppService
    {
        private readonly IRepository<BaiDang> _baiDangRepository;
        private readonly IBaiDangsExcelExporter _baiDangsExcelExporter;
        private readonly IRepository<User, long> _lookup_userRepository;
        private readonly IRepository<DanhMuc, int> _lookup_danhMucRepository;
        private readonly IRepository<Xa, int> _lookup_xaRepository;
        private readonly IRepository<Huyen, int> _lookup_huyenRepository;
        private readonly IRepository<Tinh, int> _lookup_tinhRepository;
        private readonly IRepository<HinhAnh, int> _lookup_hinhAnhRepository;
        private readonly IRepository<ChiTietBaiDang, int> _lookup_chiTietBaiDangRepository;
        private readonly IRepository<ChiTietHoaDonBaiDang, Guid> _lookup_chiTietHoaDonBaiDangRepository;
        private readonly IRepository<LichSuGiaoDich, Guid> _lookup_lichSuGiaoDichRepository;

        public BaiDangsAppService(IRepository<BaiDang> baiDangRepository, IBaiDangsExcelExporter baiDangsExcelExporter, IRepository<User, long> lookup_userRepository, IRepository<DanhMuc, int> lookup_danhMucRepository, IRepository<Xa, int> lookup_xaRepository, IRepository<HinhAnh, int> lookup_hinhAnhRepository, IRepository<ChiTietBaiDang, int> lookup_chiTietBaiDangRepository, IRepository<ChiTietHoaDonBaiDang, Guid> lookup_chiTietHoaDonBaiDangRepository, IRepository<Huyen, int> lookup_huyenRepository, IRepository<Tinh, int> lookup_tinhRepository, IRepository<LichSuGiaoDich, Guid> lookup_lichSuGiaoDichRepository)
        {
            _baiDangRepository = baiDangRepository;
            _baiDangsExcelExporter = baiDangsExcelExporter;
            _lookup_userRepository = lookup_userRepository;
            _lookup_danhMucRepository = lookup_danhMucRepository;
            _lookup_xaRepository = lookup_xaRepository;
            _lookup_hinhAnhRepository = lookup_hinhAnhRepository;
            _lookup_chiTietBaiDangRepository = lookup_chiTietBaiDangRepository;
            _lookup_chiTietHoaDonBaiDangRepository = lookup_chiTietHoaDonBaiDangRepository;
            _lookup_huyenRepository = lookup_huyenRepository;
            _lookup_tinhRepository = lookup_tinhRepository;
            _lookup_lichSuGiaoDichRepository = lookup_lichSuGiaoDichRepository;
        }

        public async Task<PagedResultDto<GetBaiDangForViewDto>> GetAll(GetAllBaiDangsInput input)
        {

            var filteredBaiDangs = _baiDangRepository.GetAll()
                        .Include(e => e.UserFk)
                        .Include(e => e.DanhMucFk)
                        .Include(e => e.XaFk)
                        .WhereIf(!string.IsNullOrWhiteSpace(input.Filter), e => false || e.TagLoaiBaiDang.Contains(input.Filter) || e.DiaChi.Contains(input.Filter) || e.MoTa.Contains(input.Filter) || e.ToaDoX.Contains(input.Filter) || e.ToaDoY.Contains(input.Filter) || e.TrangThai.Contains(input.Filter) || e.TagTimKiem.Contains(input.Filter) || e.TieuDe.Contains(input.Filter))
                        .WhereIf(!string.IsNullOrWhiteSpace(input.TagLoaiBaiDangFilter), e => e.TagLoaiBaiDang == input.TagLoaiBaiDangFilter)
                        .WhereIf(input.MinThoiDiemDangFilter != null, e => e.ThoiDiemDang >= input.MinThoiDiemDangFilter)
                        .WhereIf(input.MaxThoiDiemDangFilter != null, e => e.ThoiDiemDang <= input.MaxThoiDiemDangFilter)
                        .WhereIf(input.MinThoiHanFilter != null, e => e.ThoiHan >= input.MinThoiHanFilter)
                        .WhereIf(input.MaxThoiHanFilter != null, e => e.ThoiHan <= input.MaxThoiHanFilter)
                        .WhereIf(!string.IsNullOrWhiteSpace(input.DiaChiFilter), e => e.DiaChi == input.DiaChiFilter)
                        .WhereIf(!string.IsNullOrWhiteSpace(input.MoTaFilter), e => e.MoTa == input.MoTaFilter)
                        .WhereIf(!string.IsNullOrWhiteSpace(input.ToaDoXFilter), e => e.ToaDoX == input.ToaDoXFilter)
                        .WhereIf(!string.IsNullOrWhiteSpace(input.ToaDoYFilter), e => e.ToaDoY == input.ToaDoYFilter)
                        .WhereIf(input.MinLuotXemFilter != null, e => e.LuotXem >= input.MinLuotXemFilter)
                        .WhereIf(input.MaxLuotXemFilter != null, e => e.LuotXem <= input.MaxLuotXemFilter)
                        .WhereIf(input.MinLuotYeuThichFilter != null, e => e.LuotYeuThich >= input.MinLuotYeuThichFilter)
                        .WhereIf(input.MaxLuotYeuThichFilter != null, e => e.LuotYeuThich <= input.MaxLuotYeuThichFilter)
                        .WhereIf(input.MinDiemBaiDangFilter != null, e => e.DiemBaiDang >= input.MinDiemBaiDangFilter)
                        .WhereIf(input.MaxDiemBaiDangFilter != null, e => e.DiemBaiDang <= input.MaxDiemBaiDangFilter)
                        .WhereIf(!string.IsNullOrWhiteSpace(input.TrangThaiFilter), e => e.TrangThai == input.TrangThaiFilter)
                        .WhereIf(!string.IsNullOrWhiteSpace(input.TagTimKiemFilter), e => e.TagTimKiem == input.TagTimKiemFilter)
                        .WhereIf(!string.IsNullOrWhiteSpace(input.TieuDeFilter), e => e.TieuDe == input.TieuDeFilter)
                        .WhereIf(!string.IsNullOrWhiteSpace(input.UserNameFilter), e => e.UserFk != null && e.UserFk.Name == input.UserNameFilter)
                        .WhereIf(!string.IsNullOrWhiteSpace(input.DanhMucTenDanhMucFilter), e => e.DanhMucFk != null && e.DanhMucFk.TenDanhMuc == input.DanhMucTenDanhMucFilter)
                        .WhereIf(!string.IsNullOrWhiteSpace(input.XaTenXaFilter), e => e.XaFk != null && e.XaFk.TenXa == input.XaTenXaFilter);

            var pagedAndFilteredBaiDangs = filteredBaiDangs
                .OrderBy(input.Sorting ?? "id asc")
                .PageBy(input);

            var baiDangs = from o in pagedAndFilteredBaiDangs
                           join o1 in _lookup_userRepository.GetAll() on o.UserId equals o1.Id into j1
                           from s1 in j1.DefaultIfEmpty()

                           join o2 in _lookup_danhMucRepository.GetAll() on o.DanhMucId equals o2.Id into j2
                           from s2 in j2.DefaultIfEmpty()

                           join o3 in _lookup_xaRepository.GetAll() on o.XaId equals o3.Id into j3
                           from s3 in j3.DefaultIfEmpty()

                           join o4 in _lookup_huyenRepository.GetAll() on s3.HuyenId equals o4.Id into j4
                           from s4 in j4.DefaultIfEmpty()

                           join o5 in _lookup_tinhRepository.GetAll() on s4.TinhId equals o5.Id into j5
                           from s5 in j5.DefaultIfEmpty()
                           select new GetBaiDangForViewDto()
                           {
                               BaiDang = new BaiDangDto
                               {
                                   TagLoaiBaiDang = o.TagLoaiBaiDang,
                                   ThoiDiemDang = o.ThoiDiemDang,
                                   ThoiHan = o.ThoiHan,
                                   DiaChi = o.DiaChi,
                                   MoTa = o.MoTa,
                                   ToaDoX = o.ToaDoX,
                                   ToaDoY = o.ToaDoY,
                                   LuotXem = o.LuotXem,
                                   LuotYeuThich = o.LuotYeuThich,
                                   DiemBaiDang = o.DiemBaiDang,
                                   TrangThai = o.TrangThai,
                                   TagTimKiem = o.TagTimKiem,
                                   TieuDe = o.TieuDe,
                                   Id = o.Id,
                                   Gia = o.Gia,
                                   DienTich = o.DienTich,
                                   FeaturedImage = o.FeaturedImage,
                                   UserId = o.UserId,
                                   XaId = o.XaId,
                                   DanhMucId = o.DanhMucId

                               },
                               UserName = s1 == null || s1.Name == null ? "" : s1.Name.ToString(),
                               DanhMucTenDanhMuc = s2 == null || s2.TenDanhMuc == null ? "" : s2.TenDanhMuc.ToString(),
                               XaTenXa = s3 == null || s3.TenXa == null ? "" : s3.TenXa.ToString(),
                               HuyenTenHuyen = s3 == null || s4.TenHuyen == null ? "" : s4.TenHuyen.ToString(),
                               TinhTenTinh = s3 == null || s5.TenTinh == null ? "" : s5.TenTinh.ToString(),
                               //FeaturedImage = _lookup_hinhAnhRepository.FirstOrDefault(e => e.BaiDangId == o.Id).DuongDan
                           };

            //baiDangs.Distinct();
            var totalCount = await filteredBaiDangs.CountAsync();

            var list = await baiDangs.ToListAsync();

            if (list.Count == totalCount)
            {
                return new PagedResultDto<GetBaiDangForViewDto>(
                totalCount,
                list
            );
            }
            else
            {
                List<GetBaiDangForViewDto> filteredList = new List<GetBaiDangForViewDto>();
                for (int i = 0; i < list.Count; i++)
                {
                    var e = list[i];
                    if (lookupInListBaiDangs(filteredList, e.BaiDang.Id))
                    {
                        continue;
                    }
                    else
                    {
                        filteredList.Add(e);
                    }
                }
                return new PagedResultDto<GetBaiDangForViewDto>(
                totalCount,
                filteredList
            );
            }
        }

        public async Task<PagedResultDto<GetBaiDangForViewDto>> GetAllTest(GetAllBaiDangsInput input)
        {

            var filteredBaiDangs = _baiDangRepository.GetAll()
                        .Include(e => e.UserFk)
                        .Include(e => e.DanhMucFk)
                        .Include(e => e.XaFk)
                        .WhereIf(!string.IsNullOrWhiteSpace(input.Filter), e => false || e.TagLoaiBaiDang.Contains(input.Filter) || e.DiaChi.Contains(input.Filter) || e.MoTa.Contains(input.Filter) || e.ToaDoX.Contains(input.Filter) || e.ToaDoY.Contains(input.Filter) || e.TrangThai.Contains(input.Filter) || e.TagTimKiem.Contains(input.Filter) || e.TieuDe.Contains(input.Filter))
                        .WhereIf(!string.IsNullOrWhiteSpace(input.TagLoaiBaiDangFilter), e => e.TagLoaiBaiDang == input.TagLoaiBaiDangFilter)
                        .WhereIf(input.MinThoiDiemDangFilter != null, e => e.ThoiDiemDang >= input.MinThoiDiemDangFilter)
                        .WhereIf(input.MaxThoiDiemDangFilter != null, e => e.ThoiDiemDang <= input.MaxThoiDiemDangFilter)
                        .WhereIf(input.MinThoiHanFilter != null, e => e.ThoiHan >= input.MinThoiHanFilter)
                        .WhereIf(input.MaxThoiHanFilter != null, e => e.ThoiHan <= input.MaxThoiHanFilter)
                        .WhereIf(!string.IsNullOrWhiteSpace(input.DiaChiFilter), e => e.DiaChi == input.DiaChiFilter)
                        .WhereIf(!string.IsNullOrWhiteSpace(input.MoTaFilter), e => e.MoTa == input.MoTaFilter)
                        .WhereIf(!string.IsNullOrWhiteSpace(input.ToaDoXFilter), e => e.ToaDoX == input.ToaDoXFilter)
                        .WhereIf(!string.IsNullOrWhiteSpace(input.ToaDoYFilter), e => e.ToaDoY == input.ToaDoYFilter)
                        .WhereIf(input.MinLuotXemFilter != null, e => e.LuotXem >= input.MinLuotXemFilter)
                        .WhereIf(input.MaxLuotXemFilter != null, e => e.LuotXem <= input.MaxLuotXemFilter)
                        .WhereIf(input.MinLuotYeuThichFilter != null, e => e.LuotYeuThich >= input.MinLuotYeuThichFilter)
                        .WhereIf(input.MaxLuotYeuThichFilter != null, e => e.LuotYeuThich <= input.MaxLuotYeuThichFilter)
                        .WhereIf(input.MinDiemBaiDangFilter != null, e => e.DiemBaiDang >= input.MinDiemBaiDangFilter)
                        .WhereIf(input.MaxDiemBaiDangFilter != null, e => e.DiemBaiDang <= input.MaxDiemBaiDangFilter)
                        .WhereIf(!string.IsNullOrWhiteSpace(input.TrangThaiFilter), e => e.TrangThai == input.TrangThaiFilter)
                        .WhereIf(!string.IsNullOrWhiteSpace(input.TagTimKiemFilter), e => e.TagTimKiem == input.TagTimKiemFilter)
                        .WhereIf(!string.IsNullOrWhiteSpace(input.TieuDeFilter), e => e.TieuDe == input.TieuDeFilter)
                        .WhereIf(!string.IsNullOrWhiteSpace(input.UserNameFilter), e => e.UserFk != null && e.UserFk.Name == input.UserNameFilter)
                        .WhereIf(!string.IsNullOrWhiteSpace(input.DanhMucTenDanhMucFilter), e => e.DanhMucFk != null && e.DanhMucFk.TenDanhMuc == input.DanhMucTenDanhMucFilter)
                        .WhereIf(!string.IsNullOrWhiteSpace(input.XaTenXaFilter), e => e.XaFk != null && e.XaFk.TenXa == input.XaTenXaFilter);

            var pagedAndFilteredBaiDangs = filteredBaiDangs
                .OrderBy(input.Sorting ?? "id asc")
                .PageBy(input);

            var baiDangs = from o in pagedAndFilteredBaiDangs
                           join o1 in _lookup_userRepository.GetAll() on o.UserId equals o1.Id into j1
                           from s1 in j1.DefaultIfEmpty()

                           join o2 in _lookup_danhMucRepository.GetAll() on o.DanhMucId equals o2.Id into j2
                           from s2 in j2.DefaultIfEmpty()

                           join o3 in _lookup_xaRepository.GetAll() on o.XaId equals o3.Id into j3
                           from s3 in j3.DefaultIfEmpty()

                           join o4 in _lookup_huyenRepository.GetAll() on s3.HuyenId equals o4.Id into j4
                           from s4 in j4.DefaultIfEmpty()

                           join o5 in _lookup_tinhRepository.GetAll() on s4.TinhId equals o5.Id into j5
                           from s5 in j5.DefaultIfEmpty()

                           select new GetBaiDangForViewDto()
                           {
                               BaiDang = new BaiDangDto
                               {
                                   TagLoaiBaiDang = o.TagLoaiBaiDang,
                                   ThoiDiemDang = o.ThoiDiemDang,
                                   ThoiHan = o.ThoiHan,
                                   DiaChi = o.DiaChi,
                                   MoTa = o.MoTa,
                                   ToaDoX = o.ToaDoX,
                                   ToaDoY = o.ToaDoY,
                                   LuotXem = o.LuotXem,
                                   LuotYeuThich = o.LuotYeuThich,
                                   DiemBaiDang = o.DiemBaiDang,
                                   TrangThai = o.TrangThai,
                                   TagTimKiem = o.TagTimKiem,
                                   TieuDe = o.TieuDe,
                                   Id = o.Id,
                                   Gia = o.Gia,
                                   DienTich = o.DienTich,
                                   FeaturedImage = o.FeaturedImage,
                                   UserId = o.UserId,
                                   XaId = o.XaId,
                                   DanhMucId = o.DanhMucId

                               },
                               UserName = s1 == null || s1.Name == null ? "" : s1.Name.ToString(),
                               DanhMucTenDanhMuc = s2 == null || s2.TenDanhMuc == null ? "" : s2.TenDanhMuc.ToString(),
                               XaTenXa = s3 == null || s3.TenXa == null ? "" : s3.TenXa.ToString(),
                               HuyenTenHuyen = s3 == null || s4.TenHuyen == null ? "" : s4.TenHuyen.ToString(),
                               TinhTenTinh = s3 == null || s5.TenTinh == null ? "" : s5.TenTinh.ToString(),
                           };
            var totalCount = await filteredBaiDangs.CountAsync();

            var list = await baiDangs.ToListAsync();

            if (list.Count == totalCount)
            {
                return new PagedResultDto<GetBaiDangForViewDto>(
                totalCount,
                list
            );
            }
            else
            {
                List<GetBaiDangForViewDto> filteredList = new List<GetBaiDangForViewDto>();
                for (int i = 0; i < list.Count; i++)
                {
                    var e = list[i];
                    if (lookupInListBaiDangs(filteredList, e.BaiDang.Id))
                    {
                        continue;
                    }
                    else
                    {
                        filteredList.Add(e);
                    }
                }
                return new PagedResultDto<GetBaiDangForViewDto>(
                totalCount,
                filteredList
            );
            }
        }

        public async Task<PagedResultDto<GetBaiDangForViewDto>> GetAllByFilter(GetAllBaiDangByFilterInput input)
        {
            var filteredBaiDangs = _baiDangRepository.GetAll()
                        .Include(e => e.UserFk)
                        .Include(e => e.DanhMucFk)
                        .Include(e => e.XaFk)
                        .WhereIf(!string.IsNullOrWhiteSpace(input.Filter), e => false || e.DiaChi.Contains(input.Filter) || e.TagTimKiem.Contains(input.Filter) || e.TieuDe.Contains(input.Filter))
                        .WhereIf(!string.IsNullOrWhiteSpace(input.TagLoaiBaiDangFilter), e => e.TagLoaiBaiDang == input.TagLoaiBaiDangFilter)
                        .WhereIf(!string.IsNullOrWhiteSpace(input.DiaChiFilter), e => e.DiaChi.Contains(input.DiaChiFilter))


                        .WhereIf(!string.IsNullOrWhiteSpace(input.ToaDoXMinFilter), e => float.Parse(e.ToaDoX) > float.Parse(input.ToaDoXMinFilter))
                        .WhereIf(!string.IsNullOrWhiteSpace(input.ToaDoYMinFilter), e => float.Parse(e.ToaDoY) > float.Parse(input.ToaDoYMinFilter))
                        .WhereIf(!string.IsNullOrWhiteSpace(input.ToaDoXMaxFilter), e => float.Parse(e.ToaDoX) < float.Parse(input.ToaDoXMaxFilter))
                        .WhereIf(!string.IsNullOrWhiteSpace(input.ToaDoYMaxFilter), e => float.Parse(e.ToaDoY) < float.Parse(input.ToaDoYMaxFilter))


                        .WhereIf(input.MinDienTichFilter != null, e => e.DienTich >= input.MinDienTichFilter)
                        .WhereIf(input.MaxDienTichFilter != null, e => e.DienTich <= input.MaxDienTichFilter)

                        .WhereIf(input.MinGiaFilter != null, e => e.Gia >= input.MinGiaFilter)
                        .WhereIf(input.MaxGiaFilter != null, e => e.Gia <= input.MaxGiaFilter)


                        .WhereIf(!string.IsNullOrWhiteSpace(input.TagTimKiemFilter), e => e.TagTimKiem.Contains(input.TagTimKiemFilter))
                        .WhereIf(!string.IsNullOrWhiteSpace(input.TieuDeFilter), e => e.TieuDe.Contains(input.TieuDeFilter))
                        .WhereIf(!string.IsNullOrWhiteSpace(input.UserNameFilter), e => e.UserFk != null && e.UserFk.Name.Contains(input.UserNameFilter))
                        
                        .WhereIf(input.XaTenXaFilter != null, e => e.XaFk.TenXa != null && e.XaFk.TenXa.Contains(input.XaTenXaFilter))
                        .WhereIf(input.HuyenTenHuyenFilter != null, e => e.XaFk.HuyenFk.TenHuyen != null && e.XaFk.HuyenFk.TenHuyen.Contains(input.HuyenTenHuyenFilter))
                        .WhereIf(input.TinhTenTinhFilter != null, e => e.XaFk.HuyenFk.TinhFk.TenTinh != null && e.XaFk.HuyenFk.TinhFk.TenTinh.Contains(input.TinhTenTinhFilter));

            var pagedAndFilteredBaiDangs = filteredBaiDangs
                .OrderBy(input.Sorting ?? "id asc")
                .PageBy(input);

            var baiDangs = from o in pagedAndFilteredBaiDangs
                           join o1 in _lookup_userRepository.GetAll() on o.UserId equals o1.Id into j1
                           from s1 in j1.DefaultIfEmpty()

                           join o2 in _lookup_danhMucRepository.GetAll() on o.DanhMucId equals o2.Id into j2
                           from s2 in j2.DefaultIfEmpty()

                           join o3 in _lookup_xaRepository.GetAll() on o.XaId equals o3.Id into j3
                           from s3 in j3.DefaultIfEmpty()

                           join o4 in _lookup_huyenRepository.GetAll() on s3.HuyenId equals o4.Id into j4
                           from s4 in j4.DefaultIfEmpty()

                           join o5 in _lookup_tinhRepository.GetAll() on s4.TinhId equals o5.Id into j5
                           from s5 in j5.DefaultIfEmpty()

                           select new GetBaiDangForViewDto()
                           {
                               BaiDang = new BaiDangDto
                               {
                                   TagLoaiBaiDang = o.TagLoaiBaiDang,
                                   ThoiDiemDang = o.ThoiDiemDang,
                                   ThoiHan = o.ThoiHan,
                                   DiaChi = o.DiaChi,
                                   MoTa = o.MoTa,
                                   ToaDoX = o.ToaDoX,
                                   ToaDoY = o.ToaDoY,
                                   LuotXem = o.LuotXem,
                                   LuotYeuThich = o.LuotYeuThich,
                                   DiemBaiDang = o.DiemBaiDang,
                                   TrangThai = o.TrangThai,
                                   TagTimKiem = o.TagTimKiem,
                                   TieuDe = o.TieuDe,
                                   Id = o.Id,
                                   Gia = o.Gia,
                                   DienTich = o.DienTich,
                                   FeaturedImage = o.FeaturedImage,
                                   UserId = o.UserId,
                                   XaId = o.XaId,
                                   DanhMucId = o.DanhMucId

                               },
                               UserName = s1 == null || s1.Name == null ? "" : s1.Name.ToString(),
                               DanhMucTenDanhMuc = s2 == null || s2.TenDanhMuc == null ? "" : s2.TenDanhMuc.ToString(),
                               XaTenXa = s3 == null || s3.TenXa == null ? "" : s3.TenXa.ToString(),
                               HuyenTenHuyen = s3 == null || s4.TenHuyen == null ? "" : s4.TenHuyen.ToString(),
                               TinhTenTinh = s3 == null || s5.TenTinh == null ? "" : s5.TenTinh.ToString(),
                               //FeaturedImage = _lookup_hinhAnhRepository.FirstOrDefault(e => e.BaiDangId == o.Id).DuongDan
                           };

            //baiDangs.Distinct();
            var totalCount = await filteredBaiDangs.CountAsync();

            var list = await baiDangs.ToListAsync();

            if (list.Count == totalCount)
            {
                return new PagedResultDto<GetBaiDangForViewDto>(
                totalCount,
                list
            );
            }
            else
            {
                List<GetBaiDangForViewDto> filteredList = new List<GetBaiDangForViewDto>();
                for (int i = 0; i < list.Count; i++)
                {
                    var e = list[i];
                    if (lookupInListBaiDangs(filteredList, e.BaiDang.Id))
                    {
                        continue;
                    }
                    else
                    {
                        filteredList.Add(e);
                    }
                }
                return new PagedResultDto<GetBaiDangForViewDto>(
                totalCount,
                filteredList
            );
            }
        }

        private bool lookupInListBaiDangs(List<GetBaiDangForViewDto> list, int baidangId)
        {
            for (int i = 0; i < list.Count; i++)
            {
                if (list[i].BaiDang.Id == baidangId)
                {
                    return true;
                }
            }
            return false;
        }

        public async Task<GetBaiDangForViewDto> GetBaiDangForView(int id)
        {
            var baiDang = await _baiDangRepository.GetAsync(id);

            var output = new GetBaiDangForViewDto { BaiDang = ObjectMapper.Map<BaiDangDto>(baiDang) };

            if (output.BaiDang.UserId != null)
            {
                var _lookupUser = await _lookup_userRepository.FirstOrDefaultAsync((long)output.BaiDang.UserId);
                output.UserName = _lookupUser?.Name?.ToString();
            }

            if (output.BaiDang.DanhMucId != null)
            {
                var _lookupDanhMuc = await _lookup_danhMucRepository.FirstOrDefaultAsync((int)output.BaiDang.DanhMucId);
                output.DanhMucTenDanhMuc = _lookupDanhMuc?.TenDanhMuc?.ToString();
            }

            if (output.BaiDang.XaId != null)
            {
                var _lookupXa = await _lookup_xaRepository.FirstOrDefaultAsync((int)output.BaiDang.XaId);
                output.XaTenXa = _lookupXa?.TenXa?.ToString();
            }

            return output;
        }

        [AbpAuthorize(AppPermissions.Pages_BaiDangs_Edit)]
        public async Task<GetBaiDangForEditOutput> GetBaiDangForEdit(EntityDto input)
        {
            var baiDang = await _baiDangRepository.FirstOrDefaultAsync(input.Id);

            var output = new GetBaiDangForEditOutput { BaiDang = ObjectMapper.Map<CreateOrEditBaiDangDto>(baiDang) };

            if (output.BaiDang.UserId != null)
            {
                var _lookupUser = await _lookup_userRepository.FirstOrDefaultAsync((long)output.BaiDang.UserId);
                output.UserName = _lookupUser?.Name?.ToString();
            }

            if (output.BaiDang.DanhMucId != null)
            {
                var _lookupDanhMuc = await _lookup_danhMucRepository.FirstOrDefaultAsync((int)output.BaiDang.DanhMucId);
                output.DanhMucTenDanhMuc = _lookupDanhMuc?.TenDanhMuc?.ToString();
            }

            if (output.BaiDang.XaId != null)
            {
                var _lookupXa = await _lookup_xaRepository.FirstOrDefaultAsync((int)output.BaiDang.XaId);
                output.XaTenXa = _lookupXa?.TenXa?.ToString();
            }

            return output;
        }

        public async Task CreateBaiDangAndDetails(CreateBaiDangAndDetailsDto input)
        {
            if (input.BaiDang.TagTimKiem.IsNullOrEmpty())
            {
                var danhMucBaiDang = await _lookup_danhMucRepository.FirstOrDefaultAsync(e => e.Id == input.BaiDang.DanhMucId);
                input.BaiDang.TagTimKiem = danhMucBaiDang.Tag != null ? danhMucBaiDang.Tag : "bai dang";
            }
            int baiDangId = await _baiDangRepository.InsertAndGetIdAsync(ObjectMapper.Map<BaiDang>(input.BaiDang));
            if (input.ChiTietBaiDangDtos != null && input.ChiTietBaiDangDtos.Count > 0)
            {
                foreach (CreateOrEditChiTietBaiDangDto chiTiet in input.ChiTietBaiDangDtos)
                {
                    chiTiet.BaiDangId = baiDangId;
                    await _lookup_chiTietBaiDangRepository.InsertAsync(ObjectMapper.Map<ChiTietBaiDang>(chiTiet));
                }
            }

            input.HoaDonBaiDangDto.BaiDangId = baiDangId;
            var hoadonID = await _lookup_chiTietHoaDonBaiDangRepository.InsertAndGetIdAsync(ObjectMapper.Map<ChiTietHoaDonBaiDang>(input.HoaDonBaiDangDto));

            input.LichSuGiaoDichDto.ChiTietHoaDonBaiDangId = hoadonID;
            var lichSuGiaoDich = ObjectMapper.Map<LichSuGiaoDich>(input.LichSuGiaoDichDto);
            await _lookup_lichSuGiaoDichRepository.InsertAsync(lichSuGiaoDich);

            foreach (CreateOrEditHinhAnhDto chiTiet in input.HinhAnhDtos)
            {
                chiTiet.BaiDangId = baiDangId;
                await _lookup_hinhAnhRepository.InsertAsync(ObjectMapper.Map<HinhAnh>(chiTiet));
            }
        }

        public async Task EditBaiDangAndDetails(EditBaiDangAndDetailsDto input)
        {
            if (input.BaiDang != null && input.BaiDang.Id != null)
            {
                var baiDang = await _baiDangRepository.FirstOrDefaultAsync((int)input.BaiDang.Id);
                ObjectMapper.Map(input.BaiDang, baiDang);
            }

            await _lookup_chiTietBaiDangRepository.DeleteAsync(e => e.BaiDangId == input.BaiDang.Id);

            if (input.ChiTietBaiDangDtos != null && input.ChiTietBaiDangDtos.Count > 0)
            {
                foreach (CreateOrEditChiTietBaiDangDto chiTiet in input.ChiTietBaiDangDtos)
                {
                    if (chiTiet.BaiDangId != null)
                    {
                        chiTiet.Id = null;
                        await _lookup_chiTietBaiDangRepository.InsertAsync(ObjectMapper.Map<ChiTietBaiDang>(chiTiet));
                    }
                }
            }

            await _lookup_hinhAnhRepository.DeleteAsync(e => e.BaiDangId == input.BaiDang.Id);

            if (input.HinhAnhDtos != null && input.HinhAnhDtos.Count > 0)
            {
                foreach (CreateOrEditHinhAnhDto hinhAnh in input.HinhAnhDtos)
                {
                    if (hinhAnh.BaiDangId != null)
                    {
                        hinhAnh.Id = null;
                        await _lookup_hinhAnhRepository.InsertAsync(ObjectMapper.Map<HinhAnh>(hinhAnh));
                    }
                }
            }
        }

        public async Task GiaHanBaiDang(GiaHanInput input)
        {
            var baiDang = await _baiDangRepository.FirstOrDefaultAsync(input.baiDangId);
            if (baiDang != null)
            {
                baiDang.ThoiHan = input.ThoiHan;

                
                var hoadonID = await _lookup_chiTietHoaDonBaiDangRepository.InsertAndGetIdAsync(ObjectMapper.Map<ChiTietHoaDonBaiDang>(input.HoaDonBaiDangDto));

                input.LichSuGiaoDichDto.ChiTietHoaDonBaiDangId = hoadonID;
                var lichSuGiaoDich = ObjectMapper.Map<LichSuGiaoDich>(input.LichSuGiaoDichDto);
                await _lookup_lichSuGiaoDichRepository.InsertAsync(lichSuGiaoDich);
            }
        }

        public async Task CreateOrEdit(CreateOrEditBaiDangDto input)
        {
            if (input.Id == null)
            {
                await Create(input);
            }
            else
            {
                await Update(input);
            }
        }

        [AbpAuthorize(AppPermissions.Pages_BaiDangs_Create)]
        protected virtual async Task Create(CreateOrEditBaiDangDto input)
        {
            var baiDang = ObjectMapper.Map<BaiDang>(input);

            await _baiDangRepository.InsertAsync(baiDang);
        }

        [AbpAuthorize(AppPermissions.Pages_BaiDangs_Edit)]
        protected virtual async Task Update(CreateOrEditBaiDangDto input)
        {
            var baiDang = await _baiDangRepository.FirstOrDefaultAsync((int)input.Id);
            ObjectMapper.Map(input, baiDang);
        }

        [AbpAuthorize(AppPermissions.Pages_BaiDangs_Delete)]
        public async Task Delete(EntityDto input)
        {
            await _baiDangRepository.DeleteAsync(input.Id);
        }

        public async Task<FileDto> GetBaiDangsToExcel(GetAllBaiDangsForExcelInput input)
        {

            var filteredBaiDangs = _baiDangRepository.GetAll()
                        .Include(e => e.UserFk)
                        .Include(e => e.DanhMucFk)
                        .Include(e => e.XaFk)
                        .WhereIf(!string.IsNullOrWhiteSpace(input.Filter), e => false || e.TagLoaiBaiDang.Contains(input.Filter) || e.DiaChi.Contains(input.Filter) || e.MoTa.Contains(input.Filter) || e.ToaDoX.Contains(input.Filter) || e.ToaDoY.Contains(input.Filter) || e.TrangThai.Contains(input.Filter) || e.TagTimKiem.Contains(input.Filter) || e.TieuDe.Contains(input.Filter))
                        .WhereIf(!string.IsNullOrWhiteSpace(input.TagLoaiBaiDangFilter), e => e.TagLoaiBaiDang == input.TagLoaiBaiDangFilter)
                        .WhereIf(input.MinThoiDiemDangFilter != null, e => e.ThoiDiemDang >= input.MinThoiDiemDangFilter)
                        .WhereIf(input.MaxThoiDiemDangFilter != null, e => e.ThoiDiemDang <= input.MaxThoiDiemDangFilter)
                        .WhereIf(input.MinThoiHanFilter != null, e => e.ThoiHan >= input.MinThoiHanFilter)
                        .WhereIf(input.MaxThoiHanFilter != null, e => e.ThoiHan <= input.MaxThoiHanFilter)
                        .WhereIf(!string.IsNullOrWhiteSpace(input.DiaChiFilter), e => e.DiaChi == input.DiaChiFilter)
                        .WhereIf(!string.IsNullOrWhiteSpace(input.MoTaFilter), e => e.MoTa == input.MoTaFilter)
                        .WhereIf(!string.IsNullOrWhiteSpace(input.ToaDoXFilter), e => e.ToaDoX == input.ToaDoXFilter)
                        .WhereIf(!string.IsNullOrWhiteSpace(input.ToaDoYFilter), e => e.ToaDoY == input.ToaDoYFilter)
                        .WhereIf(input.MinLuotXemFilter != null, e => e.LuotXem >= input.MinLuotXemFilter)
                        .WhereIf(input.MaxLuotXemFilter != null, e => e.LuotXem <= input.MaxLuotXemFilter)
                        .WhereIf(input.MinLuotYeuThichFilter != null, e => e.LuotYeuThich >= input.MinLuotYeuThichFilter)
                        .WhereIf(input.MaxLuotYeuThichFilter != null, e => e.LuotYeuThich <= input.MaxLuotYeuThichFilter)
                        .WhereIf(input.MinDiemBaiDangFilter != null, e => e.DiemBaiDang >= input.MinDiemBaiDangFilter)
                        .WhereIf(input.MaxDiemBaiDangFilter != null, e => e.DiemBaiDang <= input.MaxDiemBaiDangFilter)
                        .WhereIf(!string.IsNullOrWhiteSpace(input.TrangThaiFilter), e => e.TrangThai == input.TrangThaiFilter)
                        .WhereIf(!string.IsNullOrWhiteSpace(input.TagTimKiemFilter), e => e.TagTimKiem == input.TagTimKiemFilter)
                        .WhereIf(!string.IsNullOrWhiteSpace(input.TieuDeFilter), e => e.TieuDe == input.TieuDeFilter)
                        .WhereIf(!string.IsNullOrWhiteSpace(input.UserNameFilter), e => e.UserFk != null && e.UserFk.Name == input.UserNameFilter)
                        .WhereIf(!string.IsNullOrWhiteSpace(input.DanhMucTenDanhMucFilter), e => e.DanhMucFk != null && e.DanhMucFk.TenDanhMuc == input.DanhMucTenDanhMucFilter)
                        .WhereIf(!string.IsNullOrWhiteSpace(input.XaTenXaFilter), e => e.XaFk != null && e.XaFk.TenXa == input.XaTenXaFilter);

            var query = (from o in filteredBaiDangs
                         join o1 in _lookup_userRepository.GetAll() on o.UserId equals o1.Id into j1
                         from s1 in j1.DefaultIfEmpty()

                         join o2 in _lookup_danhMucRepository.GetAll() on o.DanhMucId equals o2.Id into j2
                         from s2 in j2.DefaultIfEmpty()

                         join o3 in _lookup_xaRepository.GetAll() on o.XaId equals o3.Id into j3
                         from s3 in j3.DefaultIfEmpty()

                         select new GetBaiDangForViewDto()
                         {
                             BaiDang = new BaiDangDto
                             {
                                 TagLoaiBaiDang = o.TagLoaiBaiDang,
                                 ThoiDiemDang = o.ThoiDiemDang,
                                 ThoiHan = o.ThoiHan,
                                 DiaChi = o.DiaChi,
                                 MoTa = o.MoTa,
                                 ToaDoX = o.ToaDoX,
                                 ToaDoY = o.ToaDoY,
                                 LuotXem = o.LuotXem,
                                 LuotYeuThich = o.LuotYeuThich,
                                 DiemBaiDang = o.DiemBaiDang,
                                 TrangThai = o.TrangThai,
                                 TagTimKiem = o.TagTimKiem,
                                 TieuDe = o.TieuDe,
                                 Id = o.Id,
                                 Gia = o.Gia,
                                 DienTich = o.DienTich,
                                 FeaturedImage = o.FeaturedImage,
                                 UserId = o.UserId,
                                 XaId = o.XaId,
                                 DanhMucId = o.DanhMucId

                             },
                             UserName = s1 == null || s1.Name == null ? "" : s1.Name.ToString(),
                             DanhMucTenDanhMuc = s2 == null || s2.TenDanhMuc == null ? "" : s2.TenDanhMuc.ToString(),
                             XaTenXa = s3 == null || s3.TenXa == null ? "" : s3.TenXa.ToString()
                         });

            var baiDangListDtos = await query.ToListAsync();

            return _baiDangsExcelExporter.ExportToFile(baiDangListDtos);
        }

        [AbpAuthorize(AppPermissions.Pages_BaiDangs)]
        public async Task<PagedResultDto<BaiDangUserLookupTableDto>> GetAllUserForLookupTable(GetAllForLookupTableInput input)
        {
            var query = _lookup_userRepository.GetAll().WhereIf(
                   !string.IsNullOrWhiteSpace(input.Filter),
                  e => e.Name != null && e.Name.Contains(input.Filter)
               );

            var totalCount = await query.CountAsync();

            var userList = await query
                .PageBy(input)
                .ToListAsync();

            var lookupTableDtoList = new List<BaiDangUserLookupTableDto>();
            foreach (var user in userList)
            {
                lookupTableDtoList.Add(new BaiDangUserLookupTableDto
                {
                    Id = user.Id,
                    DisplayName = user.Name?.ToString()
                });
            }

            return new PagedResultDto<BaiDangUserLookupTableDto>(
                totalCount,
                lookupTableDtoList
            );
        }

        [AbpAuthorize(AppPermissions.Pages_BaiDangs)]
        public async Task<PagedResultDto<BaiDangDanhMucLookupTableDto>> GetAllDanhMucForLookupTable(GetAllForLookupTableInput input)
        {
            var query = _lookup_danhMucRepository.GetAll().WhereIf(
                   !string.IsNullOrWhiteSpace(input.Filter),
                  e => e.TenDanhMuc != null && e.TenDanhMuc.Contains(input.Filter)
               );

            var totalCount = await query.CountAsync();

            var danhMucList = await query
                .PageBy(input)
                .ToListAsync();

            var lookupTableDtoList = new List<BaiDangDanhMucLookupTableDto>();
            foreach (var danhMuc in danhMucList)
            {
                lookupTableDtoList.Add(new BaiDangDanhMucLookupTableDto
                {
                    Id = danhMuc.Id,
                    DisplayName = danhMuc.TenDanhMuc?.ToString()
                });
            }

            return new PagedResultDto<BaiDangDanhMucLookupTableDto>(
                totalCount,
                lookupTableDtoList
            );
        }

        [AbpAuthorize(AppPermissions.Pages_BaiDangs)]
        public async Task<PagedResultDto<BaiDangXaLookupTableDto>> GetAllXaForLookupTable(GetAllForLookupTableInput input)
        {
            var query = _lookup_xaRepository.GetAll().WhereIf(
                   !string.IsNullOrWhiteSpace(input.Filter),
                  e => e.TenXa != null && e.TenXa.Contains(input.Filter)
               );

            var totalCount = await query.CountAsync();

            var xaList = await query
                .PageBy(input)
                .ToListAsync();

            var lookupTableDtoList = new List<BaiDangXaLookupTableDto>();
            foreach (var xa in xaList)
            {
                lookupTableDtoList.Add(new BaiDangXaLookupTableDto
                {
                    Id = xa.Id,
                    DisplayName = xa.TenXa?.ToString()
                });
            }

            return new PagedResultDto<BaiDangXaLookupTableDto>(
                totalCount,
                lookupTableDtoList
            );
        }
        [AbpAuthorize]
        public async Task<PagedResultDto<GetBaiDangForViewDto>> GetAllBaiDangsByCurrentUser()
        {
            var user = await GetCurrentUserAsync();
            var filteredBaiDangs = _baiDangRepository.GetAll()
                        .Include(e => e.UserFk)
                        .Include(e => e.DanhMucFk)
                        .Include(e => e.XaFk)
                        .Where(e => e.UserId == user.Id);



            var pagedAndFilteredBaiDangs = filteredBaiDangs
                .OrderBy("id asc");

            var baiDangs = from o in pagedAndFilteredBaiDangs
                           join o1 in _lookup_userRepository.GetAll() on o.UserId equals o1.Id into j1
                           from s1 in j1.DefaultIfEmpty()

                           join o2 in _lookup_danhMucRepository.GetAll() on o.DanhMucId equals o2.Id into j2
                           from s2 in j2.DefaultIfEmpty()

                           join o3 in _lookup_xaRepository.GetAll() on o.XaId equals o3.Id into j3
                           from s3 in j3.DefaultIfEmpty()

                           join o4 in _lookup_huyenRepository.GetAll() on s3.HuyenId equals o4.Id into j4
                           from s4 in j4.DefaultIfEmpty()

                           join o5 in _lookup_tinhRepository.GetAll() on s4.TinhId equals o5.Id into j5
                           from s5 in j5.DefaultIfEmpty()

                           join o6 in _lookup_chiTietHoaDonBaiDangRepository.GetAll() on o.Id equals o6.BaiDangId into j6
                           from s6 in j6.DefaultIfEmpty()



                           select new GetBaiDangForViewDto()
                           {
                               BaiDang = new BaiDangDto
                               {
                                   TagLoaiBaiDang = o.TagLoaiBaiDang,
                                   ThoiDiemDang = o.ThoiDiemDang,
                                   ThoiHan = o.ThoiHan,
                                   DiaChi = o.DiaChi,
                                   MoTa = o.MoTa,
                                   ToaDoX = o.ToaDoX,
                                   ToaDoY = o.ToaDoY,
                                   LuotXem = o.LuotXem,
                                   LuotYeuThich = o.LuotYeuThich,
                                   DiemBaiDang = o.DiemBaiDang,
                                   TrangThai = o.TrangThai,
                                   TagTimKiem = o.TagTimKiem,
                                   TieuDe = o.TieuDe,
                                   Id = o.Id,
                                   Gia = o.Gia,
                                   DienTich = o.DienTich,
                                   FeaturedImage = o.FeaturedImage,
                                   UserId = o.UserId,
                                   XaId = o.XaId,
                                   DanhMucId = o.DanhMucId
                               },
                               UserName = s1 == null || s1.Name == null ? "" : s1.Name.ToString(),
                               DanhMucTenDanhMuc = s2 == null || s2.TenDanhMuc == null ? "" : s2.TenDanhMuc.ToString(),
                               XaTenXa = s3 == null || s3.TenXa == null ? "" : s3.TenXa.ToString(),
                               HuyenTenHuyen = s3 == null || s4.TenHuyen == null ? "" : s4.TenHuyen.ToString(),
                               TinhTenTinh = s3 == null || s5.TenTinh == null ? "" : s5.TenTinh.ToString(),
                               ChiTietHoaDon = s6 == null ? null : ObjectMapper.Map<ChiTietHoaDonBaiDangDto>(s6)
                           };

            var totalCount = await filteredBaiDangs.CountAsync();

            var list = await baiDangs.ToListAsync();

            if (list.Count == totalCount)
            {
                return new PagedResultDto<GetBaiDangForViewDto>(
                totalCount,
                list
            );
            }
            else
            {
                for (int i = 0; i < list.Count; i++)
                {
                    for (int j = 0; j < list.Count; j++)
                    {
                        if (list[j].ChiTietHoaDon.BaiDangId == list[i].ChiTietHoaDon.BaiDangId && list[j].ChiTietHoaDon.ThoiDiem < list[i].ChiTietHoaDon.ThoiDiem)
                            list.RemoveAt(j);
                    }
                }

                List<GetBaiDangForViewDto> filteredList = new List<GetBaiDangForViewDto>();
                for (int i = 0; i < list.Count; i++)
                {
                    var e = list[i];
                    if (lookupInListBaiDangs(filteredList, e.BaiDang.Id))
                    {
                        continue;
                    }
                    else
                    {

                        //var duc = _lookup_chiTietHoaDonBaiDangRepository.GetAll().Where(ee => ee.BaiDangId == e.BaiDang.Id).OrderByDescending(r => r.ThoiDiem).First();
                        //var ducc = await _lookup_chiTietHoaDonBaiDangRepository.FirstOrDefaultAsync(ee => ee.ThoiDiem == duc && ee.BaiDangId == e.BaiDang.Id);
                        //e.ChiTietHoaDon = ObjectMapper.Map<ChiTietHoaDonBaiDangDto>(duc);
                        filteredList.Add(e);
                    }
                }

                return new PagedResultDto<GetBaiDangForViewDto>(
                totalCount,
                filteredList
            );
            }
        }
    }
}