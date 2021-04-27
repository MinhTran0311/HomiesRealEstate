using System;
using System.Threading.Tasks;
using Abp.Application.Services;
using Abp.Application.Services.Dto;
using Homies.RealEstate.Server.Dtos;
using Homies.RealEstate.Dto;

namespace Homies.RealEstate.Server
{
    public interface IChiTietDanhMucsAppService : IApplicationService
    {
        Task<PagedResultDto<GetChiTietDanhMucForViewDto>> GetAll(GetAllChiTietDanhMucsInput input);

        Task<GetChiTietDanhMucForViewDto> GetChiTietDanhMucForView(int id);

        Task<GetChiTietDanhMucForEditOutput> GetChiTietDanhMucForEdit(EntityDto input);

        Task CreateOrEdit(CreateOrEditChiTietDanhMucDto input);

        Task Delete(EntityDto input);

        Task<FileDto> GetChiTietDanhMucsToExcel(GetAllChiTietDanhMucsForExcelInput input);

        Task<PagedResultDto<ChiTietDanhMucThuocTinhLookupTableDto>> GetAllThuocTinhForLookupTable(GetAllForLookupTableInput input);

        Task<PagedResultDto<ChiTietDanhMucDanhMucLookupTableDto>> GetAllDanhMucForLookupTable(GetAllForLookupTableInput input);

    }
}