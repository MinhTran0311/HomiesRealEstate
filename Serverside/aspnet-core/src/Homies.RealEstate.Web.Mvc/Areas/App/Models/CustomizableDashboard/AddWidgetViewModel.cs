using System.Collections.Generic;
using Homies.RealEstate.DashboardCustomization.Dto;

namespace Homies.RealEstate.Web.Areas.App.Models.CustomizableDashboard
{
    public class AddWidgetViewModel
    {
        public List<WidgetOutput> Widgets { get; set; }

        public string DashboardName { get; set; }

        public string PageId { get; set; }
    }
}
