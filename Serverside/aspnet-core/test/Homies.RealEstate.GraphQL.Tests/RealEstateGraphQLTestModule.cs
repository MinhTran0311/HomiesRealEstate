using Abp.Modules;
using Abp.Reflection.Extensions;
using Castle.Windsor.MsDependencyInjection;
using Microsoft.Extensions.DependencyInjection;
using Homies.RealEstate.Configure;
using Homies.RealEstate.Startup;
using Homies.RealEstate.Test.Base;

namespace Homies.RealEstate.GraphQL.Tests
{
    [DependsOn(
        typeof(RealEstateGraphQLModule),
        typeof(RealEstateTestBaseModule))]
    public class RealEstateGraphQLTestModule : AbpModule
    {
        public override void PreInitialize()
        {
            IServiceCollection services = new ServiceCollection();
            
            services.AddAndConfigureGraphQL();

            WindsorRegistrationHelper.CreateServiceProvider(IocManager.IocContainer, services);
        }

        public override void Initialize()
        {
            IocManager.RegisterAssemblyByConvention(typeof(RealEstateGraphQLTestModule).GetAssembly());
        }
    }
}