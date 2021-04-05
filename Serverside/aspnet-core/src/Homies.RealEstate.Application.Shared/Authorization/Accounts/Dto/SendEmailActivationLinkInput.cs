using System.ComponentModel.DataAnnotations;

namespace Homies.RealEstate.Authorization.Accounts.Dto
{
    public class SendEmailActivationLinkInput
    {
        [Required]
        public string EmailAddress { get; set; }
    }
}