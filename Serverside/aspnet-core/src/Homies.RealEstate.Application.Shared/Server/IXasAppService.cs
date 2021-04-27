using System;
using System.Threading.Tasks;
using Abp.Application.Services;
using Abp.Application.Services.Dto;
using Homies.RealEstate.Server.Dtos;
using Homies.RealEstate.Dto;

namespace Homies.RealEstate.Server
{
    public interface IXasAppService : IApplicationService
    {
        Task<PagedResultDto<GetXaForViewDto>> GetAll(GetAllXasInput input);

        Task<GetXaForViewDto> GetXaForView(int id);

        Task<GetXaForEditOutput> GetXaForEdit(EntityDto input);

        Task CreateOrEdit(CreateOrEditXaDto input);

        Task Delete(EntityDto input);

        Task<FileDto> GetXasToExcel(GetAllXasForExcelInput input);

        Task<PagedResultDto<XaHuyenLookupTableDto>> GetAllHuyenForLookupTable(GetAllForLookupTableInput input);

    }
}