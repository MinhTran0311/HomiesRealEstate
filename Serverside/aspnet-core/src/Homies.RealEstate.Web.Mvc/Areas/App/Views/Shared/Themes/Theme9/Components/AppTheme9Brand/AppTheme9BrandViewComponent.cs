﻿using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Homies.RealEstate.Web.Areas.App.Models.Layout;
using Homies.RealEstate.Web.Session;
using Homies.RealEstate.Web.Views;

namespace Homies.RealEstate.Web.Areas.App.Views.Shared.Themes.Theme9.Components.AppTheme9Brand
{
    public class AppTheme9BrandViewComponent : RealEstateViewComponent
    {
        private readonly IPerRequestSessionCache _sessionCache;

        public AppTheme9BrandViewComponent(IPerRequestSessionCache sessionCache)
        {
            _sessionCache = sessionCache;
        }

        public async Task<IViewComponentResult> InvokeAsync()
        {
            var headerModel = new HeaderViewModel
            {
                LoginInformations = await _sessionCache.GetCurrentLoginInformationsAsync()
            };

            return View(headerModel);
        }
    }
}
