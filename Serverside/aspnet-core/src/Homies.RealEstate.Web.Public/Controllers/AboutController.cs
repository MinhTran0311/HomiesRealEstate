using Microsoft.AspNetCore.Mvc;
using Homies.RealEstate.Web.Controllers;

namespace Homies.RealEstate.Web.Public.Controllers
{
    public class AboutController : RealEstateControllerBase
    {
        public ActionResult Index()
        {
            return View();
        }
    }
}