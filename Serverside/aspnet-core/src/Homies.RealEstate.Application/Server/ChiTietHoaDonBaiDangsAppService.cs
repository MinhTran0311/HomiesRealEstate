using Homies.RealEstate.Server;
using Homies.RealEstate.Server;
using Homies.RealEstate.Authorization.Users;

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
    [AbpAuthorize(AppPermissions.Pages_ChiTietHoaDonBaiDangs)]
    public class ChiTietHoaDonBaiDangsAppService : RealEstateAppServiceBase, IChiTietHoaDonBaiDangsAppService
    {
        private readonly IRepository<ChiTietHoaDonBaiDang, Guid> _chiTietHoaDonBaiDangRepository;
        private readonly IChiTietHoaDonBaiDangsExcelExporter _chiTietHoaDonBaiDangsExcelExporter;
        private readonly IRepository<BaiDang, int> _lookup_baiDangRepository;
        private readonly IRepository<GoiBaiDang, int> _lookup_goiBaiDangRepository;
        private readonly IRepository<User, long> _lookup_userRepository;

        public ChiTietHoaDonBaiDangsAppService(IRepository<ChiTietHoaDonBaiDang, Guid> chiTietHoaDonBaiDangRepository, IChiTietHoaDonBaiDangsExcelExporter chiTietHoaDonBaiDangsExcelExporter, IRepository<BaiDang, int> lookup_baiDangRepository, IRepository<GoiBaiDang, int> lookup_goiBaiDangRepository, IRepository<User, long> lookup_userRepository)
        {
            _chiTietHoaDonBaiDangRepository = chiTietHoaDonBaiDangRepository;
            _chiTietHoaDonBaiDangsExcelExporter = chiTietHoaDonBaiDangsExcelExporter;
            _lookup_baiDangRepository = lookup_baiDangRepository;
            _lookup_goiBaiDangRepository = lookup_goiBaiDangRepository;
            _lookup_userRepository = lookup_userRepository;

        }

        public async Task<PagedResultDto<GetChiTietHoaDonBaiDangForViewDto>> GetAll(GetAllChiTietHoaDonBaiDangsInput input)
        {

            var filteredChiTietHoaDonBaiDangs = _chiTietHoaDonBaiDangRepository.GetAll()
                        .Include(e => e.BaiDangFk)
                        .Include(e => e.GoiBaiDangFk)
                        .Include(e => e.UserFk)
                        .WhereIf(!string.IsNullOrWhiteSpace(input.Filter), e => false || e.GhiChu.Contains(input.Filter))
                        .WhereIf(input.MinThoiDiemFilter != null, e => e.ThoiDiem >= input.MinThoiDiemFilter)
                        .WhereIf(input.MaxThoiDiemFilter != null, e => e.ThoiDiem <= input.MaxThoiDiemFilter)
                        .WhereIf(input.MinGiaGoiFilter != null, e => e.GiaGoi >= input.MinGiaGoiFilter)
                        .WhereIf(input.MaxGiaGoiFilter != null, e => e.GiaGoi <= input.MaxGiaGoiFilter)
                        .WhereIf(input.MinSoNgayMuaFilter != null, e => e.SoNgayMua >= input.MinSoNgayMuaFilter)
                        .WhereIf(input.MaxSoNgayMuaFilter != null, e => e.SoNgayMua <= input.MaxSoNgayMuaFilter)
                        .WhereIf(input.MinTongTienFilter != null, e => e.TongTien >= input.MinTongTienFilter)
                        .WhereIf(input.MaxTongTienFilter != null, e => e.TongTien <= input.MaxTongTienFilter)
                        .WhereIf(!string.IsNullOrWhiteSpace(input.GhiChuFilter), e => e.GhiChu == input.GhiChuFilter)
                        .WhereIf(!string.IsNullOrWhiteSpace(input.BaiDangTieuDeFilter), e => e.BaiDangFk != null && e.BaiDangFk.TieuDe == input.BaiDangTieuDeFilter)
                        .WhereIf(!string.IsNullOrWhiteSpace(input.GoiBaiDangTenGoiFilter), e => e.GoiBaiDangFk != null && e.GoiBaiDangFk.TenGoi == input.GoiBaiDangTenGoiFilter)
                        .WhereIf(!string.IsNullOrWhiteSpace(input.UserNameFilter), e => e.UserFk != null && e.UserFk.Name == input.UserNameFilter);

            var pagedAndFilteredChiTietHoaDonBaiDangs = filteredChiTietHoaDonBaiDangs
                .OrderBy(input.Sorting ?? "id asc")
                .PageBy(input);

            var chiTietHoaDonBaiDangs = from o in pagedAndFilteredChiTietHoaDonBaiDangs
                                        join o1 in _lookup_baiDangRepository.GetAll() on o.BaiDangId equals o1.Id into j1
                                        from s1 in j1.DefaultIfEmpty()

                                        join o2 in _lookup_goiBaiDangRepository.GetAll() on o.GoiBaiDangId equals o2.Id into j2
                                        from s2 in j2.DefaultIfEmpty()

                                        join o3 in _lookup_userRepository.GetAll() on o.UserId equals o3.Id into j3
                                        from s3 in j3.DefaultIfEmpty()

                                        select new GetChiTietHoaDonBaiDangForViewDto()
                                        {
                                            ChiTietHoaDonBaiDang = new ChiTietHoaDonBaiDangDto
                                            {
                                                ThoiDiem = o.ThoiDiem,
                                                GiaGoi = o.GiaGoi,
                                                SoNgayMua = o.SoNgayMua,
                                                TongTien = o.TongTien,
                                                GhiChu = o.GhiChu,
                                                Id = o.Id
                                            },
                                            BaiDangTieuDe = s1 == null || s1.TieuDe == null ? "" : s1.TieuDe.ToString(),
                                            GoiBaiDangTenGoi = s2 == null || s2.TenGoi == null ? "" : s2.TenGoi.ToString(),
                                            UserName = s3 == null || s3.Name == null ? "" : s3.Name.ToString()
                                        };

            var totalCount = await filteredChiTietHoaDonBaiDangs.CountAsync();

            return new PagedResultDto<GetChiTietHoaDonBaiDangForViewDto>(
                totalCount,
                await chiTietHoaDonBaiDangs.ToListAsync()
            );
        }

        public async Task<GetChiTietHoaDonBaiDangForViewDto> GetChiTietHoaDonBaiDangForView(Guid id)
        {
            var chiTietHoaDonBaiDang = await _chiTietHoaDonBaiDangRepository.GetAsync(id);

            var output = new GetChiTietHoaDonBaiDangForViewDto { ChiTietHoaDonBaiDang = ObjectMapper.Map<ChiTietHoaDonBaiDangDto>(chiTietHoaDonBaiDang) };

            if (output.ChiTietHoaDonBaiDang.BaiDangId != null)
            {
                var _lookupBaiDang = await _lookup_baiDangRepository.FirstOrDefaultAsync((int)output.ChiTietHoaDonBaiDang.BaiDangId);
                output.BaiDangTieuDe = _lookupBaiDang?.TieuDe?.ToString();
            }

            if (output.ChiTietHoaDonBaiDang.GoiBaiDangId != null)
            {
                var _lookupGoiBaiDang = await _lookup_goiBaiDangRepository.FirstOrDefaultAsync((int)output.ChiTietHoaDonBaiDang.GoiBaiDangId);
                output.GoiBaiDangTenGoi = _lookupGoiBaiDang?.TenGoi?.ToString();
            }

            if (output.ChiTietHoaDonBaiDang.UserId != null)
            {
                var _lookupUser = await _lookup_userRepository.FirstOrDefaultAsync((long)output.ChiTietHoaDonBaiDang.UserId);
                output.UserName = _lookupUser?.Name?.ToString();
            }

            return output;
        }

        [AbpAuthorize(AppPermissions.Pages_ChiTietHoaDonBaiDangs_Edit)]
        public async Task<GetChiTietHoaDonBaiDangForEditOutput> GetChiTietHoaDonBaiDangForEdit(EntityDto<Guid> input)
        {
            var chiTietHoaDonBaiDang = await _chiTietHoaDonBaiDangRepository.FirstOrDefaultAsync(input.Id);

            var output = new GetChiTietHoaDonBaiDangForEditOutput { ChiTietHoaDonBaiDang = ObjectMapper.Map<CreateOrEditChiTietHoaDonBaiDangDto>(chiTietHoaDonBaiDang) };

            if (output.ChiTietHoaDonBaiDang.BaiDangId != null)
            {
                var _lookupBaiDang = await _lookup_baiDangRepository.FirstOrDefaultAsync((int)output.ChiTietHoaDonBaiDang.BaiDangId);
                output.BaiDangTieuDe = _lookupBaiDang?.TieuDe?.ToString();
            }

            if (output.ChiTietHoaDonBaiDang.GoiBaiDangId != null)
            {
                var _lookupGoiBaiDang = await _lookup_goiBaiDangRepository.FirstOrDefaultAsync((int)output.ChiTietHoaDonBaiDang.GoiBaiDangId);
                output.GoiBaiDangTenGoi = _lookupGoiBaiDang?.TenGoi?.ToString();
            }

            if (output.ChiTietHoaDonBaiDang.UserId != null)
            {
                var _lookupUser = await _lookup_userRepository.FirstOrDefaultAsync((long)output.ChiTietHoaDonBaiDang.UserId);
                output.UserName = _lookupUser?.Name?.ToString();
            }

            return output;
        }

        public async Task CreateOrEdit(CreateOrEditChiTietHoaDonBaiDangDto input)
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

        [AbpAuthorize(AppPermissions.Pages_ChiTietHoaDonBaiDangs_Create)]
        protected virtual async Task Create(CreateOrEditChiTietHoaDonBaiDangDto input)
        {
            var chiTietHoaDonBaiDang = ObjectMapper.Map<ChiTietHoaDonBaiDang>(input);

            await _chiTietHoaDonBaiDangRepository.InsertAsync(chiTietHoaDonBaiDang);
        }

        [AbpAuthorize(AppPermissions.Pages_ChiTietHoaDonBaiDangs_Edit)]
        protected virtual async Task Update(CreateOrEditChiTietHoaDonBaiDangDto input)
        {
            var chiTietHoaDonBaiDang = await _chiTietHoaDonBaiDangRepository.FirstOrDefaultAsync((Guid)input.Id);
            ObjectMapper.Map(input, chiTietHoaDonBaiDang);
        }

        [AbpAuthorize(AppPermissions.Pages_ChiTietHoaDonBaiDangs_Delete)]
        public async Task Delete(EntityDto<Guid> input)
        {
            await _chiTietHoaDonBaiDangRepository.DeleteAsync(input.Id);
        }

        public async Task<FileDto> GetChiTietHoaDonBaiDangsToExcel(GetAllChiTietHoaDonBaiDangsForExcelInput input)
        {

            var filteredChiTietHoaDonBaiDangs = _chiTietHoaDonBaiDangRepository.GetAll()
                        .Include(e => e.BaiDangFk)
                        .Include(e => e.GoiBaiDangFk)
                        .Include(e => e.UserFk)
                        .WhereIf(!string.IsNullOrWhiteSpace(input.Filter), e => false || e.GhiChu.Contains(input.Filter))
                        .WhereIf(input.MinThoiDiemFilter != null, e => e.ThoiDiem >= input.MinThoiDiemFilter)
                        .WhereIf(input.MaxThoiDiemFilter != null, e => e.ThoiDiem <= input.MaxThoiDiemFilter)
                        .WhereIf(input.MinGiaGoiFilter != null, e => e.GiaGoi >= input.MinGiaGoiFilter)
                        .WhereIf(input.MaxGiaGoiFilter != null, e => e.GiaGoi <= input.MaxGiaGoiFilter)
                        .WhereIf(input.MinSoNgayMuaFilter != null, e => e.SoNgayMua >= input.MinSoNgayMuaFilter)
                        .WhereIf(input.MaxSoNgayMuaFilter != null, e => e.SoNgayMua <= input.MaxSoNgayMuaFilter)
                        .WhereIf(input.MinTongTienFilter != null, e => e.TongTien >= input.MinTongTienFilter)
                        .WhereIf(input.MaxTongTienFilter != null, e => e.TongTien <= input.MaxTongTienFilter)
                        .WhereIf(!string.IsNullOrWhiteSpace(input.GhiChuFilter), e => e.GhiChu == input.GhiChuFilter)
                        .WhereIf(!string.IsNullOrWhiteSpace(input.BaiDangTieuDeFilter), e => e.BaiDangFk != null && e.BaiDangFk.TieuDe == input.BaiDangTieuDeFilter)
                        .WhereIf(!string.IsNullOrWhiteSpace(input.GoiBaiDangTenGoiFilter), e => e.GoiBaiDangFk != null && e.GoiBaiDangFk.TenGoi == input.GoiBaiDangTenGoiFilter)
                        .WhereIf(!string.IsNullOrWhiteSpace(input.UserNameFilter), e => e.UserFk != null && e.UserFk.Name == input.UserNameFilter);

            var query = (from o in filteredChiTietHoaDonBaiDangs
                         join o1 in _lookup_baiDangRepository.GetAll() on o.BaiDangId equals o1.Id into j1
                         from s1 in j1.DefaultIfEmpty()

                         join o2 in _lookup_goiBaiDangRepository.GetAll() on o.GoiBaiDangId equals o2.Id into j2
                         from s2 in j2.DefaultIfEmpty()

                         join o3 in _lookup_userRepository.GetAll() on o.UserId equals o3.Id into j3
                         from s3 in j3.DefaultIfEmpty()

                         select new GetChiTietHoaDonBaiDangForViewDto()
                         {
                             ChiTietHoaDonBaiDang = new ChiTietHoaDonBaiDangDto
                             {
                                 ThoiDiem = o.ThoiDiem,
                                 GiaGoi = o.GiaGoi,
                                 SoNgayMua = o.SoNgayMua,
                                 TongTien = o.TongTien,
                                 GhiChu = o.GhiChu,
                                 Id = o.Id
                             },
                             BaiDangTieuDe = s1 == null || s1.TieuDe == null ? "" : s1.TieuDe.ToString(),
                             GoiBaiDangTenGoi = s2 == null || s2.TenGoi == null ? "" : s2.TenGoi.ToString(),
                             UserName = s3 == null || s3.Name == null ? "" : s3.Name.ToString()
                         });

            var chiTietHoaDonBaiDangListDtos = await query.ToListAsync();

            return _chiTietHoaDonBaiDangsExcelExporter.ExportToFile(chiTietHoaDonBaiDangListDtos);
        }

        [AbpAuthorize(AppPermissions.Pages_ChiTietHoaDonBaiDangs)]
        public async Task<PagedResultDto<ChiTietHoaDonBaiDangBaiDangLookupTableDto>> GetAllBaiDangForLookupTable(GetAllForLookupTableInput input)
        {
            var query = _lookup_baiDangRepository.GetAll().WhereIf(
                   !string.IsNullOrWhiteSpace(input.Filter),
                  e => e.TieuDe != null && e.TieuDe.Contains(input.Filter)
               );

            var totalCount = await query.CountAsync();

            var baiDangList = await query
                .PageBy(input)
                .ToListAsync();

            var lookupTableDtoList = new List<ChiTietHoaDonBaiDangBaiDangLookupTableDto>();
            foreach (var baiDang in baiDangList)
            {
                lookupTableDtoList.Add(new ChiTietHoaDonBaiDangBaiDangLookupTableDto
                {
                    Id = baiDang.Id,
                    DisplayName = baiDang.TieuDe?.ToString()
                });
            }

            return new PagedResultDto<ChiTietHoaDonBaiDangBaiDangLookupTableDto>(
                totalCount,
                lookupTableDtoList
            );
        }

        [AbpAuthorize(AppPermissions.Pages_ChiTietHoaDonBaiDangs)]
        public async Task<PagedResultDto<ChiTietHoaDonBaiDangGoiBaiDangLookupTableDto>> GetAllGoiBaiDangForLookupTable(GetAllForLookupTableInput input)
        {
            var query = _lookup_goiBaiDangRepository.GetAll().WhereIf(
                   !string.IsNullOrWhiteSpace(input.Filter),
                  e => e.TenGoi != null && e.TenGoi.Contains(input.Filter)
               );

            var totalCount = await query.CountAsync();

            var goiBaiDangList = await query
                .PageBy(input)
                .ToListAsync();

            var lookupTableDtoList = new List<ChiTietHoaDonBaiDangGoiBaiDangLookupTableDto>();
            foreach (var goiBaiDang in goiBaiDangList)
            {
                lookupTableDtoList.Add(new ChiTietHoaDonBaiDangGoiBaiDangLookupTableDto
                {
                    Id = goiBaiDang.Id,
                    DisplayName = goiBaiDang.TenGoi?.ToString()
                });
            }

            return new PagedResultDto<ChiTietHoaDonBaiDangGoiBaiDangLookupTableDto>(
                totalCount,
                lookupTableDtoList
            );
        }

        [AbpAuthorize(AppPermissions.Pages_ChiTietHoaDonBaiDangs)]
        public async Task<PagedResultDto<ChiTietHoaDonBaiDangUserLookupTableDto>> GetAllUserForLookupTable(GetAllForLookupTableInput input)
        {
            var query = _lookup_userRepository.GetAll().WhereIf(
                   !string.IsNullOrWhiteSpace(input.Filter),
                  e => e.Name != null && e.Name.Contains(input.Filter)
               );

            var totalCount = await query.CountAsync();

            var userList = await query
                .PageBy(input)
                .ToListAsync();

            var lookupTableDtoList = new List<ChiTietHoaDonBaiDangUserLookupTableDto>();
            foreach (var user in userList)
            {
                lookupTableDtoList.Add(new ChiTietHoaDonBaiDangUserLookupTableDto
                {
                    Id = user.Id,
                    DisplayName = user.Name?.ToString()
                });
            }

            return new PagedResultDto<ChiTietHoaDonBaiDangUserLookupTableDto>(
                totalCount,
                lookupTableDtoList
            );
        }
    }
}