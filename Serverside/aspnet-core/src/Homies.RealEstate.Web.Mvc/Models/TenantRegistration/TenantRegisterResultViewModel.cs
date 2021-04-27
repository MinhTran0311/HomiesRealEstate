using Abp.AutoMapper;
using Homies.RealEstate.MultiTenancy.Dto;

namespace Homies.RealEstate.Web.Models.TenantRegistration
{
    [AutoMapFrom(typeof(RegisterTenantOutput))]
    public class TenantRegisterResultViewModel : RegisterTenantOutput
    {
        public string TenantLoginAddress { get; set; }
    }
}