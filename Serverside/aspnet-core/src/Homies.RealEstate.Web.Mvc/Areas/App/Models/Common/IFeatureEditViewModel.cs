using System.Collections.Generic;
using Abp.Application.Services.Dto;
using Homies.RealEstate.Editions.Dto;

namespace Homies.RealEstate.Web.Areas.App.Models.Common
{
    public interface IFeatureEditViewModel
    {
        List<NameValueDto> FeatureValues { get; set; }

        List<FlatFeatureDto> Features { get; set; }
    }
}