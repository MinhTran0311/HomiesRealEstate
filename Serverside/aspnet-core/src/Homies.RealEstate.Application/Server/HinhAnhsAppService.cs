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
    [AbpAuthorize(AppPermissions.Pages_HinhAnhs)]
    public class HinhAnhsAppService : RealEstateAppServiceBase, IHinhAnhsAppService
    {
        private readonly IRepository<HinhAnh> _hinhAnhRepository;
        private readonly IHinhAnhsExcelExporter _hinhAnhsExcelExporter;
        private readonly IRepository<BaiDang, int> _lookup_baiDangRepository;

        public HinhAnhsAppService(IRepository<HinhAnh> hinhAnhRepository, IHinhAnhsExcelExporter hinhAnhsExcelExporter, IRepository<BaiDang, int> lookup_baiDangRepository)
        {
            _hinhAnhRepository = hinhAnhRepository;
            _hinhAnhsExcelExporter = hinhAnhsExcelExporter;
            _lookup_baiDangRepository = lookup_baiDangRepository;

        }

        public async Task<PagedResultDto<GetHinhAnhForViewDto>> GetAll(GetAllHinhAnhsInput input)
        {

            var filteredHinhAnhs = _hinhAnhRepository.GetAll()
                        .Include(e => e.BaiDangFk)
                        .WhereIf(!string.IsNullOrWhiteSpace(input.Filter), e => false || e.DuongDan.Contains(input.Filter))
                        .WhereIf(!string.IsNullOrWhiteSpace(input.DuongDanFilter), e => e.DuongDan == input.DuongDanFilter)
                        .WhereIf(!string.IsNullOrWhiteSpace(input.BaiDangTieuDeFilter), e => e.BaiDangFk != null && e.BaiDangFk.TieuDe == input.BaiDangTieuDeFilter);

            var pagedAndFilteredHinhAnhs = filteredHinhAnhs
                .OrderBy(input.Sorting ?? "id asc")
                .PageBy(input);

            var hinhAnhs = from o in pagedAndFilteredHinhAnhs
                           join o1 in _lookup_baiDangRepository.GetAll() on o.BaiDangId equals o1.Id into j1
                           from s1 in j1.DefaultIfEmpty()

                           select new GetHinhAnhForViewDto()
                           {
                               HinhAnh = new HinhAnhDto
                               {
                                   DuongDan = o.DuongDan,
                                   Id = o.Id,
                                   BaiDangId = o.BaiDangId
                               },
                               BaiDangTieuDe = s1 == null || s1.TieuDe == null ? "" : s1.TieuDe.ToString()
                           };

            var totalCount = await filteredHinhAnhs.CountAsync();

            return new PagedResultDto<GetHinhAnhForViewDto>(
                totalCount,
                await hinhAnhs.ToListAsync()
            );
        }

        public async Task<GetHinhAnhForViewDto> GetHinhAnhForView(int id)
        {
            var hinhAnh = await _hinhAnhRepository.GetAsync(id);

            var output = new GetHinhAnhForViewDto { HinhAnh = ObjectMapper.Map<HinhAnhDto>(hinhAnh) };

            if (output.HinhAnh.BaiDangId != null)
            {
                var _lookupBaiDang = await _lookup_baiDangRepository.FirstOrDefaultAsync((int)output.HinhAnh.BaiDangId);
                output.BaiDangTieuDe = _lookupBaiDang?.TieuDe?.ToString();
            }

            return output;
        }

        public async Task<PagedResultDto<GetHinhAnhForViewDto>> GetAllByPostId(long postId)
        {

            var filteredHinhAnhs = _hinhAnhRepository.GetAll()
                        .Include(e => e.BaiDangFk)
                        .Where(e => e.BaiDangFk != null && e.BaiDangFk.Id == postId);

            var pagedAndFilteredHinhAnhs = filteredHinhAnhs
                .OrderBy("id asc");


            var hinhAnhs = from o in pagedAndFilteredHinhAnhs
                           join o1 in _lookup_baiDangRepository.GetAll() on o.BaiDangId equals o1.Id into j1
                           from s1 in j1.DefaultIfEmpty()

                           select new GetHinhAnhForViewDto()
                           {
                               HinhAnh = new HinhAnhDto
                               {
                                   DuongDan = o.DuongDan,
                                   Id = o.Id,
                                   BaiDangId = o.BaiDangId
                               },
                           };

            var totalCount = await filteredHinhAnhs.CountAsync();

            return new PagedResultDto<GetHinhAnhForViewDto>(
                totalCount,
                await hinhAnhs.ToListAsync()
            );
        }


        [AbpAuthorize(AppPermissions.Pages_HinhAnhs_Edit)]
        public async Task<GetHinhAnhForEditOutput> GetHinhAnhForEdit(EntityDto input)
        {
            var hinhAnh = await _hinhAnhRepository.FirstOrDefaultAsync(input.Id);

            var output = new GetHinhAnhForEditOutput { HinhAnh = ObjectMapper.Map<CreateOrEditHinhAnhDto>(hinhAnh) };

            if (output.HinhAnh.BaiDangId != null)
            {
                var _lookupBaiDang = await _lookup_baiDangRepository.FirstOrDefaultAsync((int)output.HinhAnh.BaiDangId);
                output.BaiDangTieuDe = _lookupBaiDang?.TieuDe?.ToString();
            }

            return output;
        }

        public async Task CreateOrEdit(CreateOrEditHinhAnhDto input)
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

        [AbpAuthorize(AppPermissions.Pages_HinhAnhs_Create)]
        protected virtual async Task Create(CreateOrEditHinhAnhDto input)
        {
            var hinhAnh = ObjectMapper.Map<HinhAnh>(input);

            await _hinhAnhRepository.InsertAsync(hinhAnh);
        }

        [AbpAuthorize(AppPermissions.Pages_HinhAnhs_Edit)]
        protected virtual async Task Update(CreateOrEditHinhAnhDto input)
        {
            var hinhAnh = await _hinhAnhRepository.FirstOrDefaultAsync((int)input.Id);
            ObjectMapper.Map(input, hinhAnh);
        }

        [AbpAuthorize(AppPermissions.Pages_HinhAnhs_Delete)]
        public async Task Delete(EntityDto input)
        {
            await _hinhAnhRepository.DeleteAsync(input.Id);
        }

        public async Task<FileDto> GetHinhAnhsToExcel(GetAllHinhAnhsForExcelInput input)
        {

            var filteredHinhAnhs = _hinhAnhRepository.GetAll()
                        .Include(e => e.BaiDangFk)
                        .WhereIf(!string.IsNullOrWhiteSpace(input.Filter), e => false || e.DuongDan.Contains(input.Filter))
                        .WhereIf(!string.IsNullOrWhiteSpace(input.DuongDanFilter), e => e.DuongDan == input.DuongDanFilter)
                        .WhereIf(!string.IsNullOrWhiteSpace(input.BaiDangTieuDeFilter), e => e.BaiDangFk != null && e.BaiDangFk.TieuDe == input.BaiDangTieuDeFilter);

            var query = (from o in filteredHinhAnhs
                         join o1 in _lookup_baiDangRepository.GetAll() on o.BaiDangId equals o1.Id into j1
                         from s1 in j1.DefaultIfEmpty()

                         select new GetHinhAnhForViewDto()
                         {
                             HinhAnh = new HinhAnhDto
                             {
                                 DuongDan = o.DuongDan,
                                 Id = o.Id
                             },
                             BaiDangTieuDe = s1 == null || s1.TieuDe == null ? "" : s1.TieuDe.ToString()
                         });

            var hinhAnhListDtos = await query.ToListAsync();

            return _hinhAnhsExcelExporter.ExportToFile(hinhAnhListDtos);
        }

        [AbpAuthorize(AppPermissions.Pages_HinhAnhs)]
        public async Task<PagedResultDto<HinhAnhBaiDangLookupTableDto>> GetAllBaiDangForLookupTable(GetAllForLookupTableInput input)
        {
            var query = _lookup_baiDangRepository.GetAll().WhereIf(
                   !string.IsNullOrWhiteSpace(input.Filter),
                  e => e.TieuDe != null && e.TieuDe.Contains(input.Filter)
               );

            var totalCount = await query.CountAsync();

            var baiDangList = await query
                .PageBy(input)
                .ToListAsync();

            var lookupTableDtoList = new List<HinhAnhBaiDangLookupTableDto>();
            foreach (var baiDang in baiDangList)
            {
                lookupTableDtoList.Add(new HinhAnhBaiDangLookupTableDto
                {
                    Id = baiDang.Id,
                    DisplayName = baiDang.TieuDe?.ToString()
                });
            }

            return new PagedResultDto<HinhAnhBaiDangLookupTableDto>(
                totalCount,
                lookupTableDtoList
            );
        }
    }
}