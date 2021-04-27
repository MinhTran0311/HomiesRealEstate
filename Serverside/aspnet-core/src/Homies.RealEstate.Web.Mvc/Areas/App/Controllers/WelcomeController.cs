using Abp.AspNetCore.Mvc.Authorization;
using Microsoft.AspNetCore.Mvc;
using Homies.RealEstate.Web.Controllers;

namespace Homies.RealEstate.Web.Areas.App.Controllers
{
    [Area("App")]
    [AbpMvcAuthorize]
    public class WelcomeController : RealEstateControllerBase
    {
        public ActionResult Index()
        {
            return View();
        }
    }
}