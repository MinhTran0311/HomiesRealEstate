using System.Threading.Tasks;
using Abp.Application.Services;
using Homies.RealEstate.Editions.Dto;
using Homies.RealEstate.MultiTenancy.Dto;

namespace Homies.RealEstate.MultiTenancy
{
    public interface ITenantRegistrationAppService: IApplicationService
    {
        Task<RegisterTenantOutput> RegisterTenant(RegisterTenantInput input);

        Task<EditionsSelectOutput> GetEditionsForSelect();

        Task<EditionSelectDto> GetEdition(int editionId);
    }
}