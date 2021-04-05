using Abp.AspNetCore.Mvc.Authorization;
using Homies.RealEstate.Authorization;
using Homies.RealEstate.Storage;
using Abp.BackgroundJobs;

namespace Homies.RealEstate.Web.Controllers
{
    [AbpMvcAuthorize(AppPermissions.Pages_Administration_Users)]
    public class UsersController : UsersControllerBase
    {
        public UsersController(IBinaryObjectManager binaryObjectManager, IBackgroundJobManager backgroundJobManager)
            : base(binaryObjectManager, backgroundJobManager)
        {
        }
    }
}