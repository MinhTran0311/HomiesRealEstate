using System.Collections.Generic;
using Homies.RealEstate.DynamicEntityProperties.Dto;

namespace Homies.RealEstate.Web.Areas.App.Models.DynamicProperty
{
    public class CreateOrEditDynamicPropertyViewModel
    {
        public DynamicPropertyDto DynamicPropertyDto { get; set; }

        public List<string> AllowedInputTypes { get; set; }
    }
}
