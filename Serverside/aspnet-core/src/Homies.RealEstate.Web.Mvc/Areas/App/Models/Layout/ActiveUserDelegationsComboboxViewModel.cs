using System.Collections.Generic;
using Homies.RealEstate.Authorization.Delegation;
using Homies.RealEstate.Authorization.Users.Delegation.Dto;

namespace Homies.RealEstate.Web.Areas.App.Models.Layout
{
    public class ActiveUserDelegationsComboboxViewModel
    {
        public IUserDelegationConfiguration UserDelegationConfiguration { get; set; }
        
        public List<UserDelegationDto> UserDelegations { get; set; }
    }
}
