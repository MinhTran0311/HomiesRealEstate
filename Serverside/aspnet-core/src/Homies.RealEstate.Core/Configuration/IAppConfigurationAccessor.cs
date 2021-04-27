using Microsoft.Extensions.Configuration;

namespace Homies.RealEstate.Configuration
{
    public interface IAppConfigurationAccessor
    {
        IConfigurationRoot Configuration { get; }
    }
}
