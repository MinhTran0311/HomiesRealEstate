using Abp.Events.Bus;

namespace Homies.RealEstate.MultiTenancy
{
    public class RecurringPaymentsEnabledEventData : EventData
    {
        public int TenantId { get; set; }
    }
}