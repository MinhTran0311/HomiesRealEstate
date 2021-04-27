using System.Threading.Tasks;
using Abp.Webhooks;

namespace Homies.RealEstate.WebHooks
{
    public interface IWebhookEventAppService
    {
        Task<WebhookEvent> Get(string id);
    }
}
