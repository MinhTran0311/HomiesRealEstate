using Homies.RealEstate.Server;
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
    [AbpAuthorize(AppPermissions.Pages_ChiTietDanhMucs)]
    public class ChiTietDanhMucsAppService : RealEstateAppServiceBase, IChiTietDanhMucsAppService
    {
        private readonly IRepository<ChiTietDanhMuc> _chiTietDanhMucRepository;
        private readonly IChiTietDanhMucsExcelExporter _chiTietDanhMucsExcelExporter;
        private readonly IRepository<ThuocTinh, int> _lookup_thuocTinhRepository;
        private readonly IRepository<DanhMuc, int> _lookup_danhMucRepository;

        public ChiTietDanhMucsAppService(IRepository<ChiTietDanhMuc> chiTietDanhMucRepository, IChiTietDanhMucsExcelExporter chiTietDanhMucsExcelExporter, IRepository<ThuocTinh, int> lookup_thuocTinhRepository, IRepository<DanhMuc, int> lookup_danhMucRepository)
        {
            _chiTietDanhMucRepository = chiTietDanhMucRepository;
            _chiTietDanhMucsExcelExporter = chiTietDanhMucsExcelExporter;
            _lookup_thuocTinhRepository = lookup_thuocTinhRepository;
            _lookup_danhMucRepository = lookup_danhMucRepository;

        }

        public async Task<PagedResultDto<GetChiTietDanhMucForViewDto>> GetAll(GetAllChiTietDanhMucsInput input)
        {

            var filteredChiTietDanhMucs = _chiTietDanhMucRepository.GetAll()
                        .Include(e => e.ThuocTinhFk)
                        .Include(e => e.DanhMucFk)
                        .WhereIf(!string.IsNullOrWhiteSpace(input.Filter), e => false || e.GhiChu.Contains(input.Filter))
                        .WhereIf(!string.IsNullOrWhiteSpace(input.GhiChuFilter), e => e.GhiChu == input.GhiChuFilter)
                        .WhereIf(!string.IsNullOrWhiteSpace(input.ThuocTinhTenThuocTinhFilter), e => e.ThuocTinhFk != null && e.ThuocTinhFk.TenThuocTinh == input.ThuocTinhTenThuocTinhFilter)
                        .WhereIf(!string.IsNullOrWhiteSpace(input.DanhMucTenDanhMucFilter), e => e.DanhMucFk != null && e.DanhMucFk.TenDanhMuc == input.DanhMucTenDanhMucFilter);

            var pagedAndFilteredChiTietDanhMucs = filteredChiTietDanhMucs
                .OrderBy(input.Sorting ?? "id asc")
                .PageBy(input);

            var chiTietDanhMucs = from o in pagedAndFilteredChiTietDanhMucs
                                  join o1 in _lookup_thuocTinhRepository.GetAll() on o.ThuocTinhId equals o1.Id into j1
                                  from s1 in j1.DefaultIfEmpty()

                                  join o2 in _lookup_danhMucRepository.GetAll() on o.DanhMucId equals o2.Id into j2
                                  from s2 in j2.DefaultIfEmpty()

                                  select new GetChiTietDanhMucForViewDto()
                                  {
                                      ChiTietDanhMuc = new ChiTietDanhMucDto
                                      {
                                          GhiChu = o.GhiChu,
                                          Id = o.Id
                                      },
                                      ThuocTinhTenThuocTinh = s1 == null || s1.TenThuocTinh == null ? "" : s1.TenThuocTinh.ToString(),
                                      DanhMucTenDanhMuc = s2 == null || s2.TenDanhMuc == null ? "" : s2.TenDanhMuc.ToString()
                                  };

            var totalCount = await filteredChiTietDanhMucs.CountAsync();

            return new PagedResultDto<GetChiTietDanhMucForViewDto>(
                totalCount,
                await chiTietDanhMucs.ToListAsync()
            );
        }

        public async Task<GetChiTietDanhMucForViewDto> GetChiTietDanhMucForView(int id)
        {
            var chiTietDanhMuc = await _chiTietDanhMucRepository.GetAsync(id);

            var output = new GetChiTietDanhMucForViewDto { ChiTietDanhMuc = ObjectMapper.Map<ChiTietDanhMucDto>(chiTietDanhMuc) };

            if (output.ChiTietDanhMuc.ThuocTinhId != null)
            {
                var _lookupThuocTinh = await _lookup_thuocTinhRepository.FirstOrDefaultAsync((int)output.ChiTietDanhMuc.ThuocTinhId);
                output.ThuocTinhTenThuocTinh = _lookupThuocTinh?.TenThuocTinh?.ToString();
            }

            if (output.ChiTietDanhMuc.DanhMucId != null)
            {
                var _lookupDanhMuc = await _lookup_danhMucRepository.FirstOrDefaultAsync((int)output.ChiTietDanhMuc.DanhMucId);
                output.DanhMucTenDanhMuc = _lookupDanhMuc?.TenDanhMuc?.ToString();
            }

            return output;
        }

        [AbpAuthorize(AppPermissions.Pages_ChiTietDanhMucs_Edit)]
        public async Task<GetChiTietDanhMucForEditOutput> GetChiTietDanhMucForEdit(EntityDto input)
        {
            var chiTietDanhMuc = await _chiTietDanhMucRepository.FirstOrDefaultAsync(input.Id);

            var output = new GetChiTietDanhMucForEditOutput { ChiTietDanhMuc = ObjectMapper.Map<CreateOrEditChiTietDanhMucDto>(chiTietDanhMuc) };

            if (output.ChiTietDanhMuc.ThuocTinhId != null)
            {
                var _lookupThuocTinh = await _lookup_thuocTinhRepository.FirstOrDefaultAsync((int)output.ChiTietDanhMuc.ThuocTinhId);
                output.ThuocTinhTenThuocTinh = _lookupThuocTinh?.TenThuocTinh?.ToString();
            }

            if (output.ChiTietDanhMuc.DanhMucId != null)
            {
                var _lookupDanhMuc = await _lookup_danhMucRepository.FirstOrDefaultAsync((int)output.ChiTietDanhMuc.DanhMucId);
                output.DanhMucTenDanhMuc = _lookupDanhMuc?.TenDanhMuc?.ToString();
            }

            return output;
        }

        public async Task CreateOrEdit(CreateOrEditChiTietDanhMucDto input)
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

        [AbpAuthorize(AppPermissions.Pages_ChiTietDanhMucs_Create)]
        protected virtual async Task Create(CreateOrEditChiTietDanhMucDto input)
        {
            var chiTietDanhMuc = ObjectMapper.Map<ChiTietDanhMuc>(input);

            await _chiTietDanhMucRepository.InsertAsync(chiTietDanhMuc);
        }

        [AbpAuthorize(AppPermissions.Pages_ChiTietDanhMucs_Edit)]
        protected virtual async Task Update(CreateOrEditChiTietDanhMucDto input)
        {
            var chiTietDanhMuc = await _chiTietDanhMucRepository.FirstOrDefaultAsync((int)input.Id);
            ObjectMapper.Map(input, chiTietDanhMuc);
        }

        [AbpAuthorize(AppPermissions.Pages_ChiTietDanhMucs_Delete)]
        public async Task Delete(EntityDto input)
        {
            await _chiTietDanhMucRepository.DeleteAsync(input.Id);
        }

        public async Task<FileDto> GetChiTietDanhMucsToExcel(GetAllChiTietDanhMucsForExcelInput input)
        {

            var filteredChiTietDanhMucs = _chiTietDanhMucRepository.GetAll()
                        .Include(e => e.ThuocTinhFk)
                        .Include(e => e.DanhMucFk)
                        .WhereIf(!string.IsNullOrWhiteSpace(input.Filter), e => false || e.GhiChu.Contains(input.Filter))
                        .WhereIf(!string.IsNullOrWhiteSpace(input.GhiChuFilter), e => e.GhiChu == input.GhiChuFilter)
                        .WhereIf(!string.IsNullOrWhiteSpace(input.ThuocTinhTenThuocTinhFilter), e => e.ThuocTinhFk != null && e.ThuocTinhFk.TenThuocTinh == input.ThuocTinhTenThuocTinhFilter)
                        .WhereIf(!string.IsNullOrWhiteSpace(input.DanhMucTenDanhMucFilter), e => e.DanhMucFk != null && e.DanhMucFk.TenDanhMuc == input.DanhMucTenDanhMucFilter);

            var query = (from o in filteredChiTietDanhMucs
                         join o1 in _lookup_thuocTinhRepository.GetAll() on o.ThuocTinhId equals o1.Id into j1
                         from s1 in j1.DefaultIfEmpty()

                         join o2 in _lookup_danhMucRepository.GetAll() on o.DanhMucId equals o2.Id into j2
                         from s2 in j2.DefaultIfEmpty()

                         select new GetChiTietDanhMucForViewDto()
                         {
                             ChiTietDanhMuc = new ChiTietDanhMucDto
                             {
                                 GhiChu = o.GhiChu,
                                 Id = o.Id
                             },
                             ThuocTinhTenThuocTinh = s1 == null || s1.TenThuocTinh == null ? "" : s1.TenThuocTinh.ToString(),
                             DanhMucTenDanhMuc = s2 == null || s2.TenDanhMuc == null ? "" : s2.TenDanhMuc.ToString()
                         });

            var chiTietDanhMucListDtos = await query.ToListAsync();

            return _chiTietDanhMucsExcelExporter.ExportToFile(chiTietDanhMucListDtos);
        }

        [AbpAuthorize(AppPermissions.Pages_ChiTietDanhMucs)]
        public async Task<PagedResultDto<ChiTietDanhMucThuocTinhLookupTableDto>> GetAllThuocTinhForLookupTable(GetAllForLookupTableInput input)
        {
            var query = _lookup_thuocTinhRepository.GetAll().WhereIf(
                   !string.IsNullOrWhiteSpace(input.Filter),
                  e => e.TenThuocTinh != null && e.TenThuocTinh.Contains(input.Filter)
               );

            var totalCount = await query.CountAsync();

            var thuocTinhList = await query
                .PageBy(input)
                .ToListAsync();

            var lookupTableDtoList = new List<ChiTietDanhMucThuocTinhLookupTableDto>();
            foreach (var thuocTinh in thuocTinhList)
            {
                lookupTableDtoList.Add(new ChiTietDanhMucThuocTinhLookupTableDto
                {
                    Id = thuocTinh.Id,
                    DisplayName = thuocTinh.TenThuocTinh?.ToString()
                });
            }

            return new PagedResultDto<ChiTietDanhMucThuocTinhLookupTableDto>(
                totalCount,
                lookupTableDtoList
            );
        }

        [AbpAuthorize(AppPermissions.Pages_ChiTietDanhMucs)]
        public async Task<PagedResultDto<ChiTietDanhMucDanhMucLookupTableDto>> GetAllDanhMucForLookupTable(GetAllForLookupTableInput input)
        {
            var query = _lookup_danhMucRepository.GetAll().WhereIf(
                   !string.IsNullOrWhiteSpace(input.Filter),
                  e => e.TenDanhMuc != null && e.TenDanhMuc.Contains(input.Filter)
               );

            var totalCount = await query.CountAsync();

            var danhMucList = await query
                .PageBy(input)
                .ToListAsync();

            var lookupTableDtoList = new List<ChiTietDanhMucDanhMucLookupTableDto>();
            foreach (var danhMuc in danhMucList)
            {
                lookupTableDtoList.Add(new ChiTietDanhMucDanhMucLookupTableDto
                {
                    Id = danhMuc.Id,
                    DisplayName = danhMuc.TenDanhMuc?.ToString()
                });
            }

            return new PagedResultDto<ChiTietDanhMucDanhMucLookupTableDto>(
                totalCount,
                lookupTableDtoList
            );
        }
    }
}