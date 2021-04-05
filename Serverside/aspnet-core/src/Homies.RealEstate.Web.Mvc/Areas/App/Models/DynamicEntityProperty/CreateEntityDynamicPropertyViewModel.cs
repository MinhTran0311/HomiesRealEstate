using System.Collections.Generic;
using Homies.RealEstate.DynamicEntityProperties.Dto;

namespace Homies.RealEstate.Web.Areas.App.Models.DynamicEntityProperty
{
    public class CreateEntityDynamicPropertyViewModel
    {
        public string EntityFullName { get; set; }

        public List<string> AllEntities { get; set; }

        public List<DynamicPropertyDto> DynamicProperties { get; set; }
    }
}
