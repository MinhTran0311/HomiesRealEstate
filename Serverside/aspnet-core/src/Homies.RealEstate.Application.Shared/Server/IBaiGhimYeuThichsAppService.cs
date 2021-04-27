using System;
using System.Threading.Tasks;
using Abp.Application.Services;
using Abp.Application.Services.Dto;
using Homies.RealEstate.Server.Dtos;
using Homies.RealEstate.Dto;

namespace Homies.RealEstate.Server
{
    public interface IBaiGhimYeuThichsAppService : IApplicationService
    {
        Task<PagedResultDto<GetBaiGhimYeuThichForViewDto>> GetAll(GetAllBaiGhimYeuThichsInput input);

        Task<GetBaiGhimYeuThichForViewDto> GetBaiGhimYeuThichForView(int id);

        Task<GetBaiGhimYeuThichForEditOutput> GetBaiGhimYeuThichForEdit(EntityDto input);

        Task CreateOrEdit(CreateOrEditBaiGhimYeuThichDto input);

        Task Delete(EntityDto input);

        Task<FileDto> GetBaiGhimYeuThichsToExcel(GetAllBaiGhimYeuThichsForExcelInput input);

        Task<PagedResultDto<BaiGhimYeuThichUserLookupTableDto>> GetAllUserForLookupTable(GetAllForLookupTableInput input);

        Task<PagedResultDto<BaiGhimYeuThichBaiDangLookupTableDto>> GetAllBaiDangForLookupTable(GetAllForLookupTableInput input);

    }
}