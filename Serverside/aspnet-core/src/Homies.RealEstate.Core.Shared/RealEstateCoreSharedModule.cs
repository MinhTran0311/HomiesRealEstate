using Abp.Modules;
using Abp.Reflection.Extensions;

namespace Homies.RealEstate
{
    public class RealEstateCoreSharedModule : AbpModule
    {
        public override void Initialize()
        {
            IocManager.RegisterAssemblyByConvention(typeof(RealEstateCoreSharedModule).GetAssembly());
        }
    }
}