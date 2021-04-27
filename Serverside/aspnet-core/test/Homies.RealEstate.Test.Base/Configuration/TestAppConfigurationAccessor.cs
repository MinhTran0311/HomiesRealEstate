using Abp.Dependency;
using Abp.Reflection.Extensions;
using Microsoft.Extensions.Configuration;
using Homies.RealEstate.Configuration;

namespace Homies.RealEstate.Test.Base.Configuration
{
    public class TestAppConfigurationAccessor : IAppConfigurationAccessor, ISingletonDependency
    {
        public IConfigurationRoot Configuration { get; }

        public TestAppConfigurationAccessor()
        {
            Configuration = AppConfigurations.Get(
                typeof(RealEstateTestBaseModule).GetAssembly().GetDirectoryPathOrNull()
            );
        }
    }
}
