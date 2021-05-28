using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Diagnostics;
using System.Linq;
using System.Linq.Dynamic.Core;
using System.Threading.Tasks;
using Abp.Application.Services.Dto;
using Abp.Configuration;
using Abp.Authorization;
using Abp.Authorization.Roles;
using Abp.Authorization.Users;
using Abp.Domain.Repositories;
using Abp.Extensions;
using Abp.Linq.Extensions;
using Abp.Notifications;
using Abp.Organizations;
using Abp.Runtime.Session;
using Abp.UI;
using Abp.Zero.Configuration;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Homies.RealEstate.Authorization.Permissions;
using Homies.RealEstate.Authorization.Permissions.Dto;
using Homies.RealEstate.Authorization.Roles;
using Homies.RealEstate.Authorization.Users.Dto;
using Homies.RealEstate.Authorization.Users.Exporting;
using Homies.RealEstate.Dto;
using Homies.RealEstate.Notifications;
using Homies.RealEstate.Url;
using Homies.RealEstate.Organizations.Dto;
using Homies.RealEstate.Server.Dtos;
using Homies.RealEstate.Server;

namespace Homies.RealEstate.Authorization.Users
{
    [AbpAuthorize(AppPermissions.Pages_Administration_Users)]
    public class UserAppService : RealEstateAppServiceBase, IUserAppService
    {
        public IAppUrlService AppUrlService { get; set; }

        private readonly RoleManager _roleManager;
        private readonly IUserEmailer _userEmailer;
        private readonly IUserListExcelExporter _userListExcelExporter;
        private readonly INotificationSubscriptionManager _notificationSubscriptionManager;
        private readonly IAppNotifier _appNotifier;
        private readonly IRepository<RolePermissionSetting, long> _rolePermissionRepository;
        private readonly IRepository<UserPermissionSetting, long> _userPermissionRepository;
        private readonly IRepository<UserRole, long> _userRoleRepository;
        private readonly IRepository<Role> _roleRepository;
        private readonly IUserPolicy _userPolicy;
        private readonly IEnumerable<IPasswordValidator<User>> _passwordValidators;
        private readonly IPasswordHasher<User> _passwordHasher;
        private readonly IRepository<OrganizationUnit, long> _organizationUnitRepository;
        private readonly IRoleManagementConfig _roleManagementConfig;
        private readonly UserManager _userManager;
        private readonly IRepository<UserOrganizationUnit, long> _userOrganizationUnitRepository;
        private readonly IRepository<OrganizationUnitRole, long> _organizationUnitRoleRepository;
        private readonly IRepository<BaiDang> _baiDangRepository;
        private readonly IRepository<LichSuGiaoDich,Guid> _lichSuGiaoDichRepository;


        public UserAppService(
            RoleManager roleManager,
            IUserEmailer userEmailer,
            IUserListExcelExporter userListExcelExporter,
            INotificationSubscriptionManager notificationSubscriptionManager,
            IAppNotifier appNotifier,
            IRepository<RolePermissionSetting, long> rolePermissionRepository,
            IRepository<UserPermissionSetting, long> userPermissionRepository,
            IRepository<UserRole, long> userRoleRepository,
            IRepository<Role> roleRepository,
            IUserPolicy userPolicy,
            IEnumerable<IPasswordValidator<User>> passwordValidators,
            IPasswordHasher<User> passwordHasher,
            IRepository<OrganizationUnit, long> organizationUnitRepository,
            IRoleManagementConfig roleManagementConfig,
            UserManager userManager,
            IRepository<UserOrganizationUnit, long> userOrganizationUnitRepository,
            IRepository<OrganizationUnitRole, long> organizationUnitRoleRepository,
            IRepository<BaiDang> baiDangRepository,
            IRepository<LichSuGiaoDich, Guid> lichSuGiaoDichRepository)

        {
            _roleManager = roleManager;
            _userEmailer = userEmailer;
            _userListExcelExporter = userListExcelExporter;
            _notificationSubscriptionManager = notificationSubscriptionManager;
            _appNotifier = appNotifier;
            _rolePermissionRepository = rolePermissionRepository;
            _userPermissionRepository = userPermissionRepository;
            _userRoleRepository = userRoleRepository;
            _userPolicy = userPolicy;
            _passwordValidators = passwordValidators;
            _passwordHasher = passwordHasher;
            _organizationUnitRepository = organizationUnitRepository;
            _roleManagementConfig = roleManagementConfig;
            _userManager = userManager;
            _userOrganizationUnitRepository = userOrganizationUnitRepository;
            _organizationUnitRoleRepository = organizationUnitRoleRepository;
            _roleRepository = roleRepository;
            _baiDangRepository = baiDangRepository;
            _lichSuGiaoDichRepository = lichSuGiaoDichRepository;

            AppUrlService = NullAppUrlService.Instance;
        }

        [HttpPost]
        public async Task<PagedResultDto<UserListDto>> GetUsers(GetUsersInput input)
        {
            var query = GetUsersFilteredQuery(input);

            var userCount = await query.CountAsync();

            var users = await query
                .OrderBy(input.Sorting)
                .PageBy(input)
                .ToListAsync();

            var userListDtos = ObjectMapper.Map<List<UserListDto>>(users);
            await FillRoleNames(userListDtos);

            return new PagedResultDto<UserListDto>(
                userCount,
                userListDtos
            );
        }
        //Get số người dùng mới trong tháng
        public async Task<int> CountNewUsersInMonth()
        {
            var query = UserManager.Users
                .Where(e => e.CreationTime.Month == DateTime.Now.Month && e.CreationTime.Year == DateTime.Now.Year);

            var userCount = await query.CountAsync();
            return userCount;

            //var users = await query
            //    .OrderBy(input.Sorting)
            //    .PageBy(input)
            //    .ToListAsync();

            //var userListDtos = ObjectMapper.Map<List<UserListDto>>(users);
            //await FillRoleNames(userListDtos);

            //return new PagedResultDto<UserListDto>(
            //    userCount,
            //    userListDtos
            //);
        }

        //Get tong so nguoi dung
        public async Task<int> CountAllUsers()
        {
            var query = UserManager.Users;

            var userCount = await query.CountAsync();
            return userCount;

            //var users = await query
            //    .OrderBy(input.Sorting)
            //    .PageBy(input)
            //    .ToListAsync();

            //var userListDtos = ObjectMapper.Map<List<UserListDto>>(users);
            //await FillRoleNames(userListDtos);

            //return new PagedResultDto<UserListDto>(
            //    userCount,
            //    userListDtos
            //);
        }

        public async Task<PagedResultDto<YearReportByUser>> GetReportByUser()
        {
            var user = await GetCurrentUserAsync();
            DateTime currentTime = DateTime.Now;
            var filteredtbaidang = _baiDangRepository.GetAll()
                    .Include(e => e.UserFk)
                    //.WhereIf(user.Id != 10, e => e.UserId == user.Id)
                    .Where(e => e.ThoiDiemDang.CompareTo(currentTime.AddYears(-1)) > 0);


            var baiDangs = from o in filteredtbaidang
                           select new GetBaiDangForViewDto()
                           {
                               BaiDang = new BaiDangDto {
                                   ThoiDiemDang = o.ThoiDiemDang,
                                   Id = o.Id,
                                   UserId = o.UserId,
                               },
                               UserName = o.UserFk.UserName,
                           };

            var filteredLSGD = _lichSuGiaoDichRepository.GetAll()
                .Include(e => e.UserFk)
                .Where(e => e.ThoiDiem.CompareTo(currentTime.AddYears(-1)) > 0);
            var lsgds = from o in filteredLSGD
                        select new GetLichSuGiaoDichForViewDto()
                        {
                            LichSuGiaoDich = new LichSuGiaoDichDto
                            {
                                ThoiDiem = o.ThoiDiem,
                                Id = o.Id,
                                UserId = o.UserId,
                                ChiTietHoaDonBaiDangId = o.ChiTietHoaDonBaiDangId,
                                KiemDuyetVienId = o.KiemDuyetVienId,
                                SoTien = o.SoTien
                            }
                        };

            bool isAdmin = user.Id == 2;

            var listBaiDang = await baiDangs.ToListAsync();
            var listLSGD = await lsgds.ToListAsync();
            var monthReport = new List<MothReportDto>();

            List<int> countBaiDang = Enumerable.Repeat(0, 12).ToList();
            List<double> countTienNap = Enumerable.Repeat(0.0, 12).ToList();
            List<double> countTienChi = Enumerable.Repeat(0.0, 12).ToList();


            //Duyệt bài đăng
            for (int i=0; i< listBaiDang.Count; i++)
            {
                if (listBaiDang[i].BaiDang.ThoiDiemDang != DateTime.MinValue)
                    if (!(listBaiDang[i].BaiDang.ThoiDiemDang.Month == currentTime.Month && listBaiDang[i].BaiDang.ThoiDiemDang.Year < currentTime.Year))
                    {
                        if (isAdmin)
                            countBaiDang[listBaiDang[i].BaiDang.ThoiDiemDang.Month - 1]++;
                        else if (!isAdmin)
                            if (listBaiDang[i].BaiDang.UserId == user.Id)
                            countBaiDang[listBaiDang[i].BaiDang.ThoiDiemDang.Month - 1]++;
                    }
                    else continue;
            }

            // Duyệt LSGD
            for (int i = 0; i < listLSGD.Count; i++)
            {
                if (listLSGD[i].LichSuGiaoDich.ThoiDiem != DateTime.MinValue)
                {
                    if (!(listLSGD[i].LichSuGiaoDich.ThoiDiem.Month == currentTime.Month && listLSGD[i].LichSuGiaoDich.ThoiDiem.Year < currentTime.Year))
                    {
                        if (isAdmin)
                        {
                            if (listLSGD[i].LichSuGiaoDich.ChiTietHoaDonBaiDangId != null)
                                countTienChi[listLSGD[i].LichSuGiaoDich.ThoiDiem.Month - 1] += listLSGD[i].LichSuGiaoDich.SoTien;
                            else if (listLSGD[i].LichSuGiaoDich.KiemDuyetVienId != null)
                                countTienNap[listLSGD[i].LichSuGiaoDich.ThoiDiem.Month - 1] += listLSGD[i].LichSuGiaoDich.SoTien;
                        }
                        else if (!isAdmin && listLSGD[i].LichSuGiaoDich.UserId == user.Id)
                        {
                            if (listLSGD[i].LichSuGiaoDich.ChiTietHoaDonBaiDangId != null)
                                countTienChi[listLSGD[i].LichSuGiaoDich.ThoiDiem.Month - 1] += listLSGD[i].LichSuGiaoDich.SoTien;
                            else if (listLSGD[i].LichSuGiaoDich.KiemDuyetVienId != null)
                                countTienNap[listLSGD[i].LichSuGiaoDich.ThoiDiem.Month - 1] += listLSGD[i].LichSuGiaoDich.SoTien;
                        }
                    }
                    else continue;
                }
            }

            for (int i=0; i < 12; i++)
            {
                var month = new MothReportDto() {
                    SoBaiDang = countBaiDang[i],
                    SoTienChi = countTienChi[i],
                    SoTienNap = countTienNap[i],
                    ThangGhiNhan = i + 1,
                    NamGhiNhan = (i + 1) > DateTime.Now.Month ? (DateTime.Now.Year - 1) : DateTime.Now.Year
                };
                monthReport.Add(month);
            }

            List<YearReportByUser> result = new List<YearReportByUser>();
            var report = new YearReportByUser
            {
                YearReport= monthReport,
                UserId = user.Id,
                Username=user.UserName,
            };

            result.Add(report);

            return new PagedResultDto<YearReportByUser>(1, result);


            //return new pagedresultdto<yearreportbyuser>(
            //    usercount,
            //    userlistdtos
            //);
        }

        public async Task<FileDto> GetUsersToExcel(GetUsersToExcelInput input)
        {
            var query = GetUsersFilteredQuery(input);

            var users = await query
                .OrderBy(input.Sorting)
                .ToListAsync();

            var userListDtos = ObjectMapper.Map<List<UserListDto>>(users);
            await FillRoleNames(userListDtos);

            return _userListExcelExporter.ExportToFile(userListDtos);
        }

        [AbpAuthorize(AppPermissions.Pages_Administration_Users_Create, AppPermissions.Pages_Administration_Users_Edit)]
        public async Task<GetUserForEditOutput> GetUserForEdit(NullableIdDto<long> input)
        {
            //Getting all available roles
            var userRoleDtos = await _roleManager.Roles
                .OrderBy(r => r.DisplayName)
                .Select(r => new UserRoleDto
                {
                    RoleId = r.Id,
                    RoleName = r.Name,
                    RoleDisplayName = r.DisplayName
                })
                .ToArrayAsync();

            var allOrganizationUnits = await _organizationUnitRepository.GetAllListAsync();

            var output = new GetUserForEditOutput
            {
                Roles = userRoleDtos,
                AllOrganizationUnits = ObjectMapper.Map<List<OrganizationUnitDto>>(allOrganizationUnits),
                MemberedOrganizationUnits = new List<string>()
            };

            if (!input.Id.HasValue)
            {
                //Creating a new user
                output.User = new UserEditDto
                {
                    IsActive = true,
                    ShouldChangePasswordOnNextLogin = true,
                    IsTwoFactorEnabled =
                        await SettingManager.GetSettingValueAsync<bool>(AbpZeroSettingNames.UserManagement
                            .TwoFactorLogin.IsEnabled),
                    IsLockoutEnabled =
                        await SettingManager.GetSettingValueAsync<bool>(AbpZeroSettingNames.UserManagement.UserLockOut
                            .IsEnabled)
                };

                foreach (var defaultRole in await _roleManager.Roles.Where(r => r.IsDefault).ToListAsync())
                {
                    var defaultUserRole = userRoleDtos.FirstOrDefault(ur => ur.RoleName == defaultRole.Name);
                    if (defaultUserRole != null)
                    {
                        defaultUserRole.IsAssigned = true;
                    }
                }
            }
            else
            {
                //Editing an existing user
                var user = await UserManager.GetUserByIdAsync(input.Id.Value);

                output.User = ObjectMapper.Map<UserEditDto>(user);
                output.ProfilePictureId = user.ProfilePictureId;

                var organizationUnits = await UserManager.GetOrganizationUnitsAsync(user);
                output.MemberedOrganizationUnits = organizationUnits.Select(ou => ou.Code).ToList();

                var allRolesOfUsersOrganizationUnits = GetAllRoleNamesOfUsersOrganizationUnits(input.Id.Value);

                foreach (var userRoleDto in userRoleDtos)
                {
                    userRoleDto.IsAssigned = await UserManager.IsInRoleAsync(user, userRoleDto.RoleName);
                    userRoleDto.InheritedFromOrganizationUnit =
                        allRolesOfUsersOrganizationUnits.Contains(userRoleDto.RoleName);
                }
            }

            return output;
        }
        


        private List<string> GetAllRoleNamesOfUsersOrganizationUnits(long userId)
        {
            return (from userOu in _userOrganizationUnitRepository.GetAll()
                join roleOu in _organizationUnitRoleRepository.GetAll() on userOu.OrganizationUnitId equals roleOu
                    .OrganizationUnitId
                join userOuRoles in _roleRepository.GetAll() on roleOu.RoleId equals userOuRoles.Id
                where userOu.UserId == userId
                select userOuRoles.Name).ToList();
        }

        [AbpAuthorize(AppPermissions.Pages_Administration_Users_ChangePermissions)]
        public async Task<GetUserPermissionsForEditOutput> GetUserPermissionsForEdit(EntityDto<long> input)
        {
            var user = await UserManager.GetUserByIdAsync(input.Id);
            var permissions = PermissionManager.GetAllPermissions();
            var grantedPermissions = await UserManager.GetGrantedPermissionsAsync(user);

            return new GetUserPermissionsForEditOutput
            {
                Permissions = ObjectMapper.Map<List<FlatPermissionDto>>(permissions).OrderBy(p => p.DisplayName)
                    .ToList(),
                GrantedPermissionNames = grantedPermissions.Select(p => p.Name).ToList()
            };
        }

        [AbpAuthorize(AppPermissions.Pages_Administration_Users_ChangePermissions)]
        public async Task ResetUserSpecificPermissions(EntityDto<long> input)
        {
            var user = await UserManager.GetUserByIdAsync(input.Id);
            await UserManager.ResetAllPermissionsAsync(user);
        }

        [AbpAuthorize(AppPermissions.Pages_Administration_Users_ChangePermissions)]
        public async Task UpdateUserPermissions(UpdateUserPermissionsInput input)
        {
            var user = await UserManager.GetUserByIdAsync(input.Id);
            var grantedPermissions =
                PermissionManager.GetPermissionsFromNamesByValidating(input.GrantedPermissionNames);
            await UserManager.SetGrantedPermissionsAsync(user, grantedPermissions);
        }

        public async Task CreateOrUpdateUser(CreateOrUpdateUserInput input)
        {
            if (input.User.Id.HasValue)
            {
                await UpdateUserAsync(input);
            }
            else
            {
                await CreateUserAsync(input);
            }
        }

        [AbpAuthorize(AppPermissions.Pages_Administration_Users_Delete)]
        public async Task DeleteUser(EntityDto<long> input)
        {
            if (input.Id == AbpSession.GetUserId())
            {
                throw new UserFriendlyException(L("YouCanNotDeleteOwnAccount"));
            }

            var user = await UserManager.GetUserByIdAsync(input.Id);
            CheckErrors(await UserManager.DeleteAsync(user));
        }

        [AbpAuthorize(AppPermissions.Pages_Administration_Users_Unlock)]
        public async Task UnlockUser(EntityDto<long> input)
        {
            var user = await UserManager.GetUserByIdAsync(input.Id);
            user.Unlock();
        }

        [AbpAuthorize(AppPermissions.Pages_Administration_Users_Edit)]
        protected virtual async Task UpdateUserAsync(CreateOrUpdateUserInput input)
        {
            Debug.Assert(input.User.Id != null, "input.User.Id should be set.");

            var user = await UserManager.FindByIdAsync(input.User.Id.Value.ToString());

            //Update user properties
            ObjectMapper.Map(input.User, user); //Passwords is not mapped (see mapping configuration)

            CheckErrors(await UserManager.UpdateAsync(user));

            if (input.SetRandomPassword)
            {
                var randomPassword = await _userManager.CreateRandomPassword();
                user.Password = _passwordHasher.HashPassword(user, randomPassword);
                input.User.Password = randomPassword;
            }
            else if (!input.User.Password.IsNullOrEmpty())
            {
                await UserManager.InitializeOptionsAsync(AbpSession.TenantId);
                CheckErrors(await UserManager.ChangePasswordAsync(user, input.User.Password));
            }

            //Update roles
            CheckErrors(await UserManager.SetRolesAsync(user, input.AssignedRoleNames));

            //update organization units
            await UserManager.SetOrganizationUnitsAsync(user, input.OrganizationUnits.ToArray());

            if (input.SendActivationEmail)
            {
                user.SetNewEmailConfirmationCode();
                await _userEmailer.SendEmailActivationLinkAsync(
                    user,
                    AppUrlService.CreateEmailActivationUrlFormat(AbpSession.TenantId),
                    input.User.Password
                );
            }
        }

        [AbpAuthorize(AppPermissions.Pages_Administration_Users_Create)]
        protected virtual async Task CreateUserAsync(CreateOrUpdateUserInput input)
        {
            if (AbpSession.TenantId.HasValue)
            {
                await _userPolicy.CheckMaxUserCountAsync(AbpSession.GetTenantId());
            }

            var user = ObjectMapper.Map<User>(input.User); //Passwords is not mapped (see mapping configuration)
            user.TenantId = AbpSession.TenantId;

            //Set password
            if (input.SetRandomPassword)
            {
                var randomPassword = await _userManager.CreateRandomPassword();
                user.Password = _passwordHasher.HashPassword(user, randomPassword);
                input.User.Password = randomPassword;
            }
            else if (!input.User.Password.IsNullOrEmpty())
            {
                await UserManager.InitializeOptionsAsync(AbpSession.TenantId);
                foreach (var validator in _passwordValidators)
                {
                    CheckErrors(await validator.ValidateAsync(UserManager, user, input.User.Password));
                }

                user.Password = _passwordHasher.HashPassword(user, input.User.Password);
            }

            user.ShouldChangePasswordOnNextLogin = input.User.ShouldChangePasswordOnNextLogin;

            //Assign roles
            user.Roles = new Collection<UserRole>();
            foreach (var roleName in input.AssignedRoleNames)
            {
                var role = await _roleManager.GetRoleByNameAsync(roleName);
                user.Roles.Add(new UserRole(AbpSession.TenantId, user.Id, role.Id));
            }

            CheckErrors(await UserManager.CreateAsync(user));
            await CurrentUnitOfWork.SaveChangesAsync(); //To get new user's Id.

            //Notifications
            await _notificationSubscriptionManager.SubscribeToAllAvailableNotificationsAsync(user.ToUserIdentifier());
            await _appNotifier.WelcomeToTheApplicationAsync(user);

            //Organization Units
            await UserManager.SetOrganizationUnitsAsync(user, input.OrganizationUnits.ToArray());

            //Send activation email
            if (input.SendActivationEmail)
            {
                user.SetNewEmailConfirmationCode();
                await _userEmailer.SendEmailActivationLinkAsync(
                    user,
                    AppUrlService.CreateEmailActivationUrlFormat(AbpSession.TenantId),
                    input.User.Password
                );
            }
        }

        private async Task FillRoleNames(IReadOnlyCollection<UserListDto> userListDtos)
        {
            /* This method is optimized to fill role names to given list. */
            var userIds = userListDtos.Select(u => u.Id);

            var userRoles = await _userRoleRepository.GetAll()
                .Where(userRole => userIds.Contains(userRole.UserId))
                .Select(userRole => userRole).ToListAsync();

            var distinctRoleIds = userRoles.Select(userRole => userRole.RoleId).Distinct();

            foreach (var user in userListDtos)
            {
                var rolesOfUser = userRoles.Where(userRole => userRole.UserId == user.Id).ToList();
                user.Roles = ObjectMapper.Map<List<UserListRoleDto>>(rolesOfUser);
            }

            var roleNames = new Dictionary<int, string>();
            foreach (var roleId in distinctRoleIds)
            {
                var role = await _roleManager.FindByIdAsync(roleId.ToString());
                if (role != null)
                {
                    roleNames[roleId] = role.DisplayName;
                }
            }

            foreach (var userListDto in userListDtos)
            {
                foreach (var userListRoleDto in userListDto.Roles)
                {
                    if (roleNames.ContainsKey(userListRoleDto.RoleId))
                    {
                        userListRoleDto.RoleName = roleNames[userListRoleDto.RoleId];
                    }
                }

                userListDto.Roles = userListDto.Roles.Where(r => r.RoleName != null).OrderBy(r => r.RoleName).ToList();
            }
        }

        private IQueryable<User> GetUsersFilteredQuery(IGetUsersInput input)
        {
            var query = UserManager.Users
                .WhereIf(input.Role.HasValue, u => u.Roles.Any(r => r.RoleId == input.Role.Value))
                .WhereIf(input.OnlyLockedUsers,
                    u => u.LockoutEndDateUtc.HasValue && u.LockoutEndDateUtc.Value > DateTime.UtcNow)
                .WhereIf(
                    !input.Filter.IsNullOrWhiteSpace(),
                    u =>
                        u.Name.Contains(input.Filter) ||
                        u.Surname.Contains(input.Filter) ||
                        u.UserName.Contains(input.Filter) ||
                        u.EmailAddress.Contains(input.Filter)
                );

            if (input.Permissions != null && input.Permissions.Any(p => !p.IsNullOrWhiteSpace()))
            {
                var staticRoleNames = _roleManagementConfig.StaticRoles.Where(
                    r => r.GrantAllPermissionsByDefault &&
                         r.Side == AbpSession.MultiTenancySide
                ).Select(r => r.RoleName).ToList();

                input.Permissions = input.Permissions.Where(p => !string.IsNullOrEmpty(p)).ToList();

                var userIds = from user in query
                    join ur in _userRoleRepository.GetAll() on user.Id equals ur.UserId into urJoined
                    from ur in urJoined.DefaultIfEmpty()
                    join urr in _roleRepository.GetAll() on ur.RoleId equals urr.Id into urrJoined
                    from urr in urrJoined.DefaultIfEmpty()
                    join up in _userPermissionRepository.GetAll()
                        .Where(userPermission => input.Permissions.Contains(userPermission.Name)) on user.Id equals up.UserId into upJoined
                    from up in upJoined.DefaultIfEmpty()
                    join rp in _rolePermissionRepository.GetAll()
                        .Where(rolePermission => input.Permissions.Contains(rolePermission.Name)) on
                        new { RoleId = ur == null ? 0 : ur.RoleId } equals new { rp.RoleId } into rpJoined
                    from rp in rpJoined.DefaultIfEmpty()
                    where (up != null && up.IsGranted) ||
                          (up == null && rp != null && rp.IsGranted) ||
                          (up == null && rp == null && staticRoleNames.Contains(urr.Name))
                    group user by user.Id
                    into userGrouped
                    select userGrouped.Key;

                query = UserManager.Users.Where(e => userIds.Contains(e.Id));
            }

            return query;
        }

        [AbpAuthorize]
        public async Task<double> GetCurrentUserWallet()
        {
            var user = await GetCurrentUserAsync();

            return user.Wallet;
        }
    }
}
