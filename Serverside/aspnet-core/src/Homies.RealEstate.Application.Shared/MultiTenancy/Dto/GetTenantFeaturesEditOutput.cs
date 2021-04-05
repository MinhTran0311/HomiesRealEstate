using System.Collections.Generic;
using Abp.Application.Services.Dto;
using Homies.RealEstate.Editions.Dto;

namespace Homies.RealEstate.MultiTenancy.Dto
{
    public class GetTenantFeaturesEditOutput
    {
        public List<NameValueDto> FeatureValues { get; set; }

        public List<FlatFeatureDto> Features { get; set; }
    }
}