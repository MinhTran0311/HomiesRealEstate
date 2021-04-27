using System;
using System.Threading.Tasks;
using Abp.Application.Services;
using Abp.Application.Services.Dto;
using Homies.RealEstate.Server.Dtos;
using Homies.RealEstate.Dto;

namespace Homies.RealEstate.Server
{
    public interface IThuocTinhsAppService : IApplicationService
    {
        Task<PagedResultDto<GetThuocTinhForViewDto>> GetAll(GetAllThuocTinhsInput input);

        Task<GetThuocTinhForViewDto> GetThuocTinhForView(int id);

        Task<GetThuocTinhForEditOutput> GetThuocTinhForEdit(EntityDto input);

        Task CreateOrEdit(CreateOrEditThuocTinhDto input);

        Task Delete(EntityDto input);

        Task<FileDto> GetThuocTinhsToExcel(GetAllThuocTinhsForExcelInput input);

    }
}