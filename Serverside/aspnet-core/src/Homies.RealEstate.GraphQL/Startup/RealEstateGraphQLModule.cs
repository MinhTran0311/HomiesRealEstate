using Abp.AutoMapper;
using Abp.Modules;
using Abp.Reflection.Extensions;

namespace Homies.RealEstate.Startup
{
    [DependsOn(typeof(RealEstateCoreModule))]
    public class RealEstateGraphQLModule : AbpModule
    {
        public override void Initialize()
        {
            IocManager.RegisterAssemblyByConvention(typeof(RealEstateGraphQLModule).GetAssembly());
        }

        public override void PreInitialize()
        {
            base.PreInitialize();

            //Adding custom AutoMapper configuration
            Configuration.Modules.AbpAutoMapper().Configurators.Add(CustomDtoMapper.CreateMappings);
        }
    }
}