using Microsoft.AspNetCore.Antiforgery;

namespace Homies.RealEstate.Web.Controllers
{
    public class AntiForgeryController : RealEstateControllerBase
    {
        private readonly IAntiforgery _antiforgery;

        public AntiForgeryController(IAntiforgery antiforgery)
        {
            _antiforgery = antiforgery;
        }

        public void GetToken()
        {
            _antiforgery.SetCookieTokenAndHeader(HttpContext);
        }
    }
}
