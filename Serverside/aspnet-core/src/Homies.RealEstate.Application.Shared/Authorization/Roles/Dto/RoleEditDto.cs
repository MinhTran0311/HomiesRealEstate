using System.ComponentModel.DataAnnotations;

namespace Homies.RealEstate.Authorization.Roles.Dto
{
    public class RoleEditDto
    {
        public int? Id { get; set; }

        [Required]
        public string DisplayName { get; set; }

        //public string Name { get; set; }
        
        public bool IsDefault { get; set; }
    }
}