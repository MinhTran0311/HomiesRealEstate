﻿using Abp.Authorization.Users;
using Abp.Domain.Repositories;
using Abp.Domain.Uow;
using Abp.Linq;
using Abp.Organizations;
using Homies.RealEstate.Authorization.Roles;

namespace Homies.RealEstate.Authorization.Users
{
    /// <summary>
    /// Used to perform database operations for <see cref="UserManager"/>.
    /// </summary>
    public class UserStore : AbpUserStore<Role, User>
    {
        public UserStore(
            IRepository<User, long> userRepository,
            IRepository<UserLogin, long> userLoginRepository,
            IRepository<UserRole, long> userRoleRepository,
            IRepository<Role> roleRepository,
            IUnitOfWorkManager unitOfWorkManager,
            IRepository<UserClaim, long> userClaimRepository,
            IRepository<UserPermissionSetting, long> userPermissionSettingRepository,
            IRepository<UserOrganizationUnit, long> userOrganizationUnitRepository,
            IRepository<OrganizationUnitRole, long> organizationUnitRoleRepository)
            : base(
                unitOfWorkManager,
                userRepository,
                roleRepository,
                userRoleRepository,
                userLoginRepository,
                userClaimRepository,
                userPermissionSettingRepository,
                userOrganizationUnitRepository,
                organizationUnitRoleRepository)
        {
        }
    }
}
