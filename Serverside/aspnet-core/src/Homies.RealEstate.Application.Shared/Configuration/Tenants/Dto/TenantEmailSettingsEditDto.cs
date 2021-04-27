using Abp.Auditing;
using Homies.RealEstate.Configuration.Dto;

namespace Homies.RealEstate.Configuration.Tenants.Dto
{
    public class TenantEmailSettingsEditDto : EmailSettingsEditDto
    {
        public bool UseHostDefaultEmailSettings { get; set; }
    }
}