using System.Threading.Tasks;
using Abp.Application.Services;
using Homies.RealEstate.MultiTenancy.Payments.PayPal.Dto;

namespace Homies.RealEstate.MultiTenancy.Payments.PayPal
{
    public interface IPayPalPaymentAppService : IApplicationService
    {
        Task ConfirmPayment(long paymentId, string paypalOrderId);

        PayPalConfigurationDto GetConfiguration();
    }
}
