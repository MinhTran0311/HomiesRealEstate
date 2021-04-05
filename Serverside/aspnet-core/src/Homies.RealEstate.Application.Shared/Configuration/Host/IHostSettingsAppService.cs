using System.Threading.Tasks;
using Abp.Application.Services;
using Homies.RealEstate.Configuration.Host.Dto;

namespace Homies.RealEstate.Configuration.Host
{
    public interface IHostSettingsAppService : IApplicationService
    {
        Task<HostSettingsEditDto> GetAllSettings();

        Task UpdateAllSettings(HostSettingsEditDto input);

        Task SendTestEmail(SendTestEmailInput input);
    }
}
