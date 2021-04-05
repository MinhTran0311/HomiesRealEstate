using System.Collections.Generic;
using Homies.RealEstate.Authorization.Permissions.Dto;

namespace Homies.RealEstate.Web.Areas.App.Models.Common
{
    public interface IPermissionsEditViewModel
    {
        List<FlatPermissionDto> Permissions { get; set; }

        List<string> GrantedPermissionNames { get; set; }
    }
}