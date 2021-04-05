using Abp.AutoMapper;
using Homies.RealEstate.Sessions.Dto;

namespace Homies.RealEstate.Web.Views.Shared.Components.TenantChange
{
    [AutoMapFrom(typeof(GetCurrentLoginInformationsOutput))]
    public class TenantChangeViewModel
    {
        public TenantLoginInfoDto Tenant { get; set; }
    }
}