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
    public class HuyensAppService : RealEstateAppServiceBase, IHuyensAppService
    {
        private readonly IRepository<Huyen> _huyenRepository;
        private readonly IHuyensExcelExporter _huyensExcelExporter;
        private readonly IRepository<Tinh, int> _lookup_tinhRepository;

        public HuyensAppService(IRepository<Huyen> huyenRepository, IHuyensExcelExporter huyensExcelExporter, IRepository<Tinh, int> lookup_tinhRepository)
        {
            _huyenRepository = huyenRepository;
            _huyensExcelExporter = huyensExcelExporter;
            _lookup_tinhRepository = lookup_tinhRepository;

        }

        [AbpAllowAnonymous]
        public async Task<PagedResultDto<GetHuyenForViewDto>> GetAll(GetAllHuyensInput input)
        {

            var filteredHuyens = _huyenRepository.GetAll()
                        .Include(e => e.TinhFk)
                        .WhereIf(!string.IsNullOrWhiteSpace(input.Filter), e => false || e.TenHuyen.Contains(input.Filter))
                        .WhereIf(!string.IsNullOrWhiteSpace(input.TenHuyenFilter), e => e.TenHuyen == input.TenHuyenFilter)
                        .WhereIf(!string.IsNullOrWhiteSpace(input.TinhTenTinhFilter), e => e.TinhFk != null && e.TinhFk.TenTinh == input.TinhTenTinhFilter)
                        .WhereIf(input.TinhIdFilter!=null, e => e.TinhId != null && e.TinhId == input.TinhIdFilter);

            var pagedAndFilteredHuyens = filteredHuyens
                .OrderBy(input.Sorting ?? "id asc")
                .PageBy(input);

            var huyens = from o in pagedAndFilteredHuyens
                         join o1 in _lookup_tinhRepository.GetAll() on o.TinhId equals o1.Id into j1
                         from s1 in j1.DefaultIfEmpty()

                         select new GetHuyenForViewDto()
                         {
                             Huyen = new HuyenDto
                             {
                                 TenHuyen = o.TenHuyen,
                                 TinhId = o.TinhId,
                                 Id = o.Id
                             },
                             TinhTenTinh = s1 == null || s1.TenTinh == null ? "" : s1.TenTinh.ToString()
                         };

            var totalCount = await filteredHuyens.CountAsync();

            return new PagedResultDto<GetHuyenForViewDto>(
                totalCount,
                await huyens.ToListAsync()
            );
        }

        [AbpAllowAnonymous]
        public async Task<GetHuyenForViewDto> GetHuyenForView(int id)
        {
            var huyen = await _huyenRepository.GetAsync(id);

            var output = new GetHuyenForViewDto { Huyen = ObjectMapper.Map<HuyenDto>(huyen) };

            if (output.Huyen.TinhId != null)
            {
                var _lookupTinh = await _lookup_tinhRepository.FirstOrDefaultAsync((int)output.Huyen.TinhId);
                output.TinhTenTinh = _lookupTinh?.TenTinh?.ToString();
            }

            return output;
        }

        [AbpAuthorize(AppPermissions.Pages_Huyens_Edit)]
        public async Task<GetHuyenForEditOutput> GetHuyenForEdit(EntityDto input)
        {
            var huyen = await _huyenRepository.FirstOrDefaultAsync(input.Id);

            var output = new GetHuyenForEditOutput { Huyen = ObjectMapper.Map<CreateOrEditHuyenDto>(huyen) };

            if (output.Huyen.TinhId != null)
            {
                var _lookupTinh = await _lookup_tinhRepository.FirstOrDefaultAsync((int)output.Huyen.TinhId);
                output.TinhTenTinh = _lookupTinh?.TenTinh?.ToString();
            }

            return output;
        }

        public async Task CreateOrEdit(CreateOrEditHuyenDto input)
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

        [AbpAuthorize(AppPermissions.Pages_Huyens_Create)]
        protected virtual async Task Create(CreateOrEditHuyenDto input)
        {
            var huyen = ObjectMapper.Map<Huyen>(input);

            await _huyenRepository.InsertAsync(huyen);
        }

        [AbpAuthorize(AppPermissions.Pages_Huyens_Edit)]
        protected virtual async Task Update(CreateOrEditHuyenDto input)
        {
            var huyen = await _huyenRepository.FirstOrDefaultAsync((int)input.Id);
            ObjectMapper.Map(input, huyen);
        }

        [AbpAuthorize(AppPermissions.Pages_Huyens_Delete)]
        public async Task Delete(EntityDto input)
        {
            await _huyenRepository.DeleteAsync(input.Id);
        }

        public async Task<FileDto> GetHuyensToExcel(GetAllHuyensForExcelInput input)
        {

            var filteredHuyens = _huyenRepository.GetAll()
                        .Include(e => e.TinhFk)
                        .WhereIf(!string.IsNullOrWhiteSpace(input.Filter), e => false || e.TenHuyen.Contains(input.Filter))
                        .WhereIf(!string.IsNullOrWhiteSpace(input.TenHuyenFilter), e => e.TenHuyen == input.TenHuyenFilter)
                        .WhereIf(!string.IsNullOrWhiteSpace(input.TinhTenTinhFilter), e => e.TinhFk != null && e.TinhFk.TenTinh == input.TinhTenTinhFilter);

            var query = (from o in filteredHuyens
                         join o1 in _lookup_tinhRepository.GetAll() on o.TinhId equals o1.Id into j1
                         from s1 in j1.DefaultIfEmpty()

                         select new GetHuyenForViewDto()
                         {
                             Huyen = new HuyenDto
                             {
                                 TenHuyen = o.TenHuyen,
                                 Id = o.Id
                             },
                             TinhTenTinh = s1 == null || s1.TenTinh == null ? "" : s1.TenTinh.ToString()
                         });

            var huyenListDtos = await query.ToListAsync();

            return _huyensExcelExporter.ExportToFile(huyenListDtos);
        }

        [AbpAuthorize(AppPermissions.Pages_Huyens)]
        public async Task<PagedResultDto<HuyenTinhLookupTableDto>> GetAllTinhForLookupTable(GetAllForLookupTableInput input)
        {
            var query = _lookup_tinhRepository.GetAll().WhereIf(
                   !string.IsNullOrWhiteSpace(input.Filter),
                  e => e.TenTinh != null && e.TenTinh.Contains(input.Filter)
               );

            var totalCount = await query.CountAsync();

            var tinhList = await query
                .PageBy(input)
                .ToListAsync();

            var lookupTableDtoList = new List<HuyenTinhLookupTableDto>();
            foreach (var tinh in tinhList)
            {
                lookupTableDtoList.Add(new HuyenTinhLookupTableDto
                {
                    Id = tinh.Id,
                    DisplayName = tinh.TenTinh?.ToString()
                });
            }

            return new PagedResultDto<HuyenTinhLookupTableDto>(
                totalCount,
                lookupTableDtoList
            );
        }
    }
}