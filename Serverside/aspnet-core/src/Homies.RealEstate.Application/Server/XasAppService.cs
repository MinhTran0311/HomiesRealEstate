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
    [AbpAuthorize(AppPermissions.Pages_Xas)]
    public class XasAppService : RealEstateAppServiceBase, IXasAppService
    {
        private readonly IRepository<Xa> _xaRepository;
        private readonly IXasExcelExporter _xasExcelExporter;
        private readonly IRepository<Huyen, int> _lookup_huyenRepository;

        public XasAppService(IRepository<Xa> xaRepository, IXasExcelExporter xasExcelExporter, IRepository<Huyen, int> lookup_huyenRepository)
        {
            _xaRepository = xaRepository;
            _xasExcelExporter = xasExcelExporter;
            _lookup_huyenRepository = lookup_huyenRepository;

        }

        public async Task<PagedResultDto<GetXaForViewDto>> GetAll(GetAllXasInput input)
        {

            var filteredXas = _xaRepository.GetAll()
                        .Include(e => e.HuyenFk)
                        .WhereIf(!string.IsNullOrWhiteSpace(input.Filter), e => false || e.TenXa.Contains(input.Filter))
                        .WhereIf(!string.IsNullOrWhiteSpace(input.TenXaFilter), e => e.TenXa == input.TenXaFilter)
                        .WhereIf(!string.IsNullOrWhiteSpace(input.HuyenTenHuyenFilter), e => e.HuyenFk != null && e.HuyenFk.TenHuyen == input.HuyenTenHuyenFilter)
                        .WhereIf(input.HuyenIdFilter != null, e => e.HuyenId != null && e.HuyenId == input.HuyenIdFilter);


            var pagedAndFilteredXas = filteredXas
                .OrderBy(input.Sorting ?? "id asc")
                .PageBy(input);

            var xas = from o in pagedAndFilteredXas
                      join o1 in _lookup_huyenRepository.GetAll() on o.HuyenId equals o1.Id into j1
                      from s1 in j1.DefaultIfEmpty()

                      select new GetXaForViewDto()
                      {
                          Xa = new XaDto
                          {
                              TenXa = o.TenXa,
                              HuyenId = o.HuyenId,
                              Id = o.Id
                          },
                          HuyenTenHuyen = s1 == null || s1.TenHuyen == null ? "" : s1.TenHuyen.ToString()
                      };

            var totalCount = await filteredXas.CountAsync();

            return new PagedResultDto<GetXaForViewDto>(
                totalCount,
                await xas.ToListAsync()
            );
        }

        public async Task<GetXaForViewDto> GetXaForView(int id)
        {
            var xa = await _xaRepository.GetAsync(id);

            var output = new GetXaForViewDto { Xa = ObjectMapper.Map<XaDto>(xa) };

            if (output.Xa.HuyenId != null)
            {
                var _lookupHuyen = await _lookup_huyenRepository.FirstOrDefaultAsync((int)output.Xa.HuyenId);
                output.HuyenTenHuyen = _lookupHuyen?.TenHuyen?.ToString();
            }

            return output;
        }

        [AbpAuthorize(AppPermissions.Pages_Xas_Edit)]
        public async Task<GetXaForEditOutput> GetXaForEdit(EntityDto input)
        {
            var xa = await _xaRepository.FirstOrDefaultAsync(input.Id);

            var output = new GetXaForEditOutput { Xa = ObjectMapper.Map<CreateOrEditXaDto>(xa) };

            if (output.Xa.HuyenId != null)
            {
                var _lookupHuyen = await _lookup_huyenRepository.FirstOrDefaultAsync((int)output.Xa.HuyenId);
                output.HuyenTenHuyen = _lookupHuyen?.TenHuyen?.ToString();
            }

            return output;
        }

        public async Task CreateOrEdit(CreateOrEditXaDto input)
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

        [AbpAuthorize(AppPermissions.Pages_Xas_Create)]
        protected virtual async Task Create(CreateOrEditXaDto input)
        {
            var xa = ObjectMapper.Map<Xa>(input);

            await _xaRepository.InsertAsync(xa);
        }

        [AbpAuthorize(AppPermissions.Pages_Xas_Edit)]
        protected virtual async Task Update(CreateOrEditXaDto input)
        {
            var xa = await _xaRepository.FirstOrDefaultAsync((int)input.Id);
            ObjectMapper.Map(input, xa);
        }

        [AbpAuthorize(AppPermissions.Pages_Xas_Delete)]
        public async Task Delete(EntityDto input)
        {
            await _xaRepository.DeleteAsync(input.Id);
        }

        public async Task<FileDto> GetXasToExcel(GetAllXasForExcelInput input)
        {

            var filteredXas = _xaRepository.GetAll()
                        .Include(e => e.HuyenFk)
                        .WhereIf(!string.IsNullOrWhiteSpace(input.Filter), e => false || e.TenXa.Contains(input.Filter))
                        .WhereIf(!string.IsNullOrWhiteSpace(input.TenXaFilter), e => e.TenXa == input.TenXaFilter)
                        .WhereIf(!string.IsNullOrWhiteSpace(input.HuyenTenHuyenFilter), e => e.HuyenFk != null && e.HuyenFk.TenHuyen == input.HuyenTenHuyenFilter);

            var query = (from o in filteredXas
                         join o1 in _lookup_huyenRepository.GetAll() on o.HuyenId equals o1.Id into j1
                         from s1 in j1.DefaultIfEmpty()

                         select new GetXaForViewDto()
                         {
                             Xa = new XaDto
                             {
                                 TenXa = o.TenXa,
                                 Id = o.Id
                             },
                             HuyenTenHuyen = s1 == null || s1.TenHuyen == null ? "" : s1.TenHuyen.ToString()
                         });

            var xaListDtos = await query.ToListAsync();

            return _xasExcelExporter.ExportToFile(xaListDtos);
        }

        [AbpAuthorize(AppPermissions.Pages_Xas)]
        public async Task<PagedResultDto<XaHuyenLookupTableDto>> GetAllHuyenForLookupTable(GetAllForLookupTableInput input)
        {
            var query = _lookup_huyenRepository.GetAll().WhereIf(
                   !string.IsNullOrWhiteSpace(input.Filter),
                  e => e.TenHuyen != null && e.TenHuyen.Contains(input.Filter)
               );

            var totalCount = await query.CountAsync();

            var huyenList = await query
                .PageBy(input)
                .ToListAsync();

            var lookupTableDtoList = new List<XaHuyenLookupTableDto>();
            foreach (var huyen in huyenList)
            {
                lookupTableDtoList.Add(new XaHuyenLookupTableDto
                {
                    Id = huyen.Id,
                    DisplayName = huyen.TenHuyen?.ToString()
                });
            }

            return new PagedResultDto<XaHuyenLookupTableDto>(
                totalCount,
                lookupTableDtoList
            );
        }
    }
}