using System.Collections.Generic;

namespace Homies.RealEstate.DashboardCustomization.Definitions
{
    public class DashboardDefinition
    {
        public string Name { get; set; }

        public List<string> AvailableWidgets { get; set; }

        public DashboardDefinition(string name, List<string> availableWidgets)
        {
            Name = name;
            AvailableWidgets = availableWidgets;
        }
    }
}
