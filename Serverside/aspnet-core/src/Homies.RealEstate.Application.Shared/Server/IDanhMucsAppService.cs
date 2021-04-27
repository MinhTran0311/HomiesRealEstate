using System;
using System.Threading.Tasks;
using Abp.Application.Services;
using Abp.Application.Services.Dto;
using Homies.RealEstate.Server.Dtos;
using Homies.RealEstate.Dto;

namespace Homies.RealEstate.Server
{
    public interface IDanhMucsAppService : IApplicationService
    {
        Task<PagedResultDto<GetDanhMucForViewDto>> GetAll(GetAllDanhMucsInput input);

        Task<GetDanhMucForViewDto> GetDanhMucForView(int id);

        Task<GetDanhMucForEditOutput> GetDanhMucForEdit(EntityDto input);

        Task CreateOrEdit(CreateOrEditDanhMucDto input);

        Task Delete(EntityDto input);

        Task<FileDto> GetDanhMucsToExcel(GetAllDanhMucsForExcelInput input);

    }
}