using Abp.Modules;
using Abp.Reflection.Extensions;

namespace Homies.RealEstate
{
    public class RealEstateClientModule : AbpModule
    {
        public override void Initialize()
        {
            IocManager.RegisterAssemblyByConvention(typeof(RealEstateClientModule).GetAssembly());
        }
    }
}
