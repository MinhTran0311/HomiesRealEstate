using Abp.AspNetCore.Mvc.Views;

namespace Homies.RealEstate.Web.Views
{
    public abstract class RealEstateRazorPage<TModel> : AbpRazorPage<TModel>
    {
        protected RealEstateRazorPage()
        {
            LocalizationSourceName = RealEstateConsts.LocalizationSourceName;
        }
    }
}
