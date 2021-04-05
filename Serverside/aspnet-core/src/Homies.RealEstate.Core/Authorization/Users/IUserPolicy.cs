using System.Threading.Tasks;
using Abp.Domain.Policies;

namespace Homies.RealEstate.Authorization.Users
{
    public interface IUserPolicy : IPolicy
    {
        Task CheckMaxUserCountAsync(int tenantId);
    }
}
