using System.Collections.Generic;
using Homies.RealEstate.Authorization.Permissions.Dto;
using Homies.RealEstate.Authorization.Users.Dto;

namespace Homies.RealEstate.Authorization.Roles.Dto
{
    public class GetRoleForViewOutput
    {
        public List<UserListRoleDto> Role { get; set; }

        public List<FlatPermissionDto> Permissions { get; set; }

        public List<string> GrantedPermissionNames { get; set; }
    }
}