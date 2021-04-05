using Abp.AspNetCore.Mvc.Views;
using Abp.Runtime.Session;
using Microsoft.AspNetCore.Mvc.Razor.Internal;

namespace Homies.RealEstate.Web.Public.Views
{
    public abstract class RealEstateRazorPage<TModel> : AbpRazorPage<TModel>
    {
        [RazorInject]
        public IAbpSession AbpSession { get; set; }

        protected RealEstateRazorPage()
        {
            LocalizationSourceName = RealEstateConsts.LocalizationSourceName;
        }
    }
}
