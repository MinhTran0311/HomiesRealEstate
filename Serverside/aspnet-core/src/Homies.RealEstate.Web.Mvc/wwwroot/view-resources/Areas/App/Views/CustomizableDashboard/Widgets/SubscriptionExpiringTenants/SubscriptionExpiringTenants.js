$(function () {

    var _hostDashboardService = abp.services.app.hostDashboard;
    var _$container = $(".SubscriptionExpiringTenantsContainer");
    var _$expiringTenantsTable = _$container.find(".expiring-tenants-table");
    var _$seeAllExpiringTenantsButton = _$container.find(".see-all-expiring-tenants");
    var _$expiringTenantsCaptionHelper = _$container.find(".sub-title");
    var _expiringTenantsData = [];

    var _expiringTenantsDataTable = null;
    var populateExpiringTenantsTable = function (expiringTenants, subscriptionEndAlertDayCount, maxExpiringTenantsShownCount, subscriptionEndDateStart, subscriptionEndDateEnd) {
        _$expiringTenantsCaptionHelper.text(app.localize("ExpiringTenantsHelpText", subscriptionEndAlertDayCount, maxExpiringTenantsShownCount));
        _expiringTenantsData = expiringTenants;
        _expiringTenantsDataTable.ajax.reload();

        _$seeAllExpiringTenantsButton
            .data("subscriptionEndDateStart", subscriptionEndDateStart)
            .data("subscriptionEndDateEnd", subscriptionEndDateEnd)
            .click(function () {
                window.open(abp.appPath + "App/Tenants?" +
                    "subscriptionEndDateStart=" + encodeURIComponent($(this).data("subscriptionEndDateStart")) + "&" +
                    "subscriptionEndDateEnd=" + encodeURIComponent($(this).data("subscriptionEndDateEnd")));
            });
    };

    var getSubscriptionExpiringTenants = function () {
        abp.ui.setBusy(_$container);
        _hostDashboardService
            .getSubscriptionExpiringTenantsData()
            .done(function (result) {
                populateExpiringTenantsTable(
                    result.expiringTenants,
                    result.subscriptionEndAlertDayCount,
                    result.maxExpiringTenantsShownCount,
                    result.subscriptionEndDateStart,
                    result.subscriptionEndDateEnd
                );
            }).always(function () {
            abp.ui.clearBusy(_$container);
        });
    };

    var initExpiringTenantsTable = function () {
        _expiringTenantsDataTable = _$expiringTenantsTable.DataTable({
            paging: false,
            serverSide: false,
            processing: false,
            info: false,
            listAction: {
                ajaxFunction: function () {
                    return $.Deferred(function ($dfd) {
                        $dfd.resolve({
                            "items": _expiringTenantsData,
                            "totalCount": _expiringTenantsData.length
                        });
                    });
                }
            },
            columnDefs: [
                {
                    targets: 0,
                    data: "tenantName"
                },
                {
                    targets: 1,
                    data: "remainingDayCount"
                }
            ]
        });
    };

    var initialize = function () {
        initExpiringTenantsTable();
        getSubscriptionExpiringTenants();
    };

    initialize();
});