using System;
using System.Threading.Tasks;
using Abp.Application.Services;
using Abp.Application.Services.Dto;
using Homies.RealEstate.Server.Dtos;
using Homies.RealEstate.Dto;

namespace Homies.RealEstate.Server
{
    public interface ITinhsAppService : IApplicationService
    {
        Task<PagedResultDto<GetTinhForViewDto>> GetAll(GetAllTinhsInput input);

        Task<GetTinhForViewDto> GetTinhForView(int id);

        Task<GetTinhForEditOutput> GetTinhForEdit(EntityDto input);

        Task CreateOrEdit(CreateOrEditTinhDto input);

        Task Delete(EntityDto input);

        Task<FileDto> GetTinhsToExcel(GetAllTinhsForExcelInput input);

    }
}