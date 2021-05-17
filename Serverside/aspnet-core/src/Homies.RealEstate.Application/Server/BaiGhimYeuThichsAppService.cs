using Homies.RealEstate.Authorization.Users;
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
    [AbpAuthorize(AppPermissions.Pages_BaiGhimYeuThichs)]
    public class BaiGhimYeuThichsAppService : RealEstateAppServiceBase, IBaiGhimYeuThichsAppService
    {
        private readonly IRepository<BaiGhimYeuThich> _baiGhimYeuThichRepository;
        private readonly IBaiGhimYeuThichsExcelExporter _baiGhimYeuThichsExcelExporter;
        private readonly IRepository<User, long> _lookup_userRepository;
        private readonly IRepository<BaiDang, int> _lookup_baiDangRepository;

        public BaiGhimYeuThichsAppService(IRepository<BaiGhimYeuThich> baiGhimYeuThichRepository, IBaiGhimYeuThichsExcelExporter baiGhimYeuThichsExcelExporter, IRepository<User, long> lookup_userRepository, IRepository<BaiDang, int> lookup_baiDangRepository)
        {
            _baiGhimYeuThichRepository = baiGhimYeuThichRepository;
            _baiGhimYeuThichsExcelExporter = baiGhimYeuThichsExcelExporter;
            _lookup_userRepository = lookup_userRepository;
            _lookup_baiDangRepository = lookup_baiDangRepository;

        }

        public async Task<PagedResultDto<GetBaiGhimYeuThichForViewDto>> GetAll(GetAllBaiGhimYeuThichsInput input)
        {

            var filteredBaiGhimYeuThichs = _baiGhimYeuThichRepository.GetAll()
                        .Include(e => e.UserFk)
                        .Include(e => e.BaiDangFk)
                        .WhereIf(!string.IsNullOrWhiteSpace(input.Filter), e => false || e.TrangThai.Contains(input.Filter))
                        .WhereIf(input.MinThoiGianFilter != null, e => e.ThoiGian >= input.MinThoiGianFilter)
                        .WhereIf(input.MaxThoiGianFilter != null, e => e.ThoiGian <= input.MaxThoiGianFilter)
                        .WhereIf(!string.IsNullOrWhiteSpace(input.TrangThaiFilter), e => e.TrangThai == input.TrangThaiFilter)
                        .WhereIf(!string.IsNullOrWhiteSpace(input.UserNameFilter), e => e.UserFk != null && e.UserFk.Name == input.UserNameFilter)
                        .WhereIf(!string.IsNullOrWhiteSpace(input.BaiDangTieuDeFilter), e => e.BaiDangFk != null && e.BaiDangFk.TieuDe == input.BaiDangTieuDeFilter);

            var pagedAndFilteredBaiGhimYeuThichs = filteredBaiGhimYeuThichs
                .OrderBy(input.Sorting ?? "id asc")
                .PageBy(input);

            var baiGhimYeuThichs = from o in pagedAndFilteredBaiGhimYeuThichs
                                   join o1 in _lookup_userRepository.GetAll() on o.UserId equals o1.Id into j1
                                   from s1 in j1.DefaultIfEmpty()

                                   join o2 in _lookup_baiDangRepository.GetAll() on o.BaiDangId equals o2.Id into j2
                                   from s2 in j2.DefaultIfEmpty()

                                   select new GetBaiGhimYeuThichForViewDto()
                                   {
                                       BaiGhimYeuThich = new BaiGhimYeuThichDto
                                       {
                                           ThoiGian = o.ThoiGian,
                                           TrangThai = o.TrangThai,
                                           Id = o.Id
                                       },
                                       UserName = s1 == null || s1.Name == null ? "" : s1.Name.ToString(),
                                       BaiDangTieuDe = s2 == null || s2.TieuDe == null ? "" : s2.TieuDe.ToString()
                                   };

            var totalCount = await filteredBaiGhimYeuThichs.CountAsync();

            return new PagedResultDto<GetBaiGhimYeuThichForViewDto>(
                totalCount,
                await baiGhimYeuThichs.ToListAsync()
            );
        }

        public async Task<GetBaiGhimYeuThichForViewDto> GetBaiGhimYeuThichForView(int id)
        {
            var baiGhimYeuThich = await _baiGhimYeuThichRepository.GetAsync(id);

            var output = new GetBaiGhimYeuThichForViewDto { BaiGhimYeuThich = ObjectMapper.Map<BaiGhimYeuThichDto>(baiGhimYeuThich) };

            if (output.BaiGhimYeuThich.UserId != null)
            {
                var _lookupUser = await _lookup_userRepository.FirstOrDefaultAsync((long)output.BaiGhimYeuThich.UserId);
                output.UserName = _lookupUser?.Name?.ToString();
            }

            if (output.BaiGhimYeuThich.BaiDangId != null)
            {
                var _lookupBaiDang = await _lookup_baiDangRepository.FirstOrDefaultAsync((int)output.BaiGhimYeuThich.BaiDangId);
                output.BaiDangTieuDe = _lookupBaiDang?.TieuDe?.ToString();
            }

            return output;
        }

        [AbpAuthorize(AppPermissions.Pages_BaiGhimYeuThichs_Edit)]
        public async Task<GetBaiGhimYeuThichForEditOutput> GetBaiGhimYeuThichForEdit(EntityDto input)
        {
            var baiGhimYeuThich = await _baiGhimYeuThichRepository.FirstOrDefaultAsync(input.Id);

            var output = new GetBaiGhimYeuThichForEditOutput { BaiGhimYeuThich = ObjectMapper.Map<CreateOrEditBaiGhimYeuThichDto>(baiGhimYeuThich) };

            if (output.BaiGhimYeuThich.UserId != null)
            {
                var _lookupUser = await _lookup_userRepository.FirstOrDefaultAsync((long)output.BaiGhimYeuThich.UserId);
                output.UserName = _lookupUser?.Name?.ToString();
            }

            if (output.BaiGhimYeuThich.BaiDangId != null)
            {
                var _lookupBaiDang = await _lookup_baiDangRepository.FirstOrDefaultAsync((int)output.BaiGhimYeuThich.BaiDangId);
                output.BaiDangTieuDe = _lookupBaiDang?.TieuDe?.ToString();
            }

            return output;
        }

        public async Task CreateOrEdit(CreateOrEditBaiGhimYeuThichDto input)
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

        [AbpAuthorize]
        public async Task CreateOrChangeStatus(CreateOrEditBaiGhimYeuThichDto input)
        {
            var user = await GetCurrentUserAsync();
            var baighim = await _baiGhimYeuThichRepository.FirstOrDefaultAsync(e => e.UserId == user.Id && e.BaiDangId == input.BaiDangId);

            var baiDang = await _lookup_baiDangRepository.FirstOrDefaultAsync(e => e.Id == input.BaiDangId);

            input.UserId = user.Id;
            if (baighim == null)
            {
                await Create(input);
                baiDang.LuotYeuThich += 1;
            }
            else
            {
                input.Id = baighim.Id;
                if (input.TrangThai.Equals("On"))
                {
                    baiDang.LuotYeuThich += 1;
                }
                else if (input.TrangThai.Equals("Off"))
                {
                    baiDang.LuotYeuThich += -1;
                }
                await Update(input);
            }
        }

        [AbpAuthorize]
        public async Task<BaiGhimYeuThichExistingOutput> IsExistOrNot(long postId)
        {
            var user = await GetCurrentUserAsync();
            var baighim = await _baiGhimYeuThichRepository.FirstOrDefaultAsync(e => e.UserId == user.Id && e.BaiDangId == postId);

            return new BaiGhimYeuThichExistingOutput
            {
                Exist = (baighim != null)
            };
        }

        [AbpAuthorize(AppPermissions.Pages_BaiGhimYeuThichs_Create)]
        protected virtual async Task Create(CreateOrEditBaiGhimYeuThichDto input)
        {
            var baiGhimYeuThich = ObjectMapper.Map<BaiGhimYeuThich>(input);

            await _baiGhimYeuThichRepository.InsertAsync(baiGhimYeuThich);
        }

        [AbpAuthorize(AppPermissions.Pages_BaiGhimYeuThichs_Edit)]
        protected virtual async Task Update(CreateOrEditBaiGhimYeuThichDto input)
        {
            var baiGhimYeuThich = await _baiGhimYeuThichRepository.FirstOrDefaultAsync((int)input.Id);
            ObjectMapper.Map(input, baiGhimYeuThich);
        }

        [AbpAuthorize(AppPermissions.Pages_BaiGhimYeuThichs_Delete)]
        public async Task Delete(EntityDto input)
        {
            await _baiGhimYeuThichRepository.DeleteAsync(input.Id);
        }

        public async Task<FileDto> GetBaiGhimYeuThichsToExcel(GetAllBaiGhimYeuThichsForExcelInput input)
        {

            var filteredBaiGhimYeuThichs = _baiGhimYeuThichRepository.GetAll()
                        .Include(e => e.UserFk)
                        .Include(e => e.BaiDangFk)
                        .WhereIf(!string.IsNullOrWhiteSpace(input.Filter), e => false || e.TrangThai.Contains(input.Filter))
                        .WhereIf(input.MinThoiGianFilter != null, e => e.ThoiGian >= input.MinThoiGianFilter)
                        .WhereIf(input.MaxThoiGianFilter != null, e => e.ThoiGian <= input.MaxThoiGianFilter)
                        .WhereIf(!string.IsNullOrWhiteSpace(input.TrangThaiFilter), e => e.TrangThai == input.TrangThaiFilter)
                        .WhereIf(!string.IsNullOrWhiteSpace(input.UserNameFilter), e => e.UserFk != null && e.UserFk.Name == input.UserNameFilter)
                        .WhereIf(!string.IsNullOrWhiteSpace(input.BaiDangTieuDeFilter), e => e.BaiDangFk != null && e.BaiDangFk.TieuDe == input.BaiDangTieuDeFilter);

            var query = (from o in filteredBaiGhimYeuThichs
                         join o1 in _lookup_userRepository.GetAll() on o.UserId equals o1.Id into j1
                         from s1 in j1.DefaultIfEmpty()

                         join o2 in _lookup_baiDangRepository.GetAll() on o.BaiDangId equals o2.Id into j2
                         from s2 in j2.DefaultIfEmpty()

                         select new GetBaiGhimYeuThichForViewDto()
                         {
                             BaiGhimYeuThich = new BaiGhimYeuThichDto
                             {
                                 ThoiGian = o.ThoiGian,
                                 TrangThai = o.TrangThai,
                                 Id = o.Id
                             },
                             UserName = s1 == null || s1.Name == null ? "" : s1.Name.ToString(),
                             BaiDangTieuDe = s2 == null || s2.TieuDe == null ? "" : s2.TieuDe.ToString()
                         });

            var baiGhimYeuThichListDtos = await query.ToListAsync();

            return _baiGhimYeuThichsExcelExporter.ExportToFile(baiGhimYeuThichListDtos);
        }

        [AbpAuthorize(AppPermissions.Pages_BaiGhimYeuThichs)]
        public async Task<PagedResultDto<BaiGhimYeuThichUserLookupTableDto>> GetAllUserForLookupTable(GetAllForLookupTableInput input)
        {
            var query = _lookup_userRepository.GetAll().WhereIf(
                   !string.IsNullOrWhiteSpace(input.Filter),
                  e => e.Name != null && e.Name.Contains(input.Filter)
               );

            var totalCount = await query.CountAsync();

            var userList = await query
                .PageBy(input)
                .ToListAsync();

            var lookupTableDtoList = new List<BaiGhimYeuThichUserLookupTableDto>();
            foreach (var user in userList)
            {
                lookupTableDtoList.Add(new BaiGhimYeuThichUserLookupTableDto
                {
                    Id = user.Id,
                    DisplayName = user.Name?.ToString()
                });
            }

            return new PagedResultDto<BaiGhimYeuThichUserLookupTableDto>(
                totalCount,
                lookupTableDtoList
            );
        }

        [AbpAuthorize(AppPermissions.Pages_BaiGhimYeuThichs)]
        public async Task<PagedResultDto<BaiGhimYeuThichBaiDangLookupTableDto>> GetAllBaiDangForLookupTable(GetAllForLookupTableInput input)
        {
            var query = _lookup_baiDangRepository.GetAll().WhereIf(
                   !string.IsNullOrWhiteSpace(input.Filter),
                  e => e.TieuDe != null && e.TieuDe.Contains(input.Filter)
               );

            var totalCount = await query.CountAsync();

            var baiDangList = await query
                .PageBy(input)
                .ToListAsync();

            var lookupTableDtoList = new List<BaiGhimYeuThichBaiDangLookupTableDto>();
            foreach (var baiDang in baiDangList)
            {
                lookupTableDtoList.Add(new BaiGhimYeuThichBaiDangLookupTableDto
                {
                    Id = baiDang.Id,
                    DisplayName = baiDang.TieuDe?.ToString()
                });
            }

            return new PagedResultDto<BaiGhimYeuThichBaiDangLookupTableDto>(
                totalCount,
                lookupTableDtoList
            );
        }
    }
}