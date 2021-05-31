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
    [AbpAllowAnonymous]
    public class ChiTietBaiDangsAppService : RealEstateAppServiceBase, IChiTietBaiDangsAppService
    {
        private readonly IRepository<ChiTietBaiDang> _chiTietBaiDangRepository;
        private readonly IChiTietBaiDangsExcelExporter _chiTietBaiDangsExcelExporter;
        private readonly IRepository<ThuocTinh, int> _lookup_thuocTinhRepository;
        private readonly IRepository<BaiDang, int> _lookup_baiDangRepository;

        public ChiTietBaiDangsAppService(IRepository<ChiTietBaiDang> chiTietBaiDangRepository, IChiTietBaiDangsExcelExporter chiTietBaiDangsExcelExporter, IRepository<ThuocTinh, int> lookup_thuocTinhRepository, IRepository<BaiDang, int> lookup_baiDangRepository)
        {
            _chiTietBaiDangRepository = chiTietBaiDangRepository;
            _chiTietBaiDangsExcelExporter = chiTietBaiDangsExcelExporter;
            _lookup_thuocTinhRepository = lookup_thuocTinhRepository;
            _lookup_baiDangRepository = lookup_baiDangRepository;

        }

        public async Task<PagedResultDto<GetChiTietBaiDangForViewDto>> GetAll(GetAllChiTietBaiDangsInput input)
        {

            var filteredChiTietBaiDangs = _chiTietBaiDangRepository.GetAll()
                        .Include(e => e.ThuocTinhFk)
                        .Include(e => e.BaiDangFk)
                        .WhereIf(!string.IsNullOrWhiteSpace(input.Filter), e => false || e.GiaTri.Contains(input.Filter))
                        .WhereIf(!string.IsNullOrWhiteSpace(input.GiaTriFilter), e => e.GiaTri == input.GiaTriFilter)
                        .WhereIf(!string.IsNullOrWhiteSpace(input.ThuocTinhTenThuocTinhFilter), e => e.ThuocTinhFk != null && e.ThuocTinhFk.TenThuocTinh == input.ThuocTinhTenThuocTinhFilter)
                        .WhereIf(!string.IsNullOrWhiteSpace(input.BaiDangTieuDeFilter), e => e.BaiDangFk != null && e.BaiDangFk.TieuDe == input.BaiDangTieuDeFilter);

            var pagedAndFilteredChiTietBaiDangs = filteredChiTietBaiDangs
                .OrderBy(input.Sorting ?? "id asc")
                .PageBy(input);

            var chiTietBaiDangs = from o in pagedAndFilteredChiTietBaiDangs
                                  join o1 in _lookup_thuocTinhRepository.GetAll() on o.ThuocTinhId equals o1.Id into j1
                                  from s1 in j1.DefaultIfEmpty()

                                  join o2 in _lookup_baiDangRepository.GetAll() on o.BaiDangId equals o2.Id into j2
                                  from s2 in j2.DefaultIfEmpty()

                                  select new GetChiTietBaiDangForViewDto()
                                  {
                                      ChiTietBaiDang = new ChiTietBaiDangDto
                                      {
                                          GiaTri = o.GiaTri,
                                          Id = o.Id,
                                          ThuocTinhId = o.ThuocTinhId,
                                          BaiDangId = o.BaiDangId
                                      },
                                      ThuocTinhTenThuocTinh = s1 == null || s1.TenThuocTinh == null ? "" : s1.TenThuocTinh.ToString(),
                                      BaiDangTieuDe = s2 == null || s2.TieuDe == null ? "" : s2.TieuDe.ToString()
                                  };

            var totalCount = await filteredChiTietBaiDangs.CountAsync();

            return new PagedResultDto<GetChiTietBaiDangForViewDto>(
                totalCount,
                await chiTietBaiDangs.ToListAsync()
            );
        }
        [AbpAllowAnonymous]
        public async Task<PagedResultDto<GetChiTietBaiDangForViewDto>> GetAllChiTietBaiDangByPostId(long postId)
        {

            var filteredChiTietBaiDangs = _chiTietBaiDangRepository.GetAll()
                        .Include(e => e.ThuocTinhFk)
                        .Include(e => e.BaiDangFk)
                        .Where(e => e.BaiDangFk != null && e.BaiDangFk.Id == postId);

            var pagedAndFilteredChiTietBaiDangs = filteredChiTietBaiDangs
                .OrderBy("id asc");

            var chiTietBaiDangs = from o in pagedAndFilteredChiTietBaiDangs
                                  join o1 in _lookup_thuocTinhRepository.GetAll() on o.ThuocTinhId equals o1.Id into j1
                                  from s1 in j1.DefaultIfEmpty()

                                  join o2 in _lookup_baiDangRepository.GetAll() on o.BaiDangId equals o2.Id into j2
                                  from s2 in j2.DefaultIfEmpty()

                                  select new GetChiTietBaiDangForViewDto()
                                  {
                                      ChiTietBaiDang = new ChiTietBaiDangDto
                                      {
                                          GiaTri = o.GiaTri,
                                          Id = o.Id,
                                          ThuocTinhId = o.ThuocTinhId,
                                          BaiDangId = o.BaiDangId
                                      },
                                      ThuocTinhTenThuocTinh = s1 == null || s1.TenThuocTinh == null ? "" : s1.TenThuocTinh.ToString(),
                                      BaiDangTieuDe = s2 == null || s2.TieuDe == null ? "" : s2.TieuDe.ToString()
                                  };

            var totalCount = await filteredChiTietBaiDangs.CountAsync();

            return new PagedResultDto<GetChiTietBaiDangForViewDto>(
                totalCount,
                await chiTietBaiDangs.ToListAsync()
            );
        }

        public async Task<GetChiTietBaiDangForViewDto> GetChiTietBaiDangForView(int id)
        {
            var chiTietBaiDang = await _chiTietBaiDangRepository.GetAsync(id);

            var output = new GetChiTietBaiDangForViewDto { ChiTietBaiDang = ObjectMapper.Map<ChiTietBaiDangDto>(chiTietBaiDang) };

            if (output.ChiTietBaiDang.ThuocTinhId != null)
            {
                var _lookupThuocTinh = await _lookup_thuocTinhRepository.FirstOrDefaultAsync((int)output.ChiTietBaiDang.ThuocTinhId);
                output.ThuocTinhTenThuocTinh = _lookupThuocTinh?.TenThuocTinh?.ToString();
            }

            if (output.ChiTietBaiDang.BaiDangId != null)
            {
                var _lookupBaiDang = await _lookup_baiDangRepository.FirstOrDefaultAsync((int)output.ChiTietBaiDang.BaiDangId);
                output.BaiDangTieuDe = _lookupBaiDang?.TieuDe?.ToString();
            }

            return output;
        }

        [AbpAuthorize(AppPermissions.Pages_ChiTietBaiDangs_Edit)]
        public async Task<GetChiTietBaiDangForEditOutput> GetChiTietBaiDangForEdit(EntityDto input)
        {
            var chiTietBaiDang = await _chiTietBaiDangRepository.FirstOrDefaultAsync(input.Id);

            var output = new GetChiTietBaiDangForEditOutput { ChiTietBaiDang = ObjectMapper.Map<CreateOrEditChiTietBaiDangDto>(chiTietBaiDang) };

            if (output.ChiTietBaiDang.ThuocTinhId != null)
            {
                var _lookupThuocTinh = await _lookup_thuocTinhRepository.FirstOrDefaultAsync((int)output.ChiTietBaiDang.ThuocTinhId);
                output.ThuocTinhTenThuocTinh = _lookupThuocTinh?.TenThuocTinh?.ToString();
            }

            if (output.ChiTietBaiDang.BaiDangId != null)
            {
                var _lookupBaiDang = await _lookup_baiDangRepository.FirstOrDefaultAsync((int)output.ChiTietBaiDang.BaiDangId);
                output.BaiDangTieuDe = _lookupBaiDang?.TieuDe?.ToString();
            }

            return output;
        }

        public async Task CreateOrEdit(CreateOrEditChiTietBaiDangDto input)
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

        [AbpAuthorize(AppPermissions.Pages_ChiTietBaiDangs_Create)]
        protected virtual async Task Create(CreateOrEditChiTietBaiDangDto input)
        {
            var chiTietBaiDang = ObjectMapper.Map<ChiTietBaiDang>(input);

            await _chiTietBaiDangRepository.InsertAsync(chiTietBaiDang);
        }

        [AbpAuthorize(AppPermissions.Pages_ChiTietBaiDangs_Edit)]
        protected virtual async Task Update(CreateOrEditChiTietBaiDangDto input)
        {
            var chiTietBaiDang = await _chiTietBaiDangRepository.FirstOrDefaultAsync((int)input.Id);
            ObjectMapper.Map(input, chiTietBaiDang);
        }

        [AbpAuthorize(AppPermissions.Pages_ChiTietBaiDangs_Delete)]
        public async Task Delete(EntityDto input)
        {
            await _chiTietBaiDangRepository.DeleteAsync(input.Id);
        }

        public async Task<FileDto> GetChiTietBaiDangsToExcel(GetAllChiTietBaiDangsForExcelInput input)
        {

            var filteredChiTietBaiDangs = _chiTietBaiDangRepository.GetAll()
                        .Include(e => e.ThuocTinhFk)
                        .Include(e => e.BaiDangFk)
                        .WhereIf(!string.IsNullOrWhiteSpace(input.Filter), e => false || e.GiaTri.Contains(input.Filter))
                        .WhereIf(!string.IsNullOrWhiteSpace(input.GiaTriFilter), e => e.GiaTri == input.GiaTriFilter)
                        .WhereIf(!string.IsNullOrWhiteSpace(input.ThuocTinhTenThuocTinhFilter), e => e.ThuocTinhFk != null && e.ThuocTinhFk.TenThuocTinh == input.ThuocTinhTenThuocTinhFilter)
                        .WhereIf(!string.IsNullOrWhiteSpace(input.BaiDangTieuDeFilter), e => e.BaiDangFk != null && e.BaiDangFk.TieuDe == input.BaiDangTieuDeFilter);

            var query = (from o in filteredChiTietBaiDangs
                         join o1 in _lookup_thuocTinhRepository.GetAll() on o.ThuocTinhId equals o1.Id into j1
                         from s1 in j1.DefaultIfEmpty()

                         join o2 in _lookup_baiDangRepository.GetAll() on o.BaiDangId equals o2.Id into j2
                         from s2 in j2.DefaultIfEmpty()

                         select new GetChiTietBaiDangForViewDto()
                         {
                             ChiTietBaiDang = new ChiTietBaiDangDto
                             {
                                 GiaTri = o.GiaTri,
                                 Id = o.Id
                             },
                             ThuocTinhTenThuocTinh = s1 == null || s1.TenThuocTinh == null ? "" : s1.TenThuocTinh.ToString(),
                             BaiDangTieuDe = s2 == null || s2.TieuDe == null ? "" : s2.TieuDe.ToString()
                         });

            var chiTietBaiDangListDtos = await query.ToListAsync();

            return _chiTietBaiDangsExcelExporter.ExportToFile(chiTietBaiDangListDtos);
        }

        [AbpAuthorize(AppPermissions.Pages_ChiTietBaiDangs)]
        public async Task<PagedResultDto<ChiTietBaiDangThuocTinhLookupTableDto>> GetAllThuocTinhForLookupTable(GetAllForLookupTableInput input)
        {
            var query = _lookup_thuocTinhRepository.GetAll().WhereIf(
                   !string.IsNullOrWhiteSpace(input.Filter),
                  e => e.TenThuocTinh != null && e.TenThuocTinh.Contains(input.Filter)
               );

            var totalCount = await query.CountAsync();

            var thuocTinhList = await query
                .PageBy(input)
                .ToListAsync();

            var lookupTableDtoList = new List<ChiTietBaiDangThuocTinhLookupTableDto>();
            foreach (var thuocTinh in thuocTinhList)
            {
                lookupTableDtoList.Add(new ChiTietBaiDangThuocTinhLookupTableDto
                {
                    Id = thuocTinh.Id,
                    DisplayName = thuocTinh.TenThuocTinh?.ToString()
                });
            }

            return new PagedResultDto<ChiTietBaiDangThuocTinhLookupTableDto>(
                totalCount,
                lookupTableDtoList
            );
        }

        [AbpAuthorize(AppPermissions.Pages_ChiTietBaiDangs)]
        public async Task<PagedResultDto<ChiTietBaiDangBaiDangLookupTableDto>> GetAllBaiDangForLookupTable(GetAllForLookupTableInput input)
        {
            var query = _lookup_baiDangRepository.GetAll().WhereIf(
                   !string.IsNullOrWhiteSpace(input.Filter),
                  e => e.TieuDe != null && e.TieuDe.Contains(input.Filter)
               );

            var totalCount = await query.CountAsync();

            var baiDangList = await query
                .PageBy(input)
                .ToListAsync();

            var lookupTableDtoList = new List<ChiTietBaiDangBaiDangLookupTableDto>();
            foreach (var baiDang in baiDangList)
            {
                lookupTableDtoList.Add(new ChiTietBaiDangBaiDangLookupTableDto
                {
                    Id = baiDang.Id,
                    DisplayName = baiDang.TieuDe?.ToString()
                });
            }

            return new PagedResultDto<ChiTietBaiDangBaiDangLookupTableDto>(
                totalCount,
                lookupTableDtoList
            );
        }
    }
}