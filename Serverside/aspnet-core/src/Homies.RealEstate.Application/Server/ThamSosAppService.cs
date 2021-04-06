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
    [AbpAuthorize(AppPermissions.Pages_ThamSos)]
    public class ThamSosAppService : RealEstateAppServiceBase, IThamSosAppService
    {
        private readonly IRepository<ThamSo> _thamSoRepository;
        private readonly IThamSosExcelExporter _thamSosExcelExporter;

        public ThamSosAppService(IRepository<ThamSo> thamSoRepository, IThamSosExcelExporter thamSosExcelExporter)
        {
            _thamSoRepository = thamSoRepository;
            _thamSosExcelExporter = thamSosExcelExporter;

        }

        public async Task<PagedResultDto<GetThamSoForViewDto>> GetAll(GetAllThamSosInput input)
        {

            var filteredThamSos = _thamSoRepository.GetAll()
                        .WhereIf(!string.IsNullOrWhiteSpace(input.Filter), e => false || e.TenThamSo.Contains(input.Filter) || e.KieuDuLieu.Contains(input.Filter) || e.GiaTri.Contains(input.Filter))
                        .WhereIf(!string.IsNullOrWhiteSpace(input.TenThamSoFilter), e => e.TenThamSo == input.TenThamSoFilter)
                        .WhereIf(!string.IsNullOrWhiteSpace(input.KieuDuLieuFilter), e => e.KieuDuLieu == input.KieuDuLieuFilter)
                        .WhereIf(!string.IsNullOrWhiteSpace(input.GiaTriFilter), e => e.GiaTri == input.GiaTriFilter);

            var pagedAndFilteredThamSos = filteredThamSos
                .OrderBy(input.Sorting ?? "id asc")
                .PageBy(input);

            var thamSos = from o in pagedAndFilteredThamSos
                          select new GetThamSoForViewDto()
                          {
                              ThamSo = new ThamSoDto
                              {
                                  TenThamSo = o.TenThamSo,
                                  KieuDuLieu = o.KieuDuLieu,
                                  GiaTri = o.GiaTri,
                                  Id = o.Id
                              }
                          };

            var totalCount = await filteredThamSos.CountAsync();

            return new PagedResultDto<GetThamSoForViewDto>(
                totalCount,
                await thamSos.ToListAsync()
            );
        }

        public async Task<GetThamSoForViewDto> GetThamSoForView(int id)
        {
            var thamSo = await _thamSoRepository.GetAsync(id);

            var output = new GetThamSoForViewDto { ThamSo = ObjectMapper.Map<ThamSoDto>(thamSo) };

            return output;
        }

        [AbpAuthorize(AppPermissions.Pages_ThamSos_Edit)]
        public async Task<GetThamSoForEditOutput> GetThamSoForEdit(EntityDto input)
        {
            var thamSo = await _thamSoRepository.FirstOrDefaultAsync(input.Id);

            var output = new GetThamSoForEditOutput { ThamSo = ObjectMapper.Map<CreateOrEditThamSoDto>(thamSo) };

            return output;
        }

        public async Task CreateOrEdit(CreateOrEditThamSoDto input)
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

        [AbpAuthorize(AppPermissions.Pages_ThamSos_Create)]
        protected virtual async Task Create(CreateOrEditThamSoDto input)
        {
            var thamSo = ObjectMapper.Map<ThamSo>(input);

            await _thamSoRepository.InsertAsync(thamSo);
        }

        [AbpAuthorize(AppPermissions.Pages_ThamSos_Edit)]
        protected virtual async Task Update(CreateOrEditThamSoDto input)
        {
            var thamSo = await _thamSoRepository.FirstOrDefaultAsync((int)input.Id);
            ObjectMapper.Map(input, thamSo);
        }

        [AbpAuthorize(AppPermissions.Pages_ThamSos_Delete)]
        public async Task Delete(EntityDto input)
        {
            await _thamSoRepository.DeleteAsync(input.Id);
        }

        public async Task<FileDto> GetThamSosToExcel(GetAllThamSosForExcelInput input)
        {

            var filteredThamSos = _thamSoRepository.GetAll()
                        .WhereIf(!string.IsNullOrWhiteSpace(input.Filter), e => false || e.TenThamSo.Contains(input.Filter) || e.KieuDuLieu.Contains(input.Filter) || e.GiaTri.Contains(input.Filter))
                        .WhereIf(!string.IsNullOrWhiteSpace(input.TenThamSoFilter), e => e.TenThamSo == input.TenThamSoFilter)
                        .WhereIf(!string.IsNullOrWhiteSpace(input.KieuDuLieuFilter), e => e.KieuDuLieu == input.KieuDuLieuFilter)
                        .WhereIf(!string.IsNullOrWhiteSpace(input.GiaTriFilter), e => e.GiaTri == input.GiaTriFilter);

            var query = (from o in filteredThamSos
                         select new GetThamSoForViewDto()
                         {
                             ThamSo = new ThamSoDto
                             {
                                 TenThamSo = o.TenThamSo,
                                 KieuDuLieu = o.KieuDuLieu,
                                 GiaTri = o.GiaTri,
                                 Id = o.Id
                             }
                         });

            var thamSoListDtos = await query.ToListAsync();

            return _thamSosExcelExporter.ExportToFile(thamSoListDtos);
        }

    }
}