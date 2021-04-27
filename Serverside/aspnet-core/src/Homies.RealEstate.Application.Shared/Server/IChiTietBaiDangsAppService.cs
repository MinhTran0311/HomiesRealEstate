using System;
using System.Threading.Tasks;
using Abp.Application.Services;
using Abp.Application.Services.Dto;
using Homies.RealEstate.Server.Dtos;
using Homies.RealEstate.Dto;

namespace Homies.RealEstate.Server
{
    public interface IChiTietBaiDangsAppService : IApplicationService
    {
        Task<PagedResultDto<GetChiTietBaiDangForViewDto>> GetAll(GetAllChiTietBaiDangsInput input);

        Task<GetChiTietBaiDangForViewDto> GetChiTietBaiDangForView(int id);

        Task<GetChiTietBaiDangForEditOutput> GetChiTietBaiDangForEdit(EntityDto input);

        Task CreateOrEdit(CreateOrEditChiTietBaiDangDto input);

        Task Delete(EntityDto input);

        Task<FileDto> GetChiTietBaiDangsToExcel(GetAllChiTietBaiDangsForExcelInput input);

        Task<PagedResultDto<ChiTietBaiDangThuocTinhLookupTableDto>> GetAllThuocTinhForLookupTable(GetAllForLookupTableInput input);

        Task<PagedResultDto<ChiTietBaiDangBaiDangLookupTableDto>> GetAllBaiDangForLookupTable(GetAllForLookupTableInput input);

    }
}