using Abp.AutoMapper;
using Homies.RealEstate.Organizations.Dto;

namespace Homies.RealEstate.Models.Users
{
    [AutoMapFrom(typeof(OrganizationUnitDto))]
    public class OrganizationUnitModel : OrganizationUnitDto
    {
        public bool IsAssigned { get; set; }
    }
}