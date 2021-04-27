using Homies.RealEstate.Dto;

namespace Homies.RealEstate.WebHooks.Dto
{
    public class GetAllSendAttemptsInput : PagedInputDto
    {
        public string SubscriptionId { get; set; }
    }
}
