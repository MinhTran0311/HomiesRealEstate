﻿using System.Collections.Generic;
using Homies.RealEstate.Editions.Dto;
using Homies.RealEstate.MultiTenancy.Payments;

namespace Homies.RealEstate.Web.Models.Payment
{
    public class UpgradeEditionViewModel
    {
        public EditionSelectDto Edition { get; set; }

        public PaymentPeriodType PaymentPeriodType { get; set; }

        public SubscriptionPaymentType SubscriptionPaymentType { get; set; }

        public decimal? AdditionalPrice { get; set; }

        public List<PaymentGatewayModel> PaymentGateways { get; set; }
    }
}