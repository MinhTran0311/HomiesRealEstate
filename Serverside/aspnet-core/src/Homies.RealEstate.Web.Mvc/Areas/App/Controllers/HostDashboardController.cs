using Abp.AspNetCore.Mvc.Authorization;
using Microsoft.AspNetCore.Mvc;
using Homies.RealEstate.Authorization;
using Homies.RealEstate.DashboardCustomization;
using System.Threading.Tasks;
using Homies.RealEstate.Web.Areas.App.Startup;

namespace Homies.RealEstate.Web.Areas.App.Controllers
{
    [Area("App")]
    [AbpMvcAuthorize(AppPermissions.Pages_Administration_Host_Dashboard)]
    public class HostDashboardController : CustomizableDashboardControllerBase
    {
        public HostDashboardController(
            DashboardViewConfiguration dashboardViewConfiguration,
            IDashboardCustomizationAppService dashboardCustomizationAppService)
            : base(dashboardViewConfiguration, dashboardCustomizationAppService)
        {

        }

        public async Task<ActionResult> Index()
        {
            return await GetView(RealEstateDashboardCustomizationConsts.DashboardNames.DefaultHostDashboard);
        }
    }
}