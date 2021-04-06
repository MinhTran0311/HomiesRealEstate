using System;
using System.Threading.Tasks;
using Abp.Application.Services;
using Abp.Application.Services.Dto;
using Homies.RealEstate.Server.Dtos;
using Homies.RealEstate.Dto;

namespace Homies.RealEstate.Server
{
    public interface IThamSosAppService : IApplicationService
    {
        Task<PagedResultDto<GetThamSoForViewDto>> GetAll(GetAllThamSosInput input);

        Task<GetThamSoForViewDto> GetThamSoForView(int id);

        Task<GetThamSoForEditOutput> GetThamSoForEdit(EntityDto input);

        Task CreateOrEdit(CreateOrEditThamSoDto input);

        Task Delete(EntityDto input);

        Task<FileDto> GetThamSosToExcel(GetAllThamSosForExcelInput input);

    }
}