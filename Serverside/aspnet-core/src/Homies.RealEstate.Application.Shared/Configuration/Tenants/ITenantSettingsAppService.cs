using System.Threading.Tasks;
using Abp.Application.Services;
using Homies.RealEstate.Configuration.Tenants.Dto;

namespace Homies.RealEstate.Configuration.Tenants
{
    public interface ITenantSettingsAppService : IApplicationService
    {
        Task<TenantSettingsEditDto> GetAllSettings();

        Task UpdateAllSettings(TenantSettingsEditDto input);

        Task ClearLogo();

        Task ClearCustomCss();
    }
}
