using System.Threading.Tasks;
using Homies.RealEstate.Sessions.Dto;

namespace Homies.RealEstate.Web.Session
{
    public interface IPerRequestSessionCache
    {
        Task<GetCurrentLoginInformationsOutput> GetCurrentLoginInformationsAsync();
    }
}
