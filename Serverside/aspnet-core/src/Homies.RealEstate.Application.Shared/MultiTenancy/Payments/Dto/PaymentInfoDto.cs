using Homies.RealEstate.Editions.Dto;

namespace Homies.RealEstate.MultiTenancy.Payments.Dto
{
    public class PaymentInfoDto
    {
        public EditionSelectDto Edition { get; set; }

        public decimal AdditionalPrice { get; set; }

        public bool IsLessThanMinimumUpgradePaymentAmount()
        {
            return AdditionalPrice < RealEstateConsts.MinimumUpgradePaymentAmount;
        }
    }
}
