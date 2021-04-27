using Homies.RealEstate.Editions;
using Homies.RealEstate.Editions.Dto;
using Homies.RealEstate.MultiTenancy.Payments;
using Homies.RealEstate.Security;
using Homies.RealEstate.MultiTenancy.Payments.Dto;

namespace Homies.RealEstate.Web.Models.TenantRegistration
{
    public class TenantRegisterViewModel
    {
        public PasswordComplexitySetting PasswordComplexitySetting { get; set; }

        public int? EditionId { get; set; }

        public SubscriptionStartType? SubscriptionStartType { get; set; }

        public EditionSelectDto Edition { get; set; }

        public EditionPaymentType EditionPaymentType { get; set; }
    }
}
