using Abp.AutoMapper;
using Homies.RealEstate.MultiTenancy;
using Homies.RealEstate.MultiTenancy.Dto;
using Homies.RealEstate.Web.Areas.App.Models.Common;

namespace Homies.RealEstate.Web.Areas.App.Models.Tenants
{
    [AutoMapFrom(typeof (GetTenantFeaturesEditOutput))]
    public class TenantFeaturesEditViewModel : GetTenantFeaturesEditOutput, IFeatureEditViewModel
    {
        public Tenant Tenant { get; set; }
    }
}