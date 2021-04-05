using Abp.Authorization;
using Homies.RealEstate.Authorization.Roles;
using Homies.RealEstate.Authorization.Users;

namespace Homies.RealEstate.Authorization
{
    public class PermissionChecker : PermissionChecker<Role, User>
    {
        public PermissionChecker(UserManager userManager)
            : base(userManager)
        {

        }
    }
}
