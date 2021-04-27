$(function () {
    var _tenantDashboardService = abp.services.app.tenantDashboard;

    var _$container = $('.TopStatsContainer');

    var initDashboardTopStats = function (totalProfit, newFeedbacks, newOrders, newUsers) {
        _$container.find("#totalProfit").text(totalProfit);
        _$container.find("#newFeedbacks").text(newFeedbacks);
        _$container.find("#newOrders").text(newOrders);
        _$container.find("#newUsers").text(newUsers);
        _$container.find(".counterup").counterUp();
    };

    var getTopStatsData = function () {
        _tenantDashboardService
            .getTopStats()
            .done(function (result) {
                initDashboardTopStats(result.totalProfit, result.newFeedbacks, result.newOrders, result.newUsers);
            });
    };

    getTopStatsData();
});