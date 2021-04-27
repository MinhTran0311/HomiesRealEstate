namespace Homies.RealEstate
{
    public class RealEstateConsts
    {
        public const string LocalizationSourceName = "RealEstate";

        public const string ConnectionStringName = "Default";

        public const bool MultiTenancyEnabled = false;

        public const bool AllowTenantsToChangeEmailSettings = false;

        public const string Currency = "Đồng";

        public const string CurrencySign = "Đ";

        public const string AbpApiClientUserAgent = "AbpApiClient";

        // Note:
        // Minimum accepted payment amount. If a payment amount is less then that minimum value payment progress will continue without charging payment
        // Even though we can use multiple payment methods, users always can go and use the highest accepted payment amount.
        //For example, you use Stripe and PayPal. Let say that stripe accepts min 5$ and PayPal accepts min 3$. If your payment amount is 4$.
        // User will prefer to use a payment method with the highest accept value which is a Stripe in this case.
        public const decimal MinimumUpgradePaymentAmount = 1M;
    }
}
