using Abp.AutoMapper;
using Abp.Modules;
using Abp.Reflection.Extensions;
using Homies.RealEstate.Authorization;

namespace Homies.RealEstate
{
    /// <summary>
    /// Application layer module of the application.
    /// </summary>
    [DependsOn(
        typeof(RealEstateApplicationSharedModule),
        typeof(RealEstateCoreModule)
        )]
    public class RealEstateApplicationModule : AbpModule
    {
        public override void PreInitialize()
        {
            //Adding authorization providers
            Configuration.Authorization.Providers.Add<AppAuthorizationProvider>();

            //Adding custom AutoMapper configuration
            Configuration.Modules.AbpAutoMapper().Configurators.Add(CustomDtoMapper.CreateMappings);
        }

        public override void Initialize()
        {
            IocManager.RegisterAssemblyByConvention(typeof(RealEstateApplicationModule).GetAssembly());
        }
    }
}