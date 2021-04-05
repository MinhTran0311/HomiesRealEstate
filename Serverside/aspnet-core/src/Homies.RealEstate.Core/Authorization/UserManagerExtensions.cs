using System.Threading.Tasks;
using Abp.Authorization.Users;
using Homies.RealEstate.Authorization.Users;

namespace Homies.RealEstate.Authorization
{
    public static class UserManagerExtensions
    {
        public static async Task<User> GetAdminAsync(this UserManager userManager)
        {
            return await userManager.FindByNameAsync(AbpUserBase.AdminUserName);
        }
    }
}
