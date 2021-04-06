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
    [AbpAuthorize(AppPermissions.Pages_DanhMucs)]
    public class DanhMucsAppService : RealEstateAppServiceBase, IDanhMucsAppService
    {
        private readonly IRepository<DanhMuc> _danhMucRepository;
        private readonly IDanhMucsExcelExporter _danhMucsExcelExporter;

        public DanhMucsAppService(IRepository<DanhMuc> danhMucRepository, IDanhMucsExcelExporter danhMucsExcelExporter)
        {
            _danhMucRepository = danhMucRepository;
            _danhMucsExcelExporter = danhMucsExcelExporter;

        }

        public async Task<PagedResultDto<GetDanhMucForViewDto>> GetAll(GetAllDanhMucsInput input)
        {

            var filteredDanhMucs = _danhMucRepository.GetAll()
                        .WhereIf(!string.IsNullOrWhiteSpace(input.Filter), e => false || e.TenDanhMuc.Contains(input.Filter) || e.Tag.Contains(input.Filter) || e.TrangThai.Contains(input.Filter))
                        .WhereIf(!string.IsNullOrWhiteSpace(input.TenDanhMucFilter), e => e.TenDanhMuc == input.TenDanhMucFilter)
                        .WhereIf(!string.IsNullOrWhiteSpace(input.TagFilter), e => e.Tag == input.TagFilter)
                        .WhereIf(!string.IsNullOrWhiteSpace(input.TrangThaiFilter), e => e.TrangThai == input.TrangThaiFilter)
                        .WhereIf(input.MinDanhMucChaFilter != null, e => e.DanhMucCha >= input.MinDanhMucChaFilter)
                        .WhereIf(input.MaxDanhMucChaFilter != null, e => e.DanhMucCha <= input.MaxDanhMucChaFilter);

            var pagedAndFilteredDanhMucs = filteredDanhMucs
                .OrderBy(input.Sorting ?? "id asc")
                .PageBy(input);

            var danhMucs = from o in pagedAndFilteredDanhMucs
                           select new GetDanhMucForViewDto()
                           {
                               DanhMuc = new DanhMucDto
                               {
                                   TenDanhMuc = o.TenDanhMuc,
                                   Tag = o.Tag,
                                   TrangThai = o.TrangThai,
                                   DanhMucCha = o.DanhMucCha,
                                   Id = o.Id
                               }
                           };

            var totalCount = await filteredDanhMucs.CountAsync();

            return new PagedResultDto<GetDanhMucForViewDto>(
                totalCount,
                await danhMucs.ToListAsync()
            );
        }

        public async Task<GetDanhMucForViewDto> GetDanhMucForView(int id)
        {
            var danhMuc = await _danhMucRepository.GetAsync(id);

            var output = new GetDanhMucForViewDto { DanhMuc = ObjectMapper.Map<DanhMucDto>(danhMuc) };

            return output;
        }

        [AbpAuthorize(AppPermissions.Pages_DanhMucs_Edit)]
        public async Task<GetDanhMucForEditOutput> GetDanhMucForEdit(EntityDto input)
        {
            var danhMuc = await _danhMucRepository.FirstOrDefaultAsync(input.Id);

            var output = new GetDanhMucForEditOutput { DanhMuc = ObjectMapper.Map<CreateOrEditDanhMucDto>(danhMuc) };

            return output;
        }

        public async Task CreateOrEdit(CreateOrEditDanhMucDto input)
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

        [AbpAuthorize(AppPermissions.Pages_DanhMucs_Create)]
        protected virtual async Task Create(CreateOrEditDanhMucDto input)
        {
            var danhMuc = ObjectMapper.Map<DanhMuc>(input);

            await _danhMucRepository.InsertAsync(danhMuc);
        }

        [AbpAuthorize(AppPermissions.Pages_DanhMucs_Edit)]
        protected virtual async Task Update(CreateOrEditDanhMucDto input)
        {
            var danhMuc = await _danhMucRepository.FirstOrDefaultAsync((int)input.Id);
            ObjectMapper.Map(input, danhMuc);
        }

        [AbpAuthorize(AppPermissions.Pages_DanhMucs_Delete)]
        public async Task Delete(EntityDto input)
        {
            await _danhMucRepository.DeleteAsync(input.Id);
        }

        public async Task<FileDto> GetDanhMucsToExcel(GetAllDanhMucsForExcelInput input)
        {

            var filteredDanhMucs = _danhMucRepository.GetAll()
                        .WhereIf(!string.IsNullOrWhiteSpace(input.Filter), e => false || e.TenDanhMuc.Contains(input.Filter) || e.Tag.Contains(input.Filter) || e.TrangThai.Contains(input.Filter))
                        .WhereIf(!string.IsNullOrWhiteSpace(input.TenDanhMucFilter), e => e.TenDanhMuc == input.TenDanhMucFilter)
                        .WhereIf(!string.IsNullOrWhiteSpace(input.TagFilter), e => e.Tag == input.TagFilter)
                        .WhereIf(!string.IsNullOrWhiteSpace(input.TrangThaiFilter), e => e.TrangThai == input.TrangThaiFilter)
                        .WhereIf(input.MinDanhMucChaFilter != null, e => e.DanhMucCha >= input.MinDanhMucChaFilter)
                        .WhereIf(input.MaxDanhMucChaFilter != null, e => e.DanhMucCha <= input.MaxDanhMucChaFilter);

            var query = (from o in filteredDanhMucs
                         select new GetDanhMucForViewDto()
                         {
                             DanhMuc = new DanhMucDto
                             {
                                 TenDanhMuc = o.TenDanhMuc,
                                 Tag = o.Tag,
                                 TrangThai = o.TrangThai,
                                 DanhMucCha = o.DanhMucCha,
                                 Id = o.Id
                             }
                         });

            var danhMucListDtos = await query.ToListAsync();

            return _danhMucsExcelExporter.ExportToFile(danhMucListDtos);
        }

    }
}