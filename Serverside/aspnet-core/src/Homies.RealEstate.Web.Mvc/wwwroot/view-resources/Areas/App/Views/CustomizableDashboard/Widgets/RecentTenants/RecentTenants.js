$(function () {

    var _hostDashboardService = abp.services.app.hostDashboard;
    var _$container = $(".RecentTenantsContainer");
    var _$recentTenantsTable = _$container.find(".recent-tenants-table");
    var _$seeAllRecentTenantsButton = _$container.find(".see-all-recent-tenants");
    var _$recentTenantsCaptionHelper = _$container.find(".sub-title");
    var _recentTenantsData = [];


    var populateRecentTenantsTable = function (recentTenants, recentTenantsDayCount, maxRecentTenantsShownCount, creationDateStart) {
        _$recentTenantsCaptionHelper.text(app.localize("RecentTenantsHelpText", recentTenantsDayCount, maxRecentTenantsShownCount));
        _recentTenantsData = recentTenants;
        _recentTenantsDataTable.ajax.reload();

        _$seeAllRecentTenantsButton
            .data("creationDateStart", creationDateStart)
            .click(function () {
                window.open(abp.appPath + "App/Tenants?" +
                    "creationDateStart=" + encodeURIComponent($(this).data("creationDateStart")));
            });
    };

    var getRecentTenantsData = function () {
        abp.ui.setBusy(_$container);
        _hostDashboardService
            .getRecentTenantsData()
            .done(function (result) {
                populateRecentTenantsTable(
                    result.recentTenants,
                    result.recentTenantsDayCount,
                    result.maxRecentTenantsShownCount,
                    result.tenantCreationStartDate
                );
            }).always(function () {
                abp.ui.clearBusy(_$container);
            });
    };

    var _recentTenantsDataTable = null;
    var initRecentTenantsTable = function () {
        _recentTenantsDataTable = _$recentTenantsTable.DataTable({
            paging: false,
            serverSide: false,
            processing: false,
            info: false,
            listAction: {
                ajaxFunction: function () {
                    return $.Deferred(function ($dfd) {
                        $dfd.resolve({
                            "items": _recentTenantsData,
                            "totalCount": _recentTenantsData.length
                        });
                    });
                }
            },
            columnDefs: [
                {
                    targets: 0,
                    data: "name"
                },
                {
                    targets: 1,
                    data: "creationTime",
                    render: function (creationTime) {
                        return moment(creationTime).format("L LT");
                    }
                }
            ]
        });
    };

    var initialize = function () {
        initRecentTenantsTable();
        getRecentTenantsData();
    };

    initialize();
});