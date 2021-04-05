using System.Collections.Generic;
using Homies.RealEstate.Authorization.Users.Dto;

namespace Homies.RealEstate.Web.Areas.App.Models.Users
{
    public class UserLoginAttemptModalViewModel
    {
        public List<UserLoginAttemptDto> LoginAttempts { get; set; }
    }
}