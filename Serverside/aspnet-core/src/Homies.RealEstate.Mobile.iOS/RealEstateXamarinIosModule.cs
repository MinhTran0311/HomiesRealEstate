using Abp.Modules;
using Abp.Reflection.Extensions;

namespace Homies.RealEstate
{
    [DependsOn(typeof(RealEstateXamarinSharedModule))]
    public class RealEstateXamarinIosModule : AbpModule
    {
        public override void Initialize()
        {
            IocManager.RegisterAssemblyByConvention(typeof(RealEstateXamarinIosModule).GetAssembly());
        }
    }
}