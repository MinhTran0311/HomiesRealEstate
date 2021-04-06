using System;
using System.Threading.Tasks;
using Abp.Application.Services;
using Abp.Application.Services.Dto;
using Homies.RealEstate.Server.Dtos;
using Homies.RealEstate.Dto;

namespace Homies.RealEstate.Server
{
    public interface IChiTietHoaDonBaiDangsAppService : IApplicationService
    {
        Task<PagedResultDto<GetChiTietHoaDonBaiDangForViewDto>> GetAll(GetAllChiTietHoaDonBaiDangsInput input);

        Task<GetChiTietHoaDonBaiDangForViewDto> GetChiTietHoaDonBaiDangForView(Guid id);

        Task<GetChiTietHoaDonBaiDangForEditOutput> GetChiTietHoaDonBaiDangForEdit(EntityDto<Guid> input);

        Task CreateOrEdit(CreateOrEditChiTietHoaDonBaiDangDto input);

        Task Delete(EntityDto<Guid> input);

        Task<FileDto> GetChiTietHoaDonBaiDangsToExcel(GetAllChiTietHoaDonBaiDangsForExcelInput input);

        Task<PagedResultDto<ChiTietHoaDonBaiDangBaiDangLookupTableDto>> GetAllBaiDangForLookupTable(GetAllForLookupTableInput input);

        Task<PagedResultDto<ChiTietHoaDonBaiDangGoiBaiDangLookupTableDto>> GetAllGoiBaiDangForLookupTable(GetAllForLookupTableInput input);

        Task<PagedResultDto<ChiTietHoaDonBaiDangUserLookupTableDto>> GetAllUserForLookupTable(GetAllForLookupTableInput input);

    }
}