using System.Collections.Generic;
using MvvmHelpers;
using Homies.RealEstate.Models.NavigationMenu;

namespace Homies.RealEstate.Services.Navigation
{
    public interface IMenuProvider
    {
        ObservableRangeCollection<NavigationMenuItem> GetAuthorizedMenuItems(Dictionary<string, string> grantedPermissions);
    }
}