using Abp.AutoMapper;
using Homies.RealEstate.MultiTenancy.Dto;

namespace Homies.RealEstate.Web.Models.TenantRegistration
{
    [AutoMapFrom(typeof(EditionsSelectOutput))]
    public class EditionsSelectViewModel : EditionsSelectOutput
    {
    }
}
