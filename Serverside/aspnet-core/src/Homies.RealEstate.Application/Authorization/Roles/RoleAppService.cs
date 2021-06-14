using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Threading.Tasks;
using Abp.Application.Services.Dto;
using Abp.Authorization;
using Abp.Zero.Configuration;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Homies.RealEstate.Authorization.Permissions;
using Homies.RealEstate.Authorization.Permissions.Dto;
using Homies.RealEstate.Authorization.Roles.Dto;
using Homies.RealEstate.Authorization.Users.Profile.Dto;
using Homies.RealEstate.Authorization.Users.Dto;
using Abp.Domain.Repositories;
using Abp.Authorization.Users;

namespace Homies.RealEstate.Authorization.Roles
{
    /// <summary>
    /// Application service that is used by 'role management' page.
    /// </summary>
    [AbpAuthorize]
    public class RoleAppService : RealEstateAppServiceBase, IRoleAppService
    {
        private readonly RoleManager _roleManager;
        private readonly IRoleManagementConfig _roleManagementConfig;
        private readonly IRepository<UserRole, long> _userRoleRepository;

        public RoleAppService(
            RoleManager roleManager,
            IRoleManagementConfig roleManagementConfig,
            IRepository<UserRole, long> userRoleRepository)
        {
            _roleManager = roleManager;
            _roleManagementConfig = roleManagementConfig;
            _userRoleRepository = userRoleRepository;
        }

        [HttpPost]
        public async Task<ListResultDto<RoleListDto>> GetRoles(GetRolesInput input)
        {
            var query = _roleManager.Roles;

            if (input.Permissions != null && input.Permissions.Any(p => !string.IsNullOrEmpty(p)))
            {
                input.Permissions = input.Permissions.Where(p => !string.IsNullOrEmpty(p)).ToList();

                var staticRoleNames = _roleManagementConfig.StaticRoles.Where(
                    r => r.GrantAllPermissionsByDefault &&
                         r.Side == AbpSession.MultiTenancySide
                ).Select(r => r.RoleName).ToList();

                foreach (var permission in input.Permissions)
                {
                    query = query.Where(r =>
                        r.Permissions.Any(rp => rp.Name == permission)
                            ? r.Permissions.Any(rp => rp.Name == permission && rp.IsGranted)
                            : staticRoleNames.Contains(r.Name)
                    );
                }
            }

            var roles = await query.ToListAsync();

            return new ListResultDto<RoleListDto>(ObjectMapper.Map<List<RoleListDto>>(roles));
        }

        [AbpAuthorize(AppPermissions.Pages_Administration_Roles_Create, AppPermissions.Pages_Administration_Roles_Edit)]
        public async Task<GetRoleForEditOutput> GetRoleForEdit(NullableIdDto input)
        {
            var permissions = PermissionManager.GetAllPermissions();
            var grantedPermissions = new Permission[0];
            RoleEditDto roleEditDto;

            if (input.Id.HasValue) //Editing existing role?
            {
                var role = await _roleManager.GetRoleByIdAsync(input.Id.Value);
                grantedPermissions = (await _roleManager.GetGrantedPermissionsAsync(role)).ToArray();
                roleEditDto = ObjectMapper.Map<RoleEditDto>(role);
            }
            else
            {
                roleEditDto = new RoleEditDto();
            }

            return new GetRoleForEditOutput
            {
                Role = roleEditDto,
                Permissions = ObjectMapper.Map<List<FlatPermissionDto>>(permissions).OrderBy(p => p.DisplayName).ToList(),
                GrantedPermissionNames = grantedPermissions.Select(p => p.Name).ToList()
            };
        }

        public async Task<GetRoleForViewOutput> GetRoleForView(NullableIdDto input)
        {
            var user = await GetCurrentUserAsync();
            var userRole = await GetCurrentUserRole();

            var permissions = PermissionManager.GetAllPermissions();
            var grantedPermissions = new Permission[0];

            var grantedPermission = new List<Permission>();
            //var role = await _roleManager.GetRoleByIdAsync(userRole[0].RoleId);
            //grantedPermissions = (await _roleManager.GetGrantedPermissionsAsync(role)).ToArray();

            for (int i = 0; i < userRole.Count; i++)
            {
                var idvRole = await _roleManager.GetRoleByIdAsync(userRole[i].RoleId);
                
                grantedPermission.AddRange((List<Permission>)await _roleManager.GetGrantedPermissionsAsync(idvRole));
            }
            grantedPermissions = grantedPermission.ToArray();
            return new GetRoleForViewOutput
            {
                Role = userRole,
                //Permissions = ObjectMapper.Map<List<FlatPermissionDto>>(permissions).OrderBy(p => p.DisplayName).ToList(),
                GrantedPermissionNames = grantedPermissions.Select(p => p.Name).ToList()
            };
        }

        //Get Role of current user
        private async Task<CurrentUserProfileEditDto> GetCurrentUserProfileForEdit()
        {
            var user = await GetCurrentUserAsync();

            var userProfileEditDto = ObjectMapper.Map<CurrentUserProfileEditDto>(user);

            userProfileEditDto.UserId = user.Id;

            await FillRoleNames(userProfileEditDto);


            return userProfileEditDto;
        }

        private async Task<List<UserListRoleDto>> GetCurrentUserRole()
        {
            var userProfile = await GetCurrentUserProfileForEdit();
            return userProfile.Roles;
        }

        private async Task FillRoleNames(CurrentUserProfileEditDto userListDto)
        {
            /* This method is optimized to fill role names to given list. */
            var userIds = userListDto.UserId;

            var userRoles = await _userRoleRepository.GetAll()
                .Where(userRole => userIds.Equals(userRole.UserId))
                .Select(userRole => userRole).ToListAsync();

            var distinctRoleIds = userRoles.Select(userRole => userRole.RoleId).Distinct();

            var rolesOfUser = userRoles.Where(userRole => userRole.UserId == userListDto.UserId).ToList();
            userListDto.Roles = ObjectMapper.Map<List<UserListRoleDto>>(rolesOfUser);

            var roleNames = new Dictionary<int, string>();
            var roleDisplayNames = new Dictionary<int, string>();

            foreach (var roleId in distinctRoleIds)
            {
                var role = await _roleManager.FindByIdAsync(roleId.ToString());
                if (role != null)
                {
                    roleNames[roleId] = role.Name;
                    roleDisplayNames[roleId] = role.DisplayName;

                }
            }

            foreach (var userListRoleDto in userListDto.Roles)
            {
                if (roleNames.ContainsKey(userListRoleDto.RoleId))
                {
                    userListRoleDto.RoleName = roleNames[userListRoleDto.RoleId];
                    userListRoleDto.RoleDisplayName = roleDisplayNames[userListRoleDto.RoleId];
                }
            }
            userListDto.Roles = userListDto.Roles.Where(r => r.RoleName != null).OrderBy(r => r.RoleName).ToList();
        }
        [AbpAuthorize(AppPermissions.Pages_Administration_Roles)]
        public async Task CreateOrUpdateRole(CreateOrUpdateRoleInput input)
        {
            if (input.Role.Id.HasValue)
            {
                await UpdateRoleAsync(input);
            }
            else
            {
                await CreateRoleAsync(input);
            }
        }

        [AbpAuthorize(AppPermissions.Pages_Administration_Roles_Delete)]
        public async Task DeleteRole(EntityDto input)
        {
            var role = await _roleManager.GetRoleByIdAsync(input.Id);

            var users = await UserManager.GetUsersInRoleAsync(role.Name);
            foreach (var user in users)
            {
                CheckErrors(await UserManager.RemoveFromRoleAsync(user, role.Name));
            }

            CheckErrors(await _roleManager.DeleteAsync(role));
        }

        [AbpAuthorize(AppPermissions.Pages_Administration_Roles_Edit)]
        protected virtual async Task UpdateRoleAsync(CreateOrUpdateRoleInput input)
        {
            Debug.Assert(input.Role.Id != null, "input.Role.Id should be set.");

            var role = await _roleManager.GetRoleByIdAsync(input.Role.Id.Value);
            role.DisplayName = input.Role.DisplayName;
            role.IsDefault = input.Role.IsDefault;
            //role.Name = input.Role.Name;

            await UpdateGrantedPermissionsAsync(role, input.GrantedPermissionNames);
        }

        [AbpAuthorize(AppPermissions.Pages_Administration_Roles_Create)]
        protected virtual async Task CreateRoleAsync(CreateOrUpdateRoleInput input)
        {
            var role = new Role(AbpSession.TenantId, input.Role.DisplayName) { IsDefault = input.Role.IsDefault };
            CheckErrors(await _roleManager.CreateAsync(role));
            await CurrentUnitOfWork.SaveChangesAsync(); //It's done to get Id of the role.
            await UpdateGrantedPermissionsAsync(role, input.GrantedPermissionNames);
        }

        private async Task UpdateGrantedPermissionsAsync(Role role, List<string> grantedPermissionNames)
        {
            var grantedPermissions = PermissionManager.GetPermissionsFromNamesByValidating(grantedPermissionNames);
            await _roleManager.SetGrantedPermissionsAsync(role, grantedPermissions);
        }

        //Get tổng số vai trò
        public async Task<int> CountAllRoles()
        {
            var query = _roleManager.Roles;

            var roleCount = await query.CountAsync();
            return roleCount;
        }
    }
}
