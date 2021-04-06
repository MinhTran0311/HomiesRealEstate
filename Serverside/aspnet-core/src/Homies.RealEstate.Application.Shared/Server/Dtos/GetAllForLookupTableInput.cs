using Abp.Application.Services.Dto;

namespace Homies.RealEstate.Server.Dtos
{
    public class GetAllForLookupTableInput : PagedAndSortedResultRequestDto
    {
        public string Filter { get; set; }
    }
}