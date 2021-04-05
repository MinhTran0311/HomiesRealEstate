using System.Collections.Generic;
using Homies.RealEstate.Authorization.Permissions.Dto;

namespace Homies.RealEstate.Authorization.Users.Dto
{
    public class GetUserPermissionsForEditOutput
    {
        public List<FlatPermissionDto> Permissions { get; set; }

        public List<string> GrantedPermissionNames { get; set; }
    }
}