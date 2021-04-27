using System.Threading.Tasks;
using Abp.Application.Services;
using Homies.RealEstate.Sessions.Dto;

namespace Homies.RealEstate.Sessions
{
    public interface ISessionAppService : IApplicationService
    {
        Task<GetCurrentLoginInformationsOutput> GetCurrentLoginInformations();

        Task<UpdateUserSignInTokenOutput> UpdateUserSignInToken();
    }
}
