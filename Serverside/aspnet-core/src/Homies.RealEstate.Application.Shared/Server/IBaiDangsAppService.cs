using System;
using System.Threading.Tasks;
using Abp.Application.Services;
using Abp.Application.Services.Dto;
using Homies.RealEstate.Server.Dtos;
using Homies.RealEstate.Dto;

namespace Homies.RealEstate.Server
{
    public interface IBaiDangsAppService : IApplicationService
    {
        Task<PagedResultDto<GetBaiDangForViewDto>> GetAll(GetAllBaiDangsInput input);

        Task<GetBaiDangForViewDto> GetBaiDangForView(int id);

        Task<GetBaiDangForEditOutput> GetBaiDangForEdit(EntityDto input);

        Task CreateOrEdit(CreateOrEditBaiDangDto input);

        Task Delete(EntityDto input);

        Task<FileDto> GetBaiDangsToExcel(GetAllBaiDangsForExcelInput input);

        Task<PagedResultDto<BaiDangUserLookupTableDto>> GetAllUserForLookupTable(GetAllForLookupTableInput input);

        Task<PagedResultDto<BaiDangDanhMucLookupTableDto>> GetAllDanhMucForLookupTable(GetAllForLookupTableInput input);

        Task<PagedResultDto<BaiDangXaLookupTableDto>> GetAllXaForLookupTable(GetAllForLookupTableInput input);

    }
}