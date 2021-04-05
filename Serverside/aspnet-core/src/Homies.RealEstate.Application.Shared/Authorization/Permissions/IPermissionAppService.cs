using Abp.Application.Services;
using Abp.Application.Services.Dto;
using Homies.RealEstate.Authorization.Permissions.Dto;

namespace Homies.RealEstate.Authorization.Permissions
{
    public interface IPermissionAppService : IApplicationService
    {
        ListResultDto<FlatPermissionWithLevelDto> GetAllPermissions();
    }
}
