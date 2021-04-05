using System.Collections.Generic;
using Homies.RealEstate.Organizations.Dto;

namespace Homies.RealEstate.Web.Areas.App.Models.Common
{
    public interface IOrganizationUnitsEditViewModel
    {
        List<OrganizationUnitDto> AllOrganizationUnits { get; set; }

        List<string> MemberedOrganizationUnits { get; set; }
    }
}