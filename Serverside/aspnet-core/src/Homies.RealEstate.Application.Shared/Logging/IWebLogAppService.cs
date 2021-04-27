using Abp.Application.Services;
using Homies.RealEstate.Dto;
using Homies.RealEstate.Logging.Dto;

namespace Homies.RealEstate.Logging
{
    public interface IWebLogAppService : IApplicationService
    {
        GetLatestWebLogsOutput GetLatestWebLogs();

        FileDto DownloadWebLogs();
    }
}
