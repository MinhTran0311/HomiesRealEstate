using System.Collections.Generic;

namespace Homies.RealEstate.DashboardCustomization.Dto
{
    /// <summary>
    /// This class stores filtered dashboard information by user
    /// </summary>
    public class DashboardOutput
    {
        public string Name { get; set; }

        public List<WidgetOutput> Widgets { get; set; }

        public DashboardOutput(string name, List<WidgetOutput> widgets)
        {
            Name = name;
            Widgets = widgets;
        }
    }
}
