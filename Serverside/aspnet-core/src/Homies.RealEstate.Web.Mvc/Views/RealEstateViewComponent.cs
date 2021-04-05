using Abp.AspNetCore.Mvc.ViewComponents;

namespace Homies.RealEstate.Web.Views
{
    public abstract class RealEstateViewComponent : AbpViewComponent
    {
        protected RealEstateViewComponent()
        {
            LocalizationSourceName = RealEstateConsts.LocalizationSourceName;
        }
    }
}