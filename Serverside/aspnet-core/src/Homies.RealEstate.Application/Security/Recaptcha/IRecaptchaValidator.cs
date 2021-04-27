using System.Threading.Tasks;

namespace Homies.RealEstate.Security.Recaptcha
{
    public interface IRecaptchaValidator
    {
        Task ValidateAsync(string captchaResponse);
    }
}