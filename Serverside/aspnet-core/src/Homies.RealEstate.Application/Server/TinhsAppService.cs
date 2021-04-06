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
    [AbpAuthorize(AppPermissions.Pages_Tinhs)]
    public class TinhsAppService : RealEstateAppServiceBase, ITinhsAppService
    {
        private readonly IRepository<Tinh> _tinhRepository;
        private readonly ITinhsExcelExporter _tinhsExcelExporter;

        public TinhsAppService(IRepository<Tinh> tinhRepository, ITinhsExcelExporter tinhsExcelExporter)
        {
            _tinhRepository = tinhRepository;
            _tinhsExcelExporter = tinhsExcelExporter;

        }

        public async Task<PagedResultDto<GetTinhForViewDto>> GetAll(GetAllTinhsInput input)
        {

            var filteredTinhs = _tinhRepository.GetAll()
                        .WhereIf(!string.IsNullOrWhiteSpace(input.Filter), e => false || e.TenTinh.Contains(input.Filter))
                        .WhereIf(!string.IsNullOrWhiteSpace(input.TenTinhFilter), e => e.TenTinh == input.TenTinhFilter);

            var pagedAndFilteredTinhs = filteredTinhs
                .OrderBy(input.Sorting ?? "id asc")
                .PageBy(input);

            var tinhs = from o in pagedAndFilteredTinhs
                        select new GetTinhForViewDto()
                        {
                            Tinh = new TinhDto
                            {
                                TenTinh = o.TenTinh,
                                Id = o.Id
                            }
                        };

            var totalCount = await filteredTinhs.CountAsync();

            return new PagedResultDto<GetTinhForViewDto>(
                totalCount,
                await tinhs.ToListAsync()
            );
        }

        public async Task<GetTinhForViewDto> GetTinhForView(int id)
        {
            var tinh = await _tinhRepository.GetAsync(id);

            var output = new GetTinhForViewDto { Tinh = ObjectMapper.Map<TinhDto>(tinh) };

            return output;
        }

        [AbpAuthorize(AppPermissions.Pages_Tinhs_Edit)]
        public async Task<GetTinhForEditOutput> GetTinhForEdit(EntityDto input)
        {
            var tinh = await _tinhRepository.FirstOrDefaultAsync(input.Id);

            var output = new GetTinhForEditOutput { Tinh = ObjectMapper.Map<CreateOrEditTinhDto>(tinh) };

            return output;
        }

        public async Task CreateOrEdit(CreateOrEditTinhDto input)
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

        [AbpAuthorize(AppPermissions.Pages_Tinhs_Create)]
        protected virtual async Task Create(CreateOrEditTinhDto input)
        {
            var tinh = ObjectMapper.Map<Tinh>(input);

            await _tinhRepository.InsertAsync(tinh);
        }

        [AbpAuthorize(AppPermissions.Pages_Tinhs_Edit)]
        protected virtual async Task Update(CreateOrEditTinhDto input)
        {
            var tinh = await _tinhRepository.FirstOrDefaultAsync((int)input.Id);
            ObjectMapper.Map(input, tinh);
        }

        [AbpAuthorize(AppPermissions.Pages_Tinhs_Delete)]
        public async Task Delete(EntityDto input)
        {
            await _tinhRepository.DeleteAsync(input.Id);
        }

        public async Task<FileDto> GetTinhsToExcel(GetAllTinhsForExcelInput input)
        {

            var filteredTinhs = _tinhRepository.GetAll()
                        .WhereIf(!string.IsNullOrWhiteSpace(input.Filter), e => false || e.TenTinh.Contains(input.Filter))
                        .WhereIf(!string.IsNullOrWhiteSpace(input.TenTinhFilter), e => e.TenTinh == input.TenTinhFilter);

            var query = (from o in filteredTinhs
                         select new GetTinhForViewDto()
                         {
                             Tinh = new TinhDto
                             {
                                 TenTinh = o.TenTinh,
                                 Id = o.Id
                             }
                         });

            var tinhListDtos = await query.ToListAsync();

            return _tinhsExcelExporter.ExportToFile(tinhListDtos);
        }

    }
}