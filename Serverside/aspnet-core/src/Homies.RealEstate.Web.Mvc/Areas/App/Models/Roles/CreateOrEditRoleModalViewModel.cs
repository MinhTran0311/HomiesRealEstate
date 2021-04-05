using Abp.AutoMapper;
using Homies.RealEstate.Authorization.Roles.Dto;
using Homies.RealEstate.Web.Areas.App.Models.Common;

namespace Homies.RealEstate.Web.Areas.App.Models.Roles
{
    [AutoMapFrom(typeof(GetRoleForEditOutput))]
    public class CreateOrEditRoleModalViewModel : GetRoleForEditOutput, IPermissionsEditViewModel
    {
        public bool IsEditMode => Role.Id.HasValue;
    }
}