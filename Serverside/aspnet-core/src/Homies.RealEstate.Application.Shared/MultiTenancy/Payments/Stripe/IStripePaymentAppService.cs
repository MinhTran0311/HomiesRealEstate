using System.Threading.Tasks;
using Abp.Application.Services;
using Homies.RealEstate.MultiTenancy.Payments.Dto;
using Homies.RealEstate.MultiTenancy.Payments.Stripe.Dto;

namespace Homies.RealEstate.MultiTenancy.Payments.Stripe
{
    public interface IStripePaymentAppService : IApplicationService
    {
        Task ConfirmPayment(StripeConfirmPaymentInput input);

        StripeConfigurationDto GetConfiguration();

        Task<SubscriptionPaymentDto> GetPaymentAsync(StripeGetPaymentInput input);

        Task<string> CreatePaymentSession(StripeCreatePaymentSessionInput input);
    }
}