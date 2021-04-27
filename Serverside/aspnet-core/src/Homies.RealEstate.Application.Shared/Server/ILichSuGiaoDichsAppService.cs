using System;
using System.Threading.Tasks;
using Abp.Application.Services;
using Abp.Application.Services.Dto;
using Homies.RealEstate.Server.Dtos;
using Homies.RealEstate.Dto;

namespace Homies.RealEstate.Server
{
    public interface ILichSuGiaoDichsAppService : IApplicationService
    {
        Task<PagedResultDto<GetLichSuGiaoDichForViewDto>> GetAll(GetAllLichSuGiaoDichsInput input);

        Task<GetLichSuGiaoDichForViewDto> GetLichSuGiaoDichForView(Guid id);

        Task<GetLichSuGiaoDichForEditOutput> GetLichSuGiaoDichForEdit(EntityDto<Guid> input);

        Task CreateOrEdit(CreateOrEditLichSuGiaoDichDto input);

        Task Delete(EntityDto<Guid> input);

        Task<FileDto> GetLichSuGiaoDichsToExcel(GetAllLichSuGiaoDichsForExcelInput input);

        Task<PagedResultDto<LichSuGiaoDichUserLookupTableDto>> GetAllUserForLookupTable(GetAllForLookupTableInput input);

        Task<PagedResultDto<LichSuGiaoDichChiTietHoaDonBaiDangLookupTableDto>> GetAllChiTietHoaDonBaiDangForLookupTable(GetAllForLookupTableInput input);

    }
}