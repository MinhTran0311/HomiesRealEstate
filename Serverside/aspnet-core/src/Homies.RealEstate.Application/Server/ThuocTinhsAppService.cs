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
    [AbpAuthorize(AppPermissions.Pages_ThuocTinhs)]
    public class ThuocTinhsAppService : RealEstateAppServiceBase, IThuocTinhsAppService
    {
        private readonly IRepository<ThuocTinh> _thuocTinhRepository;
        private readonly IThuocTinhsExcelExporter _thuocTinhsExcelExporter;

        public ThuocTinhsAppService(IRepository<ThuocTinh> thuocTinhRepository, IThuocTinhsExcelExporter thuocTinhsExcelExporter)
        {
            _thuocTinhRepository = thuocTinhRepository;
            _thuocTinhsExcelExporter = thuocTinhsExcelExporter;

        }

        public async Task<PagedResultDto<GetThuocTinhForViewDto>> GetAll(GetAllThuocTinhsInput input)
        {

            var filteredThuocTinhs = _thuocTinhRepository.GetAll()
                        .WhereIf(!string.IsNullOrWhiteSpace(input.Filter), e => false || e.TenThuocTinh.Contains(input.Filter) || e.KieuDuLieu.Contains(input.Filter) || e.TrangThai.Contains(input.Filter))
                        .WhereIf(!string.IsNullOrWhiteSpace(input.TenThuocTinhFilter), e => e.TenThuocTinh == input.TenThuocTinhFilter)
                        .WhereIf(!string.IsNullOrWhiteSpace(input.KieuDuLieuFilter), e => e.KieuDuLieu == input.KieuDuLieuFilter)
                        .WhereIf(!string.IsNullOrWhiteSpace(input.TrangThaiFilter), e => e.TrangThai == input.TrangThaiFilter);

            var pagedAndFilteredThuocTinhs = filteredThuocTinhs
                .OrderBy(input.Sorting ?? "id asc")
                .PageBy(input);

            var thuocTinhs = from o in pagedAndFilteredThuocTinhs
                             select new GetThuocTinhForViewDto()
                             {
                                 ThuocTinh = new ThuocTinhDto
                                 {
                                     TenThuocTinh = o.TenThuocTinh,
                                     KieuDuLieu = o.KieuDuLieu,
                                     TrangThai = o.TrangThai,
                                     Id = o.Id
                                 }
                             };

            var totalCount = await filteredThuocTinhs.CountAsync();

            return new PagedResultDto<GetThuocTinhForViewDto>(
                totalCount,
                await thuocTinhs.ToListAsync()
            );
        }

        public async Task<GetThuocTinhForViewDto> GetThuocTinhForView(int id)
        {
            var thuocTinh = await _thuocTinhRepository.GetAsync(id);

            var output = new GetThuocTinhForViewDto { ThuocTinh = ObjectMapper.Map<ThuocTinhDto>(thuocTinh) };

            return output;
        }

        [AbpAuthorize(AppPermissions.Pages_ThuocTinhs_Edit)]
        public async Task<GetThuocTinhForEditOutput> GetThuocTinhForEdit(EntityDto input)
        {
            var thuocTinh = await _thuocTinhRepository.FirstOrDefaultAsync(input.Id);

            var output = new GetThuocTinhForEditOutput { ThuocTinh = ObjectMapper.Map<CreateOrEditThuocTinhDto>(thuocTinh) };

            return output;
        }

        public async Task CreateOrEdit(CreateOrEditThuocTinhDto input)
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

        [AbpAuthorize(AppPermissions.Pages_ThuocTinhs_Create)]
        protected virtual async Task Create(CreateOrEditThuocTinhDto input)
        {
            var thuocTinh = ObjectMapper.Map<ThuocTinh>(input);

            await _thuocTinhRepository.InsertAsync(thuocTinh);
        }

        [AbpAuthorize(AppPermissions.Pages_ThuocTinhs_Edit)]
        protected virtual async Task Update(CreateOrEditThuocTinhDto input)
        {
            var thuocTinh = await _thuocTinhRepository.FirstOrDefaultAsync((int)input.Id);
            ObjectMapper.Map(input, thuocTinh);
        }

        [AbpAuthorize(AppPermissions.Pages_ThuocTinhs_Delete)]
        public async Task Delete(EntityDto input)
        {
            await _thuocTinhRepository.DeleteAsync(input.Id);
        }

        public async Task<FileDto> GetThuocTinhsToExcel(GetAllThuocTinhsForExcelInput input)
        {

            var filteredThuocTinhs = _thuocTinhRepository.GetAll()
                        .WhereIf(!string.IsNullOrWhiteSpace(input.Filter), e => false || e.TenThuocTinh.Contains(input.Filter) || e.KieuDuLieu.Contains(input.Filter) || e.TrangThai.Contains(input.Filter))
                        .WhereIf(!string.IsNullOrWhiteSpace(input.TenThuocTinhFilter), e => e.TenThuocTinh == input.TenThuocTinhFilter)
                        .WhereIf(!string.IsNullOrWhiteSpace(input.KieuDuLieuFilter), e => e.KieuDuLieu == input.KieuDuLieuFilter)
                        .WhereIf(!string.IsNullOrWhiteSpace(input.TrangThaiFilter), e => e.TrangThai == input.TrangThaiFilter);

            var query = (from o in filteredThuocTinhs
                         select new GetThuocTinhForViewDto()
                         {
                             ThuocTinh = new ThuocTinhDto
                             {
                                 TenThuocTinh = o.TenThuocTinh,
                                 KieuDuLieu = o.KieuDuLieu,
                                 TrangThai = o.TrangThai,
                                 Id = o.Id
                             }
                         });

            var thuocTinhListDtos = await query.ToListAsync();

            return _thuocTinhsExcelExporter.ExportToFile(thuocTinhListDtos);
        }

    }
}