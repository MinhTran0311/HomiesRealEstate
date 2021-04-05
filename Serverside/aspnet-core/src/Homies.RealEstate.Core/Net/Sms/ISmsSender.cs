using System.Threading.Tasks;

namespace Homies.RealEstate.Net.Sms
{
    public interface ISmsSender
    {
        Task SendAsync(string number, string message);
    }
}