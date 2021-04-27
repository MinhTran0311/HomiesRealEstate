using System.Collections.Generic;
using Homies.RealEstate.Authorization.Permissions.Dto;

namespace Homies.RealEstate.Authorization.Roles.Dto
{
    public class GetRoleForEditOutput
    {
        public RoleEditDto Role { get; set; }

        public List<FlatPermissionDto> Permissions { get; set; }

        public List<string> GrantedPermissionNames { get; set; }
    }
}