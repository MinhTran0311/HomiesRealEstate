using System.Threading.Tasks;
using Homies.RealEstate.Authorization.Users;

namespace Homies.RealEstate.WebHooks
{
    public interface IAppWebhookPublisher
    {
        Task PublishTestWebhook();
    }
}
