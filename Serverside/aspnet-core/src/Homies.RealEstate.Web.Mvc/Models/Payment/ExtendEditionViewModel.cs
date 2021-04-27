using System.Collections.Generic;
using Homies.RealEstate.Editions.Dto;
using Homies.RealEstate.MultiTenancy.Payments;

namespace Homies.RealEstate.Web.Models.Payment
{
    public class ExtendEditionViewModel
    {
        public EditionSelectDto Edition { get; set; }

        public List<PaymentGatewayModel> PaymentGateways { get; set; }
    }
}