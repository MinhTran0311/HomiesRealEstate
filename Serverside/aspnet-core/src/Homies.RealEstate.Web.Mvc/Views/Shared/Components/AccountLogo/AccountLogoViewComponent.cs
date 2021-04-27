using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Homies.RealEstate.Web.Session;

namespace Homies.RealEstate.Web.Views.Shared.Components.AccountLogo
{
    public class AccountLogoViewComponent : RealEstateViewComponent
    {
        private readonly IPerRequestSessionCache _sessionCache;

        public AccountLogoViewComponent(IPerRequestSessionCache sessionCache)
        {
            _sessionCache = sessionCache;
        }

        public async Task<IViewComponentResult> InvokeAsync(string skin)
        {
            var loginInfo = await _sessionCache.GetCurrentLoginInformationsAsync();
            return View(new AccountLogoViewModel(loginInfo, skin));
        }
    }
}
