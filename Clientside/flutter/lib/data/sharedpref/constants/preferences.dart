class Preferences {
  Preferences._();

  static const String is_logged_in = "isLoggedIn";
  static const String auth_token = "authToken";
  static String access_token = "";
  static bool is_dark_mode = false;
  static const String current_language = "current_language";
  static const String imgbb_api_key = "d2c7b8df30fc67baab57beaac0d21bad";
  static String userRole = "";
  static int userRoleRank = 0;
  static const int skipIndex = 5;
  static const int maxCount = 5;

  static const int maxProvinceCount = 64;
  static const int maxTownCount = 709;
  static const int maxCommuneCount = 11310;
  static const int maxDanhMucCount = 1000;
  static const int maxPostCount = 10000;

  static List<String> grantedPermissions = new List<String>();
  //#region permision
  static const PagesLichSuGiaoDichs = "Pages.LichSuGiaoDichs";
  static const PagesLichSuGiaoDichsCreate = "Pages.LichSuGiaoDichs.Create";
  static const PagesLichSuGiaoDichsEdit = "Pages.LichSuGiaoDichs.Edit";
  static const PagesLichSuGiaoDichsDelete = "Pages.LichSuGiaoDichs.Delete";
  static const PagesChiTietBaiDangs = "Pages.ChiTietBaiDangs";
  static const PagesChiTietBaiDangsCreate = "Pages.ChiTietBaiDangs.Create";
  static const PagesChiTietBaiDangsEdit = "Pages.ChiTietBaiDangs.Edit";
  static const PagesChiTietBaiDangsDelete = "Pages.ChiTietBaiDangs.Delete";
  static const PagesChiTietHoaDonBaiDangs = "Pages.ChiTietHoaDonBaiDangs";
  static const PagesChiTietHoaDonBaiDangsCreate = "Pages.ChiTietHoaDonBaiDangs.Create";
  static const PagesChiTietHoaDonBaiDangsEdit = "Pages.ChiTietHoaDonBaiDangs.Edit";
  static const PagesChiTietHoaDonBaiDangsDelete = "Pages.ChiTietHoaDonBaiDangs.Delete";
  static const PagesBaiGhimYeuThichs = "Pages.BaiGhimYeuThichs";
  static const PagesBaiGhimYeuThichsCreate = "Pages.BaiGhimYeuThichs.Create";
  static const PagesBaiGhimYeuThichsEdit = "Pages.BaiGhimYeuThichs.Edit";
  static const PagesBaiGhimYeuThichsDelete = "Pages.BaiGhimYeuThichs.Delete";
  static const PagesHinhAnhs = "Pages.HinhAnhs";
  static const PagesHinhAnhsCreate = "Pages.HinhAnhs.Create";
  static const PagesHinhAnhsEdit = "Pages.HinhAnhs.Edit";
  static const PagesHinhAnhsDelete = "Pages.HinhAnhs.Delete";
  static const PagesGoiBaiDangs = "Pages.GoiBaiDangs";
  static const PagesGoiBaiDangsCreate = "Pages.GoiBaiDangs.Create";
  static const PagesGoiBaiDangsEdit = "Pages.GoiBaiDangs.Edit";
  static const PagesGoiBaiDangsDelete = "Pages.GoiBaiDangs.Delete";
  static const PagesBaiDangs = "Pages.BaiDangs";
  static const PagesBaiDangsCreate = "Pages.BaiDangs.Create";
  static const PagesBaiDangsEdit = "Pages.BaiDangs.Edit";
  static const PagesBaiDangsDelete = "Pages.BaiDangs.Delete";
  static const PagesChiTietDanhMucs = "Pages.ChiTietDanhMucs";
  static const PagesChiTietDanhMucsCreate = "Pages.ChiTietDanhMucs.Create";
  static const PagesChiTietDanhMucsEdit = "Pages.ChiTietDanhMucs.Edit";
  static const PagesChiTietDanhMucsDelete = "Pages.ChiTietDanhMucs.Delete";
  static const PagesDanhMucs = "Pages.DanhMucs";
  static const PagesDanhMucsCreate = "Pages.DanhMucs.Create";
  static const PagesDanhMucsEdit = "Pages.DanhMucs.Edit";
  static const PagesDanhMucsDelete = "Pages.DanhMucs.Delete";
  static const PagesThuocTinhs = "Pages.ThuocTinhs";
  static const PagesThuocTinhsCreate = "Pages.ThuocTinhs.Create";
  static const PagesThuocTinhsEdit = "Pages.ThuocTinhs.Edit";
  static const PagesThuocTinhsDelete = "Pages.ThuocTinhs.Delete";
  static const PagesThamSos = "Pages.ThamSos";
  static const PagesThamSosCreate = "Pages.ThamSos.Create";
  static const PagesThamSosEdit = "Pages.ThamSos.Edit";
  static const PagesThamSosDelete = "Pages.ThamSos.Delete";
  static const PagesXas = "Pages.Xas";
  static const PagesXasCreate = "Pages.Xas.Create";
  static const PagesXasEdit = "Pages.Xas.Edit";
  static const PagesHuyens = "Pages.Huyens";
  static const PagesHuyensCreate = "Pages.Huyens.Create";
  static const PagesHuyensEdit = "Pages.Huyens.Edit";
  static const PagesHuyensDelete = "Pages.Huyens.Delete";
  static const PagesTinhs = "Pages.Tinhs";
  static const PagesTinhsCreate = "Pages.Tinhs.Create";
  static const PagesTinhsEdit = "Pages.Tinhs.Edit";
  static const PagesTinhsDelete = "Pages.Tinhs.Delete";
  static const PagesDemoUiComponents = "Pages.DemoUiComponents";
  static const PagesAdministration = "Pages.Administration";
  static const PagesAdministrationRoles = "Pages.Administration.Roles";
  static const PagesAdministrationRolesCreate = "Pages.Administration.Roles.Create";
  static const PagesAdministrationRolesEdit = "Pages.Administration.Roles.Edit";
  static const PagesAdministrationRolesDelete = "Pages.Administration.Roles.Delete";
  static const PagesAdministrationUsers = "Pages.Administration.Users";
  static const PagesAdministrationUsersCreate = "Pages.Administration.Users.Create";
  static const PagesAdministrationUsersEdit = "Pages.Administration.Users.Edit";
  static const PagesAdministrationUsersDelete = "Pages.Administration.Users.Delete";
  static const PagesAdministrationUsersChangePermissions = "Pages.Administration.Users.ChangePermissions";
  static const PagesAdministrationUsersImpersonation = "Pages.Administration.Users.Impersonation";
  static const PagesAdministrationUsersUnlock = "Pages.Administration.Users.Unlock";
  static const PagesAdministrationLanguages = "Pages.Administration.Languages";
  static const PagesAdministrationLanguagesCreate = "Pages.Administration.Languages.Create";
  static const PagesAdministrationLanguagesEdit = "Pages.Administration.Languages.Edit";
  static const PagesAdministrationLanguagesDelete = "Pages.Administration.Languages.Delete";
  static const PagesAdministrationLanguagesChangeTexts = "Pages.Administration.Languages.ChangeTexts";
  static const PagesAdministrationAuditLogs = "Pages.Administration.AuditLogs";
  // static const PagesAdministrationOrganizationUnits = "Pages.Administration.OrganizationUnits";
  // static const PagesAdministrationOrganizationUnitsManageOrganizationTree = "Pages.Administration.OrganizationUnits.ManageOrganizationTree";
  // static const PagesAdministrationOrganizationUnitsManageMembers = "Pages.Administration.OrganizationUnits.ManageMembers";
  // static const PagesAdministrationOrganizationUnitsManageRoles = "Pages.Administration.OrganizationUnits.ManageRoles";
  // static const PagesAdministrationUiCustomization = "Pages.Administration.UiCustomization";
  // static const PagesAdministrationWebhookSubscription = "Pages.Administration.WebhookSubscription";
  // static const PagesAdministrationWebhookSubscriptionCreate = "Pages.Administration.WebhookSubscription.Create";
  // static const PagesAdministrationWebhookSubscriptionEdit = "Pages.Administration.WebhookSubscription.Edit";
  // static const PagesAdministrationWebhookSubscriptionChangeActivity = "Pages.Administration.WebhookSubscription.ChangeActivity";
  // static const PagesAdministrationWebhookSubscriptionDetail = "Pages.Administration.WebhookSubscription.Detail";
  // static const PagesAdministrationWebhookListSendAttempts = "Pages.Administration.Webhook.ListSendAttempts";
  // static const PagesAdministrationWebhookResendWebhook = "Pages.Administration.Webhook.ResendWebhook";
  // static const PagesAdministrationDynamicProperties = "Pages.Administration.DynamicProperties";
  // static const PagesAdministrationDynamicPropertiesCreate = "Pages.Administration.DynamicProperties.Create";
  // static const PagesAdministrationDynamicPropertiesEdit = "Pages.Administration.DynamicProperties.Edit";
  // static const PagesAdministrationDynamicPropertiesDelete = "Pages.Administration.DynamicProperties.Delete";
  // static const PagesAdministrationDynamicPropertyValue = "Pages.Administration.DynamicPropertyValue";
  // static const PagesAdministrationDynamicPropertyValueCreate = "Pages.Administration.DynamicPropertyValue.Create";
  // static const PagesAdministrationDynamicPropertyValueEdit = "Pages.Administration.DynamicPropertyValue.Edit";
  // static const PagesAdministrationDynamicPropertyValueDelete = "Pages.Administration.DynamicPropertyValue.Delete";
  // static const PagesAdministrationDynamicEntityProperties = "Pages.Administration.DynamicEntityProperties";
  // static const PagesAdministrationDynamicEntityPropertiesCreate = "Pages.Administration.DynamicEntityProperties.Create";
  // static const PagesAdministrationDynamicEntityPropertiesEdit = "Pages.Administration.DynamicEntityProperties.Edit";
  // static const PagesAdministrationDynamicEntityPropertiesDelete = "Pages.Administration.DynamicEntityProperties.Delete";
  // static const PagesAdministrationDynamicEntityPropertyValue = "Pages.Administration.DynamicEntityPropertyValue";
  // static const PagesAdministrationDynamicEntityPropertyValueCreate = "Pages.Administration.DynamicEntityPropertyValue.Create";
  // static const PagesAdministrationDynamicEntityPropertyValueEdit = "Pages.Administration.DynamicEntityPropertyValue.Edit";
  // static const PagesAdministrationDynamicEntityPropertyValueDelete = "Pages.Administration.DynamicEntityPropertyValue.Delete";
  // static const PagesAdministrationTenantSettings = "Pages.Administration.Tenant.Settings";
  // static const PagesAdministrationTenantSubscriptionManagement = "Pages.Administration.Tenant.SubscriptionManagement";
  // static const PagesAdministrationHostMaintenance = "Pages.Administration.Host.Maintenance";
  // static const PagesAdministrationHangfireDashboard = "Pages.Administration.HangfireDashboard";
  //#endregion


}
