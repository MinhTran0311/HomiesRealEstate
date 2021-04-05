using System.Collections.Generic;
using Homies.RealEstate.Editions.Dto;

namespace Homies.RealEstate.Web.Areas.App.Models.Tenants
{
    public class TenantIndexViewModel
    {
        public List<SubscribableEditionComboboxItemDto> EditionItems { get; set; }
    }
}