using Homies.RealEstate.MultiTenancy.Payments;

namespace Homies.RealEstate.Web.Models.Payment
{
    public class CancelPaymentModel
    {
        public string PaymentId { get; set; }

        public SubscriptionPaymentGatewayType Gateway { get; set; }
    }
}