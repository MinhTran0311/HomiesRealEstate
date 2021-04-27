using System;
using System.Threading.Tasks;
using Abp.Application.Services;
using Abp.Application.Services.Dto;
using Homies.RealEstate.Server.Dtos;
using Homies.RealEstate.Dto;

namespace Homies.RealEstate.Server
{
    public interface IGoiBaiDangsAppService : IApplicationService
    {
        Task<PagedResultDto<GetGoiBaiDangForViewDto>> GetAll(GetAllGoiBaiDangsInput input);

        Task<GetGoiBaiDangForViewDto> GetGoiBaiDangForView(int id);

        Task<GetGoiBaiDangForEditOutput> GetGoiBaiDangForEdit(EntityDto input);

        Task CreateOrEdit(CreateOrEditGoiBaiDangDto input);

        Task Delete(EntityDto input);

        Task<FileDto> GetGoiBaiDangsToExcel(GetAllGoiBaiDangsForExcelInput input);

    }
}