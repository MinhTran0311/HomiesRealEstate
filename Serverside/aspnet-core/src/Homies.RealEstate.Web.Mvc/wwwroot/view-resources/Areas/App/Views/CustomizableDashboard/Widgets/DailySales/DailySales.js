$(function () {
    var _tenantDashboardService = abp.services.app.tenantDashboard;
    var _widgetBase = app.widgetBase.create();
    var _$Container = $('.DailySalesContainer');

    //== Daily Sales chart.
    //** Based on Chartjs plugin - http://www.chartjs.org/
    var initDailySales = function (data) {
        var dayLabels = [];
        for (var day = 1; day <= data.length; day++) {
            dayLabels.push("Day " + day);
        }

        var chartData = {
            labels: dayLabels,
            datasets: [{
                //label: 'Dataset 1',
                backgroundColor: '#34bfa3',
                data: data
            }, {
                //label: 'Dataset 2',
                backgroundColor: '#f3f3fb',
                data: data
            }]
        };

        for (var i = 0; i < _$Container.length; i++) {
            var chartContainer = $(_$Container[i]).find('#m_chart_daily_sales');

            new Chart(chartContainer, {
                type: 'bar',
                data: chartData,
                options: {
                    title: {
                        display: false
                    },
                    tooltips: {
                        intersect: false,
                        mode: 'nearest',
                        xPadding: 10,
                        yPadding: 10,
                        caretPadding: 10
                    },
                    legend: {
                        display: false
                    },
                    responsive: true,
                    maintainAspectRatio: false,
                    barRadius: 4,
                    scales: {
                        xAxes: [{
                            display: false,
                            gridLines: false,
                            stacked: true
                        }],
                        yAxes: [{
                            display: false,
                            stacked: true,
                            gridLines: false
                        }]
                    },
                    layout: {
                        padding: {
                            left: 0,
                            right: 0,
                            top: 0,
                            bottom: 0
                        }
                    }
                }
            });
        }
    };

    var getDailySales = function () {
        abp.ui.setBusy(_$Container);
        _tenantDashboardService
            .getDailySales()
            .done(function (result) {
                initDailySales(result.dailySales);
            }).always(function () {
                abp.ui.clearBusy(_$Container);
            });
    };

    _widgetBase.runDelayed(getDailySales);

    $('#DashboardTabList a[data-toggle="pill"]').on('shown.bs.tab', function (e) {
        _widgetBase.runDelayed(getDailySales);
    });

    abp.event.on('app.dashboardFilters.DateRangePicker.OnDateChange', function (_selectedDates) {
        _widgetBase.runDelayed(getDailySales);
    });
});