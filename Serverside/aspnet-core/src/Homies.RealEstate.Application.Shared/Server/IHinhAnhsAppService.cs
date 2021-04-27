using System;
using System.Threading.Tasks;
using Abp.Application.Services;
using Abp.Application.Services.Dto;
using Homies.RealEstate.Server.Dtos;
using Homies.RealEstate.Dto;

namespace Homies.RealEstate.Server
{
    public interface IHinhAnhsAppService : IApplicationService
    {
        Task<PagedResultDto<GetHinhAnhForViewDto>> GetAll(GetAllHinhAnhsInput input);

        Task<GetHinhAnhForViewDto> GetHinhAnhForView(int id);

        Task<GetHinhAnhForEditOutput> GetHinhAnhForEdit(EntityDto input);

        Task CreateOrEdit(CreateOrEditHinhAnhDto input);

        Task Delete(EntityDto input);

        Task<FileDto> GetHinhAnhsToExcel(GetAllHinhAnhsForExcelInput input);

        Task<PagedResultDto<HinhAnhBaiDangLookupTableDto>> GetAllBaiDangForLookupTable(GetAllForLookupTableInput input);

    }
}