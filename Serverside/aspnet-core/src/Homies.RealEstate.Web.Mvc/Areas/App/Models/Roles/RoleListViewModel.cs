using System.Collections.Generic;
using Abp.Application.Services.Dto;
using Homies.RealEstate.Authorization.Permissions.Dto;
using Homies.RealEstate.Web.Areas.App.Models.Common;

namespace Homies.RealEstate.Web.Areas.App.Models.Roles
{
    public class RoleListViewModel : IPermissionsEditViewModel
    {
        public List<FlatPermissionDto> Permissions { get; set; }

        public List<string> GrantedPermissionNames { get; set; }
    }
}