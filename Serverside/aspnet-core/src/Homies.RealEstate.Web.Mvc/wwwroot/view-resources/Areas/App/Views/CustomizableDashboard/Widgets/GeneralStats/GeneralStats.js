$(function () {
    var _tenantDashboardService = abp.services.app.tenantDashboard;

    var _$Container = $('.GeneralStatsContainer');

    var initGeneralStats = function (transactionPercent, newVisitPercent, bouncePercent) {
        //General stats =>  EasyPieChart: https://rendro.github.io/easy-pie-chart/

        var init = function (transactionPercent, newVisitPercent, bouncePercent) {
            _$Container.find("#transactionPercent").attr("data-percent", transactionPercent);
            _$Container.find("#transactionPercent span").text(transactionPercent);
            _$Container.find("#newVisitPercent").attr("data-percent", newVisitPercent);
            _$Container.find("#newVisitPercent span").text(newVisitPercent);
            _$Container.find("#bouncePercent").attr("data-percent", bouncePercent);
            _$Container.find("#bouncePercent span").text(bouncePercent);
            _$Container.find(".easy-pie-chart-loading").hide();
        };

        var refreshGeneralStats = function (transactionPercent, newVisitPercent, bouncePercent) {
            _$Container.find('#transactionPercent').data('easyPieChart').update(transactionPercent);
            _$Container.find("#transactionPercent span").text(transactionPercent);
            _$Container.find('#newVisitPercent').data('easyPieChart').update(newVisitPercent);
            _$Container.find("#newVisitPercent span").text(newVisitPercent);
            _$Container.find('#bouncePercent').data('easyPieChart').update(bouncePercent);
            _$Container.find("#bouncePercent span").text(bouncePercent);
        };

        var createPieCharts = function () {
            _$Container.find('.easy-pie-chart .number.transactions').easyPieChart({
                animate: 1000,
                size: 75,
                lineWidth: 3,
                barColor: "#ffb822"
            });

            _$Container.find('.easy-pie-chart .number.visits').easyPieChart({
                animate: 1000,
                size: 75,
                lineWidth: 3,
                barColor: "#36a3f7"
            });

            _$Container.find('.easy-pie-chart .number.bounce').easyPieChart({
                animate: 1000,
                size: 75,
                lineWidth: 3,
                barColor: "#f4516c"
            });
        };

        _$Container.find("#generalStatsReload").click(function () {
            _tenantDashboardService
                .getGeneralStats({})
                .done(function (result) {
                    refreshGeneralStats(result.transactionPercent, result.newVisitPercent, result.bouncePercent);
                });
        });

        init(transactionPercent, newVisitPercent, bouncePercent);
        createPieCharts();
    };

    var getDashboardData = function () {
        _tenantDashboardService
            .getGeneralStats()
            .done(function (result) {
                initGeneralStats(result.transactionPercent, result.newVisitPercent, result.bouncePercent);
                _$Container.find(".counterup").counterUp();
            });
    };

    getDashboardData();
});