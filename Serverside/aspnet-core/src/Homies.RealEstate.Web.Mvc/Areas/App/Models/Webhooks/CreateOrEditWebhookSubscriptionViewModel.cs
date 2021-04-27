using Abp.Application.Services.Dto;
using Abp.Webhooks;
using Homies.RealEstate.WebHooks.Dto;

namespace Homies.RealEstate.Web.Areas.App.Models.Webhooks
{
    public class CreateOrEditWebhookSubscriptionViewModel
    {
        public WebhookSubscription WebhookSubscription { get; set; }

        public ListResultDto<GetAllAvailableWebhooksOutput> AvailableWebhookEvents { get; set; }
    }
}
