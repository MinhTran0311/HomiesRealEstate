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
    [AbpAuthorize(AppPermissions.Pages_GoiBaiDangs)]
    public class GoiBaiDangsAppService : RealEstateAppServiceBase, IGoiBaiDangsAppService
    {
        private readonly IRepository<GoiBaiDang> _goiBaiDangRepository;
        private readonly IGoiBaiDangsExcelExporter _goiBaiDangsExcelExporter;

        public GoiBaiDangsAppService(IRepository<GoiBaiDang> goiBaiDangRepository, IGoiBaiDangsExcelExporter goiBaiDangsExcelExporter)
        {
            _goiBaiDangRepository = goiBaiDangRepository;
            _goiBaiDangsExcelExporter = goiBaiDangsExcelExporter;

        }

        public async Task<PagedResultDto<GetGoiBaiDangForViewDto>> GetAll(GetAllGoiBaiDangsInput input)
        {

            var filteredGoiBaiDangs = _goiBaiDangRepository.GetAll()
                        .WhereIf(!string.IsNullOrWhiteSpace(input.Filter), e => false || e.TenGoi.Contains(input.Filter) || e.MoTa.Contains(input.Filter) || e.TrangThai.Contains(input.Filter))
                        .WhereIf(!string.IsNullOrWhiteSpace(input.TenGoiFilter), e => e.TenGoi == input.TenGoiFilter)
                        .WhereIf(input.MinPhiFilter != null, e => e.Phi >= input.MinPhiFilter)
                        .WhereIf(input.MaxPhiFilter != null, e => e.Phi <= input.MaxPhiFilter)
                        .WhereIf(input.MinDoUuTienFilter != null, e => e.DoUuTien >= input.MinDoUuTienFilter)
                        .WhereIf(input.MaxDoUuTienFilter != null, e => e.DoUuTien <= input.MaxDoUuTienFilter)
                        .WhereIf(input.MinThoiGianToiThieuFilter != null, e => e.ThoiGianToiThieu >= input.MinThoiGianToiThieuFilter)
                        .WhereIf(input.MaxThoiGianToiThieuFilter != null, e => e.ThoiGianToiThieu <= input.MaxThoiGianToiThieuFilter)
                        .WhereIf(!string.IsNullOrWhiteSpace(input.MoTaFilter), e => e.MoTa == input.MoTaFilter)
                        .WhereIf(!string.IsNullOrWhiteSpace(input.TrangThaiFilter), e => e.TrangThai == input.TrangThaiFilter);

            var pagedAndFilteredGoiBaiDangs = filteredGoiBaiDangs
                .OrderBy(input.Sorting ?? "id asc")
                .PageBy(input);

            var goiBaiDangs = from o in pagedAndFilteredGoiBaiDangs
                              select new GetGoiBaiDangForViewDto()
                              {
                                  GoiBaiDang = new GoiBaiDangDto
                                  {
                                      TenGoi = o.TenGoi,
                                      Phi = o.Phi,
                                      DoUuTien = o.DoUuTien,
                                      ThoiGianToiThieu = o.ThoiGianToiThieu,
                                      MoTa = o.MoTa,
                                      TrangThai = o.TrangThai,
                                      Id = o.Id
                                  }
                              };

            var totalCount = await filteredGoiBaiDangs.CountAsync();

            return new PagedResultDto<GetGoiBaiDangForViewDto>(
                totalCount,
                await goiBaiDangs.ToListAsync()
            );
        }

        public async Task<GetGoiBaiDangForViewDto> GetGoiBaiDangForView(int id)
        {
            var goiBaiDang = await _goiBaiDangRepository.GetAsync(id);

            var output = new GetGoiBaiDangForViewDto { GoiBaiDang = ObjectMapper.Map<GoiBaiDangDto>(goiBaiDang) };

            return output;
        }

        [AbpAuthorize(AppPermissions.Pages_GoiBaiDangs_Edit)]
        public async Task<GetGoiBaiDangForEditOutput> GetGoiBaiDangForEdit(EntityDto input)
        {
            var goiBaiDang = await _goiBaiDangRepository.FirstOrDefaultAsync(input.Id);

            var output = new GetGoiBaiDangForEditOutput { GoiBaiDang = ObjectMapper.Map<CreateOrEditGoiBaiDangDto>(goiBaiDang) };

            return output;
        }

        public async Task CreateOrEdit(CreateOrEditGoiBaiDangDto input)
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

        [AbpAuthorize(AppPermissions.Pages_GoiBaiDangs_Create)]
        protected virtual async Task Create(CreateOrEditGoiBaiDangDto input)
        {
            var goiBaiDang = ObjectMapper.Map<GoiBaiDang>(input);

            await _goiBaiDangRepository.InsertAsync(goiBaiDang);
        }

        [AbpAuthorize(AppPermissions.Pages_GoiBaiDangs_Edit)]
        protected virtual async Task Update(CreateOrEditGoiBaiDangDto input)
        {
            var goiBaiDang = await _goiBaiDangRepository.FirstOrDefaultAsync((int)input.Id);
            ObjectMapper.Map(input, goiBaiDang);
        }

        [AbpAuthorize(AppPermissions.Pages_GoiBaiDangs_Delete)]
        public async Task Delete(EntityDto input)
        {
            await _goiBaiDangRepository.DeleteAsync(input.Id);
        }

        public async Task<FileDto> GetGoiBaiDangsToExcel(GetAllGoiBaiDangsForExcelInput input)
        {

            var filteredGoiBaiDangs = _goiBaiDangRepository.GetAll()
                        .WhereIf(!string.IsNullOrWhiteSpace(input.Filter), e => false || e.TenGoi.Contains(input.Filter) || e.MoTa.Contains(input.Filter) || e.TrangThai.Contains(input.Filter))
                        .WhereIf(!string.IsNullOrWhiteSpace(input.TenGoiFilter), e => e.TenGoi == input.TenGoiFilter)
                        .WhereIf(input.MinPhiFilter != null, e => e.Phi >= input.MinPhiFilter)
                        .WhereIf(input.MaxPhiFilter != null, e => e.Phi <= input.MaxPhiFilter)
                        .WhereIf(input.MinDoUuTienFilter != null, e => e.DoUuTien >= input.MinDoUuTienFilter)
                        .WhereIf(input.MaxDoUuTienFilter != null, e => e.DoUuTien <= input.MaxDoUuTienFilter)
                        .WhereIf(input.MinThoiGianToiThieuFilter != null, e => e.ThoiGianToiThieu >= input.MinThoiGianToiThieuFilter)
                        .WhereIf(input.MaxThoiGianToiThieuFilter != null, e => e.ThoiGianToiThieu <= input.MaxThoiGianToiThieuFilter)
                        .WhereIf(!string.IsNullOrWhiteSpace(input.MoTaFilter), e => e.MoTa == input.MoTaFilter)
                        .WhereIf(!string.IsNullOrWhiteSpace(input.TrangThaiFilter), e => e.TrangThai == input.TrangThaiFilter);

            var query = (from o in filteredGoiBaiDangs
                         select new GetGoiBaiDangForViewDto()
                         {
                             GoiBaiDang = new GoiBaiDangDto
                             {
                                 TenGoi = o.TenGoi,
                                 Phi = o.Phi,
                                 DoUuTien = o.DoUuTien,
                                 ThoiGianToiThieu = o.ThoiGianToiThieu,
                                 MoTa = o.MoTa,
                                 TrangThai = o.TrangThai,
                                 Id = o.Id
                             }
                         });

            var goiBaiDangListDtos = await query.ToListAsync();

            return _goiBaiDangsExcelExporter.ExportToFile(goiBaiDangListDtos);
        }

    }
}