using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Homies.RealEstate.Web.Areas.App.Models.Layout;
using Homies.RealEstate.Web.Views;

namespace Homies.RealEstate.Web.Areas.App.Views.Shared.Components.AppRecentNotifications
{
    public class AppRecentNotificationsViewComponent : RealEstateViewComponent
    {
        public Task<IViewComponentResult> InvokeAsync(string cssClass)
        {
            var model = new RecentNotificationsViewModel
            {
                CssClass = cssClass
            };
            
            return Task.FromResult<IViewComponentResult>(View(model));
        }
    }
}
