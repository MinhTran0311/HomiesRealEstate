using System.Collections.Generic;
using Homies.RealEstate.Editions;
using Homies.RealEstate.Editions.Dto;
using Homies.RealEstate.MultiTenancy.Payments;
using Homies.RealEstate.MultiTenancy.Payments.Dto;

namespace Homies.RealEstate.Web.Models.Payment
{
    public class BuyEditionViewModel
    {
        public SubscriptionStartType? SubscriptionStartType { get; set; }

        public EditionSelectDto Edition { get; set; }

        public decimal? AdditionalPrice { get; set; }

        public EditionPaymentType EditionPaymentType { get; set; }

        public List<PaymentGatewayModel> PaymentGateways { get; set; }
    }
}
