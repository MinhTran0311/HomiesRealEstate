using Abp.AutoMapper;
using Abp.Modules;
using Abp.Reflection.Extensions;

namespace Homies.RealEstate
{
    [DependsOn(typeof(RealEstateClientModule), typeof(AbpAutoMapperModule))]
    public class RealEstateXamarinSharedModule : AbpModule
    {
        public override void PreInitialize()
        {
            Configuration.Localization.IsEnabled = false;
            Configuration.BackgroundJobs.IsJobExecutionEnabled = false;
        }

        public override void Initialize()
        {
            IocManager.RegisterAssemblyByConvention(typeof(RealEstateXamarinSharedModule).GetAssembly());
        }
    }
}