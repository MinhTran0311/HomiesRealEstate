using System.Collections.Generic;
using Homies.RealEstate.Caching.Dto;

namespace Homies.RealEstate.Web.Areas.App.Models.Maintenance
{
    public class MaintenanceViewModel
    {
        public IReadOnlyList<CacheDto> Caches { get; set; }
    }
}