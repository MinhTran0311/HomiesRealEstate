using System.ComponentModel.DataAnnotations;

namespace Homies.RealEstate.Authorization.Users.Dto
{
    public class ChangeUserLanguageDto
    {
        [Required]
        public string LanguageName { get; set; }
    }
}
