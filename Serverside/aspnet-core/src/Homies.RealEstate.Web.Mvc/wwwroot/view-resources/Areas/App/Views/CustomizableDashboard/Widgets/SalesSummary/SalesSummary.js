$(function () {
    var _tenantDashboardService = abp.services.app.tenantDashboard;
    var _$Container = $('.SalesSummaryContainer');

    var salesSummaryDatePeriod = {
        daily: 1,
        weekly: 2,
        monthly: 3
    };

    var initSalesSummaryChart = function (salesSummaryData, totalSales, revenue, expenses, growth) {
        //Sales summary => MorrisJs: https://github.com/morrisjs/morris.js/

        var SalesSummaryChart = function (element) {
            var instance = null;

            var init = function (data) {
                return new Morris.Area({
                    element: element,
                    padding: 0,
                    behaveLikeLine: false,
                    gridEnabled: false,
                    gridLineColor: false,
                    axes: false,
                    fillOpacity: 1,
                    data: data,
                    lineColors: ['#399a8c', '#92e9dc'],
                    xkey: 'period',
                    ykeys: ['sales', 'profit'],
                    labels: ['Sales', 'Profit'],
                    pointSize: 0,
                    lineWidth: 0,
                    hideHover: 'auto',
                    resize: true
                });
            };

            var refresh = function (datePeriod) {
                var self = this;
                _tenantDashboardService
                    .getSalesSummary({
                        salesSummaryDatePeriod: datePeriod
                    })
                    .done(function (result) {
                        self.graph.setData(result.salesSummary);
                        self.graph.redraw();
                    });
            };

            var draw = function (data) {
                if (!this.graph) {
                    this.graph = init(data);
                } else {
                    this.graph.setData(data);
                    this.graph.redraw();
                }
            };

            return {
                draw: draw,
                refresh: refresh,
                graph: instance
            };
        };

        _$Container.find("#salesStatistics").show();

        for (var i = 0; i < _$Container.length; i++) {

            $(_$Container[i]).find('.salesStatisticsChart').attr('id', 'salesStatistics' + i);
            var salesSummary = new SalesSummaryChart('salesStatistics' + i);
            salesSummary.draw(salesSummaryData);
            $(_$Container[i]).find("input[name='SalesSummaryDateInterval']").unbind('change');
            $(_$Container[i]).find("input[name='SalesSummaryDateInterval']").change(function () {
                salesSummary.refresh(this.value);
            });
        }

        _$Container.find("#totalSales").text(totalSales);
        _$Container.find("#revenue").text(revenue);
        _$Container.find("#expenses").text(expenses);
        _$Container.find("#growth").text(growth);
        _$Container.find("#salesStatisticsLoading").hide();
    };

    var getSalesSummary = function () {
        abp.ui.setBusy(_$Container);
        _tenantDashboardService
            .getSalesSummary({
                salesSummaryDatePeriod: salesSummaryDatePeriod.daily
            })
            .done(function (result) {
                initSalesSummaryChart(result.salesSummary, result.totalSales, result.revenue, result.expenses, result.growth);
            }).always(function () {
                abp.ui.clearBusy(_$Container);
            });
    };
    getSalesSummary();
});