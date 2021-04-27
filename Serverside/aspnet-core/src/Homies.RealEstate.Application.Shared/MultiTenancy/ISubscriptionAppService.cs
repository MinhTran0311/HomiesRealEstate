using System.Threading.Tasks;
using Abp.Application.Services;

namespace Homies.RealEstate.MultiTenancy
{
    public interface ISubscriptionAppService : IApplicationService
    {
        Task DisableRecurringPayments();

        Task EnableRecurringPayments();
    }
}
