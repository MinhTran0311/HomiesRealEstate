using System.Threading.Tasks;
using Homies.RealEstate.Security.Recaptcha;

namespace Homies.RealEstate.Test.Base.Web
{
    public class FakeRecaptchaValidator : IRecaptchaValidator
    {
        public Task ValidateAsync(string captchaResponse)
        {
            return Task.CompletedTask;
        }
    }
}
