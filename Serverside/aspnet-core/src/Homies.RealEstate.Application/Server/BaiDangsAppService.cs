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
        private readonly IRepository<HinhAnh, int> _lookup_hinhAnhRepository;

        public BaiDangsAppService(IRepository<BaiDang> baiDangRepository, IBaiDangsExcelExporter baiDangsExcelExporter, IRepository<User, long> lookup_userRepository, IRepository<DanhMuc, int> lookup_danhMucRepository, IRepository<Xa, int> lookup_xaRepository, IRepository<HinhAnh, int> lookup_hinhAnhRepository)
        {
            _baiDangRepository = baiDangRepository;
            _baiDangsExcelExporter = baiDangsExcelExporter;
            _lookup_userRepository = lookup_userRepository;
            _lookup_danhMucRepository = lookup_danhMucRepository;
            _lookup_xaRepository = lookup_xaRepository;
            _lookup_hinhAnhRepository = lookup_hinhAnhRepository;
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
                                   Id = o.Id
                               },
                               UserName = s1 == null || s1.Name == null ? "" : s1.Name.ToString(),
                               DanhMucTenDanhMuc = s2 == null || s2.TenDanhMuc == null ? "" : s2.TenDanhMuc.ToString(),
                               XaTenXa = s3 == null || s3.TenXa == null ? "" : s3.TenXa.ToString(),
                               FeaturedImage = _lookup_hinhAnhRepository.FirstOrDefault(e => e.BaiDangId == o.Id).DuongDan
                           };

            var totalCount = await filteredBaiDangs.CountAsync();

            return new PagedResultDto<GetBaiDangForViewDto>(
                totalCount,
                await baiDangs.ToListAsync()
            );
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
                                 Id = o.Id
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
            var user = GetCurrentUserAsync();
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
                                   Id = o.Id
                               },
                               UserName = s1 == null || s1.Name == null ? "" : s1.Name.ToString(),
                               DanhMucTenDanhMuc = s2 == null || s2.TenDanhMuc == null ? "" : s2.TenDanhMuc.ToString(),
                               XaTenXa = s3 == null || s3.TenXa == null ? "" : s3.TenXa.ToString()
                           };

            var totalCount = await filteredBaiDangs.CountAsync();

            return new PagedResultDto<GetBaiDangForViewDto>(
                totalCount,
                await baiDangs.ToListAsync()
            );
        }
    }
}