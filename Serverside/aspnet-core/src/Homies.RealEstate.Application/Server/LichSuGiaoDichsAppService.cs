using Homies.RealEstate.Authorization.Users;
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
    [AbpAuthorize(AppPermissions.Pages_LichSuGiaoDichs)]
    public class LichSuGiaoDichsAppService : RealEstateAppServiceBase, ILichSuGiaoDichsAppService
    {
        private readonly IRepository<LichSuGiaoDich, Guid> _lichSuGiaoDichRepository;
        private readonly ILichSuGiaoDichsExcelExporter _lichSuGiaoDichsExcelExporter;
        private readonly IRepository<User, long> _lookup_userRepository;
        private readonly IRepository<ChiTietHoaDonBaiDang, Guid> _lookup_chiTietHoaDonBaiDangRepository;

        public LichSuGiaoDichsAppService(IRepository<LichSuGiaoDich, Guid> lichSuGiaoDichRepository, ILichSuGiaoDichsExcelExporter lichSuGiaoDichsExcelExporter, IRepository<User, long> lookup_userRepository, IRepository<ChiTietHoaDonBaiDang, Guid> lookup_chiTietHoaDonBaiDangRepository)
        {
            _lichSuGiaoDichRepository = lichSuGiaoDichRepository;
            _lichSuGiaoDichsExcelExporter = lichSuGiaoDichsExcelExporter;
            _lookup_userRepository = lookup_userRepository;
            _lookup_chiTietHoaDonBaiDangRepository = lookup_chiTietHoaDonBaiDangRepository;

        }

        public async Task<PagedResultDto<GetLichSuGiaoDichForViewDto>> GetAll(GetAllLichSuGiaoDichsInput input)
        {

            var filteredLichSuGiaoDichs = _lichSuGiaoDichRepository.GetAll()
                        .Include(e => e.UserFk)
                        .Include(e => e.ChiTietHoaDonBaiDangFk)
                        .Include(e => e.KiemDuyetVienFk)
                        .WhereIf(!string.IsNullOrWhiteSpace(input.Filter), e => false || e.GhiChu.Contains(input.Filter))
                        .WhereIf(input.MinSoTienFilter != null, e => e.SoTien >= input.MinSoTienFilter)
                        .WhereIf(input.MaxSoTienFilter != null, e => e.SoTien <= input.MaxSoTienFilter)
                        .WhereIf(input.MinThoiDiemFilter != null, e => e.ThoiDiem >= input.MinThoiDiemFilter)
                        .WhereIf(input.MaxThoiDiemFilter != null, e => e.ThoiDiem <= input.MaxThoiDiemFilter)
                        .WhereIf(!string.IsNullOrWhiteSpace(input.GhiChuFilter), e => e.GhiChu == input.GhiChuFilter)
                        .WhereIf(!string.IsNullOrWhiteSpace(input.UserNameFilter), e => e.UserFk != null && e.UserFk.Name == input.UserNameFilter)
                        .WhereIf(!string.IsNullOrWhiteSpace(input.ChiTietHoaDonBaiDangGhiChuFilter), e => e.ChiTietHoaDonBaiDangFk != null && e.ChiTietHoaDonBaiDangFk.GhiChu == input.ChiTietHoaDonBaiDangGhiChuFilter)
                        .WhereIf(!string.IsNullOrWhiteSpace(input.UserName2Filter), e => e.KiemDuyetVienFk != null && e.KiemDuyetVienFk.Name == input.UserName2Filter);

            var pagedAndFilteredLichSuGiaoDichs = filteredLichSuGiaoDichs
                .OrderBy(input.Sorting ?? "id asc")
                .PageBy(input);

            var lichSuGiaoDichs = from o in pagedAndFilteredLichSuGiaoDichs
                                  join o1 in _lookup_userRepository.GetAll() on o.UserId equals o1.Id into j1
                                  from s1 in j1.DefaultIfEmpty()

                                  join o2 in _lookup_chiTietHoaDonBaiDangRepository.GetAll() on o.ChiTietHoaDonBaiDangId equals o2.Id into j2
                                  from s2 in j2.DefaultIfEmpty()

                                  join o3 in _lookup_userRepository.GetAll() on o.KiemDuyetVienId equals o3.Id into j3
                                  from s3 in j3.DefaultIfEmpty()

                                  select new GetLichSuGiaoDichForViewDto()
                                  {
                                      LichSuGiaoDich = new LichSuGiaoDichDto
                                      {
                                          SoTien = o.SoTien,
                                          ThoiDiem = o.ThoiDiem,
                                          GhiChu = o.GhiChu,
                                          Id = o.Id,
                                          UserId = s1.Id,
                                          ChiTietHoaDonBaiDangId = s2.Id,
                                          KiemDuyetVienId = o.KiemDuyetVienId
                                      },
                                      UserName = s1 == null || s1.Name == null ? "" : s1.Name.ToString(),
                                      ChiTietHoaDonBaiDangGhiChu = s2 == null || s2.GhiChu == null ? "" : s2.GhiChu.ToString(),
                                      UserName2 = s3 == null || s3.Name == null ? "" : s3.Name.ToString()
                                  };

            var totalCount = await filteredLichSuGiaoDichs.CountAsync();

            return new PagedResultDto<GetLichSuGiaoDichForViewDto>(
                totalCount,
                await lichSuGiaoDichs.ToListAsync()
            );
        }

        public async Task<GetLichSuGiaoDichForViewDto> GetLichSuGiaoDichForView(Guid id)
        {
            var lichSuGiaoDich = await _lichSuGiaoDichRepository.GetAsync(id);

            var output = new GetLichSuGiaoDichForViewDto { LichSuGiaoDich = ObjectMapper.Map<LichSuGiaoDichDto>(lichSuGiaoDich) };

            if (output.LichSuGiaoDich.UserId != null)
            {
                var _lookupUser = await _lookup_userRepository.FirstOrDefaultAsync((long)output.LichSuGiaoDich.UserId);
                output.UserName = _lookupUser?.Name?.ToString();
            }

            if (output.LichSuGiaoDich.ChiTietHoaDonBaiDangId != null)
            {
                var _lookupChiTietHoaDonBaiDang = await _lookup_chiTietHoaDonBaiDangRepository.FirstOrDefaultAsync((Guid)output.LichSuGiaoDich.ChiTietHoaDonBaiDangId);
                output.ChiTietHoaDonBaiDangGhiChu = _lookupChiTietHoaDonBaiDang?.GhiChu?.ToString();
            }

            if (output.LichSuGiaoDich.KiemDuyetVienId != null)
            {
                var _lookupUser = await _lookup_userRepository.FirstOrDefaultAsync((long)output.LichSuGiaoDich.KiemDuyetVienId);
                output.UserName2 = _lookupUser?.Name?.ToString();
            }

            return output;
        }

        [AbpAuthorize(AppPermissions.Pages_LichSuGiaoDichs_Edit)]
        public async Task<GetLichSuGiaoDichForEditOutput> GetLichSuGiaoDichForEdit(EntityDto<Guid> input)
        {
            var lichSuGiaoDich = await _lichSuGiaoDichRepository.FirstOrDefaultAsync(input.Id);

            var output = new GetLichSuGiaoDichForEditOutput { LichSuGiaoDich = ObjectMapper.Map<CreateOrEditLichSuGiaoDichDto>(lichSuGiaoDich) };

            if (output.LichSuGiaoDich.UserId != null)
            {
                var _lookupUser = await _lookup_userRepository.FirstOrDefaultAsync((long)output.LichSuGiaoDich.UserId);
                output.UserName = _lookupUser?.Name?.ToString();
            }

            if (output.LichSuGiaoDich.ChiTietHoaDonBaiDangId != null)
            {
                var _lookupChiTietHoaDonBaiDang = await _lookup_chiTietHoaDonBaiDangRepository.FirstOrDefaultAsync((Guid)output.LichSuGiaoDich.ChiTietHoaDonBaiDangId);
                output.ChiTietHoaDonBaiDangGhiChu = _lookupChiTietHoaDonBaiDang?.GhiChu?.ToString();
            }

            if (output.LichSuGiaoDich.KiemDuyetVienId != null)
            {
                var _lookupUser = await _lookup_userRepository.FirstOrDefaultAsync((long)output.LichSuGiaoDich.KiemDuyetVienId);
                output.UserName2 = _lookupUser?.Name?.ToString();
            }

            return output;
        }

        public async Task CreateOrEdit(CreateOrEditLichSuGiaoDichDto input)
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

        [AbpAuthorize(AppPermissions.Pages_LichSuGiaoDichs_Create)]
        protected virtual async Task Create(CreateOrEditLichSuGiaoDichDto input)
        {
            var lichSuGiaoDich = ObjectMapper.Map<LichSuGiaoDich>(input);

            await _lichSuGiaoDichRepository.InsertAsync(lichSuGiaoDich);
        }

        [AbpAuthorize(AppPermissions.Pages_LichSuGiaoDichs_Edit)]
        protected virtual async Task Update(CreateOrEditLichSuGiaoDichDto input)
        {
            var lichSuGiaoDich = await _lichSuGiaoDichRepository.FirstOrDefaultAsync((Guid)input.Id);
            ObjectMapper.Map(input, lichSuGiaoDich);
        }

        [AbpAuthorize(AppPermissions.Pages_LichSuGiaoDichs_Delete)]
        public async Task Delete(EntityDto<Guid> input)
        {
            await _lichSuGiaoDichRepository.DeleteAsync(input.Id);
        }

        public async Task<FileDto> GetLichSuGiaoDichsToExcel(GetAllLichSuGiaoDichsForExcelInput input)
        {

            var filteredLichSuGiaoDichs = _lichSuGiaoDichRepository.GetAll()
                        .Include(e => e.UserFk)
                        .Include(e => e.ChiTietHoaDonBaiDangFk)
                        .Include(e => e.KiemDuyetVienFk)
                        .WhereIf(!string.IsNullOrWhiteSpace(input.Filter), e => false || e.GhiChu.Contains(input.Filter))
                        .WhereIf(input.MinSoTienFilter != null, e => e.SoTien >= input.MinSoTienFilter)
                        .WhereIf(input.MaxSoTienFilter != null, e => e.SoTien <= input.MaxSoTienFilter)
                        .WhereIf(input.MinThoiDiemFilter != null, e => e.ThoiDiem >= input.MinThoiDiemFilter)
                        .WhereIf(input.MaxThoiDiemFilter != null, e => e.ThoiDiem <= input.MaxThoiDiemFilter)
                        .WhereIf(!string.IsNullOrWhiteSpace(input.GhiChuFilter), e => e.GhiChu == input.GhiChuFilter)
                        .WhereIf(!string.IsNullOrWhiteSpace(input.UserNameFilter), e => e.UserFk != null && e.UserFk.Name == input.UserNameFilter)
                        .WhereIf(!string.IsNullOrWhiteSpace(input.ChiTietHoaDonBaiDangGhiChuFilter), e => e.ChiTietHoaDonBaiDangFk != null && e.ChiTietHoaDonBaiDangFk.GhiChu == input.ChiTietHoaDonBaiDangGhiChuFilter)
                        .WhereIf(!string.IsNullOrWhiteSpace(input.UserName2Filter), e => e.KiemDuyetVienFk != null && e.KiemDuyetVienFk.Name == input.UserName2Filter);

            var query = (from o in filteredLichSuGiaoDichs
                         join o1 in _lookup_userRepository.GetAll() on o.UserId equals o1.Id into j1
                         from s1 in j1.DefaultIfEmpty()

                         join o2 in _lookup_chiTietHoaDonBaiDangRepository.GetAll() on o.ChiTietHoaDonBaiDangId equals o2.Id into j2
                         from s2 in j2.DefaultIfEmpty()

                         join o3 in _lookup_userRepository.GetAll() on o.KiemDuyetVienId equals o3.Id into j3
                         from s3 in j3.DefaultIfEmpty()

                         select new GetLichSuGiaoDichForViewDto()
                         {
                             LichSuGiaoDich = new LichSuGiaoDichDto
                             {
                                 SoTien = o.SoTien,
                                 ThoiDiem = o.ThoiDiem,
                                 GhiChu = o.GhiChu,
                                 Id = o.Id
                             },
                             UserName = s1 == null || s1.Name == null ? "" : s1.Name.ToString(),
                             ChiTietHoaDonBaiDangGhiChu = s2 == null || s2.GhiChu == null ? "" : s2.GhiChu.ToString(),
                             UserName2 = s3 == null || s3.Name == null ? "" : s3.Name.ToString()
                         });

            var lichSuGiaoDichListDtos = await query.ToListAsync();

            return _lichSuGiaoDichsExcelExporter.ExportToFile(lichSuGiaoDichListDtos);
        }

        [AbpAuthorize(AppPermissions.Pages_LichSuGiaoDichs)]
        public async Task<PagedResultDto<LichSuGiaoDichUserLookupTableDto>> GetAllUserForLookupTable(GetAllForLookupTableInput input)
        {
            var query = _lookup_userRepository.GetAll().WhereIf(
                   !string.IsNullOrWhiteSpace(input.Filter),
                  e => e.Name != null && e.Name.Contains(input.Filter)
               );

            var totalCount = await query.CountAsync();

            var userList = await query
                .PageBy(input)
                .ToListAsync();

            var lookupTableDtoList = new List<LichSuGiaoDichUserLookupTableDto>();
            foreach (var user in userList)
            {
                lookupTableDtoList.Add(new LichSuGiaoDichUserLookupTableDto
                {
                    Id = user.Id,
                    DisplayName = user.Name?.ToString()
                });
            }

            return new PagedResultDto<LichSuGiaoDichUserLookupTableDto>(
                totalCount,
                lookupTableDtoList
            );
        }

        [AbpAuthorize(AppPermissions.Pages_LichSuGiaoDichs)]
        public async Task<PagedResultDto<LichSuGiaoDichChiTietHoaDonBaiDangLookupTableDto>> GetAllChiTietHoaDonBaiDangForLookupTable(GetAllForLookupTableInput input)
        {
            var query = _lookup_chiTietHoaDonBaiDangRepository.GetAll().WhereIf(
                   !string.IsNullOrWhiteSpace(input.Filter),
                  e => e.GhiChu != null && e.GhiChu.Contains(input.Filter)
               );

            var totalCount = await query.CountAsync();

            var chiTietHoaDonBaiDangList = await query
                .PageBy(input)
                .ToListAsync();

            var lookupTableDtoList = new List<LichSuGiaoDichChiTietHoaDonBaiDangLookupTableDto>();
            foreach (var chiTietHoaDonBaiDang in chiTietHoaDonBaiDangList)
            {
                lookupTableDtoList.Add(new LichSuGiaoDichChiTietHoaDonBaiDangLookupTableDto
                {
                    Id = chiTietHoaDonBaiDang.Id.ToString(),
                    DisplayName = chiTietHoaDonBaiDang.GhiChu?.ToString()
                });
            }

            return new PagedResultDto<LichSuGiaoDichChiTietHoaDonBaiDangLookupTableDto>(
                totalCount,
                lookupTableDtoList
            );
        }
        [AbpAuthorize]
        public async Task<PagedResultDto<GetLichSuGiaoDichForViewDto>> GetAllLSGDByCurrentUserAsync(PagedAndSortedResultRequestDto input)
        {
            var user = await GetCurrentUserAsync();
            var filteredLichSuGiaoDichs = _lichSuGiaoDichRepository.GetAll()
                        .Include(e => e.UserFk)
                        .Include(e => e.ChiTietHoaDonBaiDangFk)
                        .Include(e => e.KiemDuyetVienFk)
                        .Where(e => e.UserId == user.Id);

            var pagedAndFilteredLichSuGiaoDichs = filteredLichSuGiaoDichs
                .OrderBy("id asc")
                .PageBy(input);

            var lichSuGiaoDichs = from o in pagedAndFilteredLichSuGiaoDichs
                                  join o1 in _lookup_userRepository.GetAll() on o.UserId equals o1.Id into j1
                                  from s1 in j1.DefaultIfEmpty()

                                  join o2 in _lookup_chiTietHoaDonBaiDangRepository.GetAll() on o.ChiTietHoaDonBaiDangId equals o2.Id into j2
                                  from s2 in j2.DefaultIfEmpty()

                                  join o3 in _lookup_userRepository.GetAll() on o.KiemDuyetVienId equals o3.Id into j3
                                  from s3 in j3.DefaultIfEmpty()

                                  select new GetLichSuGiaoDichForViewDto()
                                  {
                                      LichSuGiaoDich = new LichSuGiaoDichDto
                                      {
                                          SoTien = o.SoTien,
                                          ThoiDiem = o.ThoiDiem,
                                          GhiChu = o.GhiChu,
                                          Id = o.Id,
                                          UserId = user.Id,
                                          ChiTietHoaDonBaiDangId = s2.Id,
                                          KiemDuyetVienId = o.KiemDuyetVienId
                                      },
                                      UserName = s1 == null || s1.Name == null ? "" : s1.Name.ToString(),
                                      ChiTietHoaDonBaiDangGhiChu = s2 == null || s2.GhiChu == null ? "" : s2.GhiChu.ToString(),
                                      UserName2 = s3 == null || s3.Name == null ? "" : s3.Name.ToString()
                                  };

            var totalCount = await filteredLichSuGiaoDichs.CountAsync();

            return new PagedResultDto<GetLichSuGiaoDichForViewDto>(
                totalCount,
                await lichSuGiaoDichs.ToListAsync()
            );
        }

        public async Task KiemDuyetGiaoDich(EntityDto<Guid> input)
        {
            var user = await GetCurrentUserAsync();

            var lsgd = await _lichSuGiaoDichRepository.GetAsync(input.Id);
            if (lsgd.KiemDuyetVienId==null)
            {
                lsgd.KiemDuyetVienId = user.Id;
                lsgd.UserFk.Wallet += lsgd.SoTien;
            }
            




        }


        
    }
}