﻿using System;
using System.Drawing;
using System.IO;
using System.Threading.Tasks;
using Abp;
using Abp.Auditing;
using Abp.Authorization;
using Abp.BackgroundJobs;
using Abp.Configuration;
using Abp.Extensions;
using Abp.Localization;
using Abp.Runtime.Caching;
using Abp.Runtime.Session;
using Abp.Timing;
using Abp.UI;
using Abp.Zero.Configuration;
using Microsoft.AspNetCore.Identity;
using Homies.RealEstate.Authentication.TwoFactor.Google;
using Homies.RealEstate.Authorization.Users.Dto;
using Homies.RealEstate.Authorization.Users.Profile.Cache;
using Homies.RealEstate.Authorization.Users.Profile.Dto;
using Homies.RealEstate.Configuration;
using Homies.RealEstate.Friendships;
using Homies.RealEstate.Gdpr;
using Homies.RealEstate.Net.Sms;
using Homies.RealEstate.Security;
using Homies.RealEstate.Storage;
using Homies.RealEstate.Timing;
using System.Collections.Generic;
using Abp.Domain.Repositories;
using Abp.Authorization.Users;
using Homies.RealEstate.Authorization.Roles;
using System.Linq;
using Microsoft.EntityFrameworkCore;

namespace Homies.RealEstate.Authorization.Users.Profile
{
    [AbpAllowAnonymous]
    public class ProfileAppService : RealEstateAppServiceBase, IProfileAppService
    {
        private const int MaxProfilPictureBytes = 5242880; //5MB
        private readonly IBinaryObjectManager _binaryObjectManager;
        private readonly ITimeZoneService _timeZoneService;
        private readonly IFriendshipManager _friendshipManager;
        private readonly GoogleTwoFactorAuthenticateService _googleTwoFactorAuthenticateService;
        private readonly ISmsSender _smsSender;
        private readonly ICacheManager _cacheManager;
        private readonly ITempFileCacheManager _tempFileCacheManager;
        private readonly IBackgroundJobManager _backgroundJobManager;
        private readonly ProfileImageServiceFactory _profileImageServiceFactory;
        private readonly IRepository<UserRole, long> _userRoleRepository;
        private readonly RoleManager _roleManager;


        public ProfileAppService(
            IAppFolders appFolders,
            IBinaryObjectManager binaryObjectManager,
            ITimeZoneService timezoneService,
            IFriendshipManager friendshipManager,
            GoogleTwoFactorAuthenticateService googleTwoFactorAuthenticateService,
            ISmsSender smsSender,
            ICacheManager cacheManager,
            ITempFileCacheManager tempFileCacheManager,
            IBackgroundJobManager backgroundJobManager,
            ProfileImageServiceFactory profileImageServiceFactory,
            IRepository<UserRole, long> userRoleRepository,
            RoleManager roleManager)
        {
            _binaryObjectManager = binaryObjectManager;
            _timeZoneService = timezoneService;
            _friendshipManager = friendshipManager;
            _googleTwoFactorAuthenticateService = googleTwoFactorAuthenticateService;
            _smsSender = smsSender;
            _cacheManager = cacheManager;
            _tempFileCacheManager = tempFileCacheManager;
            _backgroundJobManager = backgroundJobManager;
            _profileImageServiceFactory = profileImageServiceFactory;
            _userRoleRepository = userRoleRepository;
            _roleManager = roleManager;
        }

        [DisableAuditing]
        public async Task<CurrentUserProfileEditDto> GetCurrentUserProfileForEdit()
        {
            var user = await GetCurrentUserAsync();

            var userProfileEditDto = ObjectMapper.Map<CurrentUserProfileEditDto>(user);

            userProfileEditDto.QrCodeSetupImageUrl = user.GoogleAuthenticatorKey != null
                ? _googleTwoFactorAuthenticateService.GenerateSetupCode("Homies.RealEstate",
                    user.EmailAddress, user.GoogleAuthenticatorKey, 300, 300).QrCodeSetupImageUrl
                : "";
            userProfileEditDto.IsGoogleAuthenticatorEnabled = user.GoogleAuthenticatorKey != null;

            userProfileEditDto.UserId = user.Id;

            if (Clock.SupportsMultipleTimezone)
            {
                userProfileEditDto.Timezone = await SettingManager.GetSettingValueAsync(TimingSettingNames.TimeZone);

                var defaultTimeZoneId =
                    await _timeZoneService.GetDefaultTimezoneAsync(SettingScopes.User, AbpSession.TenantId);
                if (userProfileEditDto.Timezone == defaultTimeZoneId)
                {
                    userProfileEditDto.Timezone = string.Empty;
                }
            }
            await FillRoleNames(userProfileEditDto);


            return userProfileEditDto;
        }

        public async Task<List<UserListRoleDto>> GetCurrentUserRole()
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

                    //userListRoleDto.RoleName = roleNames[userListRoleDto.RoleId];
                }
            }

            userListDto.Roles = userListDto.Roles.Where(r => r.RoleName != null).OrderBy(r => r.RoleName).ToList();
            
        }

        public async Task DisableGoogleAuthenticator()
        {
            var user = await GetCurrentUserAsync();
            user.GoogleAuthenticatorKey = null;
        }

        public async Task<UpdateGoogleAuthenticatorKeyOutput> UpdateGoogleAuthenticatorKey()
        {
            var user = await GetCurrentUserAsync();
            user.GoogleAuthenticatorKey = Guid.NewGuid().ToString().Replace("-", "").Substring(0, 10);
            CheckErrors(await UserManager.UpdateAsync(user));

            return new UpdateGoogleAuthenticatorKeyOutput
            {
                QrCodeSetupImageUrl = _googleTwoFactorAuthenticateService.GenerateSetupCode(
                    "Homies.RealEstate",
                    user.EmailAddress, user.GoogleAuthenticatorKey, 300, 300).QrCodeSetupImageUrl
            };
        }

        public async Task SendVerificationSms(SendVerificationSmsInputDto input)
        {
            var code = RandomHelper.GetRandom(100000, 999999).ToString();
            var cacheKey = AbpSession.ToUserIdentifier().ToString();
            var cacheItem = new SmsVerificationCodeCacheItem {Code = code};

            _cacheManager.GetSmsVerificationCodeCache().Set(
                cacheKey,
                cacheItem
            );

            await _smsSender.SendAsync(input.PhoneNumber, L("SmsVerificationMessage", code));
        }

        public async Task VerifySmsCode(VerifySmsCodeInputDto input)
        {
            var cacheKey = AbpSession.ToUserIdentifier().ToString();
            var cash = await _cacheManager.GetSmsVerificationCodeCache().GetOrDefaultAsync(cacheKey);

            if (cash == null)
            {
                throw new Exception("Phone number confirmation code is not found in cache !");
            }

            if (input.Code != cash.Code)
            {
                throw new UserFriendlyException(L("WrongSmsVerificationCode"));
            }

            var user = await UserManager.GetUserAsync(AbpSession.ToUserIdentifier());
            user.IsPhoneNumberConfirmed = true;
            user.PhoneNumber = input.PhoneNumber;
            await UserManager.UpdateAsync(user);
        }

        public async Task PrepareCollectedData()
        {
            await _backgroundJobManager.EnqueueAsync<UserCollectedDataPrepareJob, UserIdentifier>(
                AbpSession.ToUserIdentifier());
        }

        public async Task UpdateCurrentUserProfile(CurrentUserProfileEditDto input)
        {
            var user = await GetCurrentUserAsync();

            if (user.PhoneNumber != input.PhoneNumber)
            {
                input.IsPhoneNumberConfirmed = false;
            }
            else if (user.IsPhoneNumberConfirmed)
            {
                input.IsPhoneNumberConfirmed = true;
            }

            ObjectMapper.Map(input, user);
            CheckErrors(await UserManager.UpdateAsync(user));

            if (Clock.SupportsMultipleTimezone)
            {
                if (input.Timezone.IsNullOrEmpty())
                {
                    var defaultValue =
                        await _timeZoneService.GetDefaultTimezoneAsync(SettingScopes.User, AbpSession.TenantId);
                    await SettingManager.ChangeSettingForUserAsync(AbpSession.ToUserIdentifier(),
                        TimingSettingNames.TimeZone, defaultValue);
                }
                else
                {
                    await SettingManager.ChangeSettingForUserAsync(AbpSession.ToUserIdentifier(),
                        TimingSettingNames.TimeZone, input.Timezone);
                }
            }
        }

        public async Task ChangePassword(ChangePasswordInput input)
        {
            await UserManager.InitializeOptionsAsync(AbpSession.TenantId);

            var user = await GetCurrentUserAsync();
            if (await UserManager.CheckPasswordAsync(user, input.CurrentPassword))
            {
                CheckErrors(await UserManager.ChangePasswordAsync(user, input.NewPassword));
            }
            else
            {
                CheckErrors(IdentityResult.Failed(new IdentityError
                {
                    Description = "Incorrect password."
                }));
            }
        }

        public async Task UpdateProfilePicture(UpdateProfilePictureInput input)
        {
            await SettingManager.ChangeSettingForUserAsync(
                AbpSession.ToUserIdentifier(),
                AppSettings.UserManagement.UseGravatarProfilePicture,
                input.UseGravatarProfilePicture.ToString().ToLowerInvariant()
            );

            if (input.UseGravatarProfilePicture)
            {
                return;
            }

            byte[] byteArray;

            var imageBytes = _tempFileCacheManager.GetFile(input.FileToken);

            if (imageBytes == null)
            {
                throw new UserFriendlyException("There is no such image file with the token: " + input.FileToken);
            }

            using (var bmpImage = new Bitmap(new MemoryStream(imageBytes)))
            {
                var width = (input.Width == 0 || input.Width > bmpImage.Width) ? bmpImage.Width : input.Width;
                var height = (input.Height == 0 || input.Height > bmpImage.Height) ? bmpImage.Height : input.Height;
                var bmCrop = bmpImage.Clone(new Rectangle(input.X, input.Y, width, height), bmpImage.PixelFormat);

                using (var stream = new MemoryStream())
                {
                    bmCrop.Save(stream, bmpImage.RawFormat);
                    byteArray = stream.ToArray();
                }
            }

            if (byteArray.Length > MaxProfilPictureBytes)
            {
                throw new UserFriendlyException(L("ResizedProfilePicture_Warn_SizeLimit",
                    AppConsts.ResizedMaxProfilPictureBytesUserFriendlyValue));
            }

            var user = await UserManager.GetUserByIdAsync(AbpSession.GetUserId());

            if (user.ProfilePictureId.HasValue)
            {
                await _binaryObjectManager.DeleteAsync(user.ProfilePictureId.Value);
            }

            var storedFile = new BinaryObject(AbpSession.TenantId, byteArray, $"Profile picture of user {AbpSession.UserId}. {DateTime.UtcNow}");
            await _binaryObjectManager.SaveAsync(storedFile);

            user.ProfilePictureId = storedFile.Id;
        }

        [AbpAllowAnonymous]
        public async Task<GetPasswordComplexitySettingOutput> GetPasswordComplexitySetting()
        {
            var passwordComplexitySetting = new PasswordComplexitySetting
            {
                RequireDigit =
                    await SettingManager.GetSettingValueAsync<bool>(AbpZeroSettingNames.UserManagement
                        .PasswordComplexity.RequireDigit),
                RequireLowercase =
                    await SettingManager.GetSettingValueAsync<bool>(AbpZeroSettingNames.UserManagement
                        .PasswordComplexity.RequireLowercase),
                RequireNonAlphanumeric =
                    await SettingManager.GetSettingValueAsync<bool>(AbpZeroSettingNames.UserManagement
                        .PasswordComplexity.RequireNonAlphanumeric),
                RequireUppercase =
                    await SettingManager.GetSettingValueAsync<bool>(AbpZeroSettingNames.UserManagement
                        .PasswordComplexity.RequireUppercase),
                RequiredLength =
                    await SettingManager.GetSettingValueAsync<int>(AbpZeroSettingNames.UserManagement.PasswordComplexity
                        .RequiredLength)
            };

            return new GetPasswordComplexitySettingOutput
            {
                Setting = passwordComplexitySetting
            };
        }

        [DisableAuditing]
        public async Task<GetProfilePictureOutput> GetProfilePicture()
        {
            using (var profileImageService = await _profileImageServiceFactory.Get(AbpSession.ToUserIdentifier()))
            {
                var profilePictureContent = await profileImageService.Object.GetProfilePictureContentForUser(
                    AbpSession.ToUserIdentifier()
                );
                
                return new GetProfilePictureOutput(profilePictureContent);
            }
        }

        [AbpAllowAnonymous]
        public async Task<GetProfilePictureOutput> GetProfilePictureByUserName(string username)
        {
            var user = await UserManager.FindByNameAsync(username);
            if (user == null)
            {
                return new GetProfilePictureOutput(string.Empty);
            }
            
            var userIdentifier = new UserIdentifier(AbpSession.TenantId, user.Id);
            using (var profileImageService = await _profileImageServiceFactory.Get(userIdentifier))
            {
                var profileImage = await profileImageService.Object.GetProfilePictureContentForUser(userIdentifier);
                return new GetProfilePictureOutput(profileImage);
            }
        }

        public async Task<GetProfilePictureOutput> GetFriendProfilePicture(GetFriendProfilePictureInput input)
        {
            var friendUserIdentifier = input.ToUserIdentifier();
            var friendShip = await _friendshipManager.GetFriendshipOrNullAsync(
                AbpSession.ToUserIdentifier(),
                friendUserIdentifier
            );

            if (friendShip == null)
            {
                return new GetProfilePictureOutput(string.Empty);
            }

            
            using (var profileImageService = await _profileImageServiceFactory.Get(friendUserIdentifier))
            {
                var image = await profileImageService.Object.GetProfilePictureContentForUser(friendUserIdentifier);
                return new GetProfilePictureOutput(image);
            }
        }

        [AbpAllowAnonymous]
        public async Task<GetProfilePictureOutput> GetProfilePictureByUser(long userId)
        {
            var userIdentifier = new UserIdentifier(AbpSession.TenantId, userId);
            using (var profileImageService = await _profileImageServiceFactory.Get(userIdentifier))
            {
                var profileImage = await profileImageService.Object.GetProfilePictureContentForUser(userIdentifier);
                return new GetProfilePictureOutput(profileImage);
            }
        }

        public async Task ChangeLanguage(ChangeUserLanguageDto input)
        {
            await SettingManager.ChangeSettingForUserAsync(
                AbpSession.ToUserIdentifier(),
                LocalizationSettingNames.DefaultLanguage,
                input.LanguageName
            );
        }

        private async Task<byte[]> GetProfilePictureByIdOrNull(Guid profilePictureId)
        {
            var file = await _binaryObjectManager.GetOrNullAsync(profilePictureId);
            if (file == null)
            {
                return null;
            }

            return file.Bytes;
        }

        private async Task<GetProfilePictureOutput> GetProfilePictureByIdInternal(Guid profilePictureId)
        {
            var bytes = await GetProfilePictureByIdOrNull(profilePictureId);
            if (bytes == null)
            {
                return new GetProfilePictureOutput(string.Empty);
            }

            return new GetProfilePictureOutput(Convert.ToBase64String(bytes));
        }
        [AbpAuthorize]
        public async Task<double> GetCurrentUserWallet()
        {
            var user = await GetCurrentUserAsync();

            return user.Wallet;
        }


        [DisableAuditing,AbpAllowAnonymous]
        public async Task<CurrentUserProfileEditDto> GetUserProfileById(long Id)
        {
            var user = await UserManager.GetUserByIdAsync(Id);
            var userProfileEditDto = ObjectMapper.Map<CurrentUserProfileEditDto>(user);
            var res = await GetProfilePictureByUser(Id);
            userProfileEditDto.ProfilePicture = res.ProfilePicture;
            return userProfileEditDto;
        }
    }
}