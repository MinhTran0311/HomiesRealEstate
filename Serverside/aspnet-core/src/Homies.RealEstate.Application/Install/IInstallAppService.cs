using System.Threading.Tasks;
using Abp.Application.Services;
using Homies.RealEstate.Install.Dto;

namespace Homies.RealEstate.Install
{
    public interface IInstallAppService : IApplicationService
    {
        Task Setup(InstallDto input);

        AppSettingsJsonDto GetAppSettingsJson();

        CheckDatabaseOutput CheckDatabase();
    }
}