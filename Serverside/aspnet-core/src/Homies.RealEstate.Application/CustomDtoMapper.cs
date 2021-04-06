using Homies.RealEstate.Server.Dtos;
using Homies.RealEstate.Server;
using Abp.Application.Editions;
using Abp.Application.Features;
using Abp.Auditing;
using Abp.Authorization;
using Abp.Authorization.Users;
using Abp.DynamicEntityProperties;
using Abp.EntityHistory;
using Abp.Localization;
using Abp.Notifications;
using Abp.Organizations;
using Abp.UI.Inputs;
using Abp.Webhooks;
using AutoMapper;
using Homies.RealEstate.Auditing.Dto;
using Homies.RealEstate.Authorization.Accounts.Dto;
using Homies.RealEstate.Authorization.Delegation;
using Homies.RealEstate.Authorization.Permissions.Dto;
using Homies.RealEstate.Authorization.Roles;
using Homies.RealEstate.Authorization.Roles.Dto;
using Homies.RealEstate.Authorization.Users;
using Homies.RealEstate.Authorization.Users.Delegation.Dto;
using Homies.RealEstate.Authorization.Users.Dto;
using Homies.RealEstate.Authorization.Users.Importing.Dto;
using Homies.RealEstate.Authorization.Users.Profile.Dto;
using Homies.RealEstate.Chat;
using Homies.RealEstate.Chat.Dto;
using Homies.RealEstate.DynamicEntityProperties.Dto;
using Homies.RealEstate.Editions;
using Homies.RealEstate.Editions.Dto;
using Homies.RealEstate.Friendships;
using Homies.RealEstate.Friendships.Cache;
using Homies.RealEstate.Friendships.Dto;
using Homies.RealEstate.Localization.Dto;
using Homies.RealEstate.MultiTenancy;
using Homies.RealEstate.MultiTenancy.Dto;
using Homies.RealEstate.MultiTenancy.HostDashboard.Dto;
using Homies.RealEstate.MultiTenancy.Payments;
using Homies.RealEstate.MultiTenancy.Payments.Dto;
using Homies.RealEstate.Notifications.Dto;
using Homies.RealEstate.Organizations.Dto;
using Homies.RealEstate.Sessions.Dto;
using Homies.RealEstate.WebHooks.Dto;

namespace Homies.RealEstate
{
    internal static class CustomDtoMapper
    {
        public static void CreateMappings(IMapperConfigurationExpression configuration)
        {
            configuration.CreateMap<CreateOrEditGoiBaiDangDto, GoiBaiDang>().ReverseMap();
            configuration.CreateMap<GoiBaiDangDto, GoiBaiDang>().ReverseMap();
            configuration.CreateMap<CreateOrEditBaiDangDto, BaiDang>().ReverseMap();
            configuration.CreateMap<BaiDangDto, BaiDang>().ReverseMap();
            configuration.CreateMap<CreateOrEditChiTietDanhMucDto, ChiTietDanhMuc>().ReverseMap();
            configuration.CreateMap<ChiTietDanhMucDto, ChiTietDanhMuc>().ReverseMap();
            configuration.CreateMap<CreateOrEditDanhMucDto, DanhMuc>().ReverseMap();
            configuration.CreateMap<DanhMucDto, DanhMuc>().ReverseMap();
            configuration.CreateMap<CreateOrEditThuocTinhDto, ThuocTinh>().ReverseMap();
            configuration.CreateMap<ThuocTinhDto, ThuocTinh>().ReverseMap();
            configuration.CreateMap<CreateOrEditThamSoDto, ThamSo>().ReverseMap();
            configuration.CreateMap<ThamSoDto, ThamSo>().ReverseMap();
            configuration.CreateMap<CreateOrEditXaDto, Xa>().ReverseMap();
            configuration.CreateMap<XaDto, Xa>().ReverseMap();
            configuration.CreateMap<CreateOrEditHuyenDto, Huyen>().ReverseMap();
            configuration.CreateMap<HuyenDto, Huyen>().ReverseMap();
            configuration.CreateMap<CreateOrEditTinhDto, Tinh>().ReverseMap();
            configuration.CreateMap<TinhDto, Tinh>().ReverseMap();
            //Inputs
            configuration.CreateMap<CheckboxInputType, FeatureInputTypeDto>();
            configuration.CreateMap<SingleLineStringInputType, FeatureInputTypeDto>();
            configuration.CreateMap<ComboboxInputType, FeatureInputTypeDto>();
            configuration.CreateMap<IInputType, FeatureInputTypeDto>()
                .Include<CheckboxInputType, FeatureInputTypeDto>()
                .Include<SingleLineStringInputType, FeatureInputTypeDto>()
                .Include<ComboboxInputType, FeatureInputTypeDto>();
            configuration.CreateMap<StaticLocalizableComboboxItemSource, LocalizableComboboxItemSourceDto>();
            configuration.CreateMap<ILocalizableComboboxItemSource, LocalizableComboboxItemSourceDto>()
                .Include<StaticLocalizableComboboxItemSource, LocalizableComboboxItemSourceDto>();
            configuration.CreateMap<LocalizableComboboxItem, LocalizableComboboxItemDto>();
            configuration.CreateMap<ILocalizableComboboxItem, LocalizableComboboxItemDto>()
                .Include<LocalizableComboboxItem, LocalizableComboboxItemDto>();

            //Chat
            configuration.CreateMap<ChatMessage, ChatMessageDto>();
            configuration.CreateMap<ChatMessage, ChatMessageExportDto>();

            //Feature
            configuration.CreateMap<FlatFeatureSelectDto, Feature>().ReverseMap();
            configuration.CreateMap<Feature, FlatFeatureDto>();

            //Role
            configuration.CreateMap<RoleEditDto, Role>().ReverseMap();
            configuration.CreateMap<Role, RoleListDto>();
            configuration.CreateMap<UserRole, UserListRoleDto>();

            //Edition
            configuration.CreateMap<EditionEditDto, SubscribableEdition>().ReverseMap();
            configuration.CreateMap<EditionCreateDto, SubscribableEdition>();
            configuration.CreateMap<EditionSelectDto, SubscribableEdition>().ReverseMap();
            configuration.CreateMap<SubscribableEdition, EditionInfoDto>();

            configuration.CreateMap<Edition, EditionInfoDto>().Include<SubscribableEdition, EditionInfoDto>();

            configuration.CreateMap<SubscribableEdition, EditionListDto>();
            configuration.CreateMap<Edition, EditionEditDto>();
            configuration.CreateMap<Edition, SubscribableEdition>();
            configuration.CreateMap<Edition, EditionSelectDto>();

            //Payment
            configuration.CreateMap<SubscriptionPaymentDto, SubscriptionPayment>().ReverseMap();
            configuration.CreateMap<SubscriptionPaymentListDto, SubscriptionPayment>().ReverseMap();
            configuration.CreateMap<SubscriptionPayment, SubscriptionPaymentInfoDto>();

            //Permission
            configuration.CreateMap<Permission, FlatPermissionDto>();
            configuration.CreateMap<Permission, FlatPermissionWithLevelDto>();

            //Language
            configuration.CreateMap<ApplicationLanguage, ApplicationLanguageEditDto>();
            configuration.CreateMap<ApplicationLanguage, ApplicationLanguageListDto>();
            configuration.CreateMap<NotificationDefinition, NotificationSubscriptionWithDisplayNameDto>();
            configuration.CreateMap<ApplicationLanguage, ApplicationLanguageEditDto>()
                .ForMember(ldto => ldto.IsEnabled, options => options.MapFrom(l => !l.IsDisabled));

            //Tenant
            configuration.CreateMap<Tenant, RecentTenant>();
            configuration.CreateMap<Tenant, TenantLoginInfoDto>();
            configuration.CreateMap<Tenant, TenantListDto>();
            configuration.CreateMap<TenantEditDto, Tenant>().ReverseMap();
            configuration.CreateMap<CurrentTenantInfoDto, Tenant>().ReverseMap();

            //User
            configuration.CreateMap<User, UserEditDto>()
                .ForMember(dto => dto.Password, options => options.Ignore())
                .ReverseMap()
                .ForMember(user => user.Password, options => options.Ignore());
            configuration.CreateMap<User, UserLoginInfoDto>();
            configuration.CreateMap<User, UserListDto>();
            configuration.CreateMap<User, ChatUserDto>();
            configuration.CreateMap<User, OrganizationUnitUserListDto>();
            configuration.CreateMap<Role, OrganizationUnitRoleListDto>();
            configuration.CreateMap<CurrentUserProfileEditDto, User>().ReverseMap();
            configuration.CreateMap<UserLoginAttemptDto, UserLoginAttempt>().ReverseMap();
            configuration.CreateMap<ImportUserDto, User>();

            //AuditLog
            configuration.CreateMap<AuditLog, AuditLogListDto>();
            configuration.CreateMap<EntityChange, EntityChangeListDto>();
            configuration.CreateMap<EntityPropertyChange, EntityPropertyChangeDto>();

            //Friendship
            configuration.CreateMap<Friendship, FriendDto>();
            configuration.CreateMap<FriendCacheItem, FriendDto>();

            //OrganizationUnit
            configuration.CreateMap<OrganizationUnit, OrganizationUnitDto>();

            //Webhooks
            configuration.CreateMap<WebhookSubscription, GetAllSubscriptionsOutput>();
            configuration.CreateMap<WebhookSendAttempt, GetAllSendAttemptsOutput>()
                .ForMember(webhookSendAttemptListDto => webhookSendAttemptListDto.WebhookName,
                    options => options.MapFrom(l => l.WebhookEvent.WebhookName))
                .ForMember(webhookSendAttemptListDto => webhookSendAttemptListDto.Data,
                    options => options.MapFrom(l => l.WebhookEvent.Data));

            configuration.CreateMap<WebhookSendAttempt, GetAllSendAttemptsOfWebhookEventOutput>();

            configuration.CreateMap<DynamicProperty, DynamicPropertyDto>().ReverseMap();
            configuration.CreateMap<DynamicPropertyValue, DynamicPropertyValueDto>().ReverseMap();
            configuration.CreateMap<DynamicEntityProperty, DynamicEntityPropertyDto>()
                .ForMember(dto => dto.DynamicPropertyName,
                    options => options.MapFrom(entity => entity.DynamicProperty.DisplayName));
            configuration.CreateMap<DynamicEntityPropertyDto, DynamicEntityProperty>();

            configuration.CreateMap<DynamicEntityPropertyValue, DynamicEntityPropertyValueDto>().ReverseMap();

            //User Delegations
            configuration.CreateMap<CreateUserDelegationDto, UserDelegation>();

            /* ADD YOUR OWN CUSTOM AUTOMAPPER MAPPINGS HERE */
        }
    }
}