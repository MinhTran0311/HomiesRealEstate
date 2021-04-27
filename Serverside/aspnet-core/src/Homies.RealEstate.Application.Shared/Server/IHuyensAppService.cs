using System;
using System.Threading.Tasks;
using Abp.Application.Services;
using Abp.Application.Services.Dto;
using Homies.RealEstate.Server.Dtos;
using Homies.RealEstate.Dto;

namespace Homies.RealEstate.Server
{
    public interface IHuyensAppService : IApplicationService
    {
        Task<PagedResultDto<GetHuyenForViewDto>> GetAll(GetAllHuyensInput input);

        Task<GetHuyenForViewDto> GetHuyenForView(int id);

        Task<GetHuyenForEditOutput> GetHuyenForEdit(EntityDto input);

        Task CreateOrEdit(CreateOrEditHuyenDto input);

        Task Delete(EntityDto input);

        Task<FileDto> GetHuyensToExcel(GetAllHuyensForExcelInput input);

        Task<PagedResultDto<HuyenTinhLookupTableDto>> GetAllTinhForLookupTable(GetAllForLookupTableInput input);

    }
}