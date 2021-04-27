using System.ComponentModel.DataAnnotations;

namespace Homies.RealEstate.Localization.Dto
{
    public class CreateOrUpdateLanguageInput
    {
        [Required]
        public ApplicationLanguageEditDto Language { get; set; }
    }
}