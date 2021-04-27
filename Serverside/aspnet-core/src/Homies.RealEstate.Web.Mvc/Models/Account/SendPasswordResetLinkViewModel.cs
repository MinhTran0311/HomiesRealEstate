using System.ComponentModel.DataAnnotations;

namespace Homies.RealEstate.Web.Models.Account
{
    public class SendPasswordResetLinkViewModel
    {
        [Required]
        public string EmailAddress { get; set; }
    }
}