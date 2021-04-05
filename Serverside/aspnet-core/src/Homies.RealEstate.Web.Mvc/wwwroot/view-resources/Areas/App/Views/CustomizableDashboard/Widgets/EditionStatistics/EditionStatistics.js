$(function () {

    var _hostDashboardService = abp.services.app.hostDashboard;
    var _$container = $(".EditionStatisticsContainer");
    var _$editionStatisticsSubtitle = _$container.find(".sub-title");
    var _$editionStatisticsChartContainer = _$container.find(".edition-statistics-chart");
    var _currency = "$";

    var _widgetBase = app.widgetBase.create();

    var _selectedDateRange = {
        startDate: moment().add(-7, 'days').startOf('day'),
        endDate: moment().endOf("day")
    };

    var getCurrentDateRangeText = function () {
        return _selectedDateRange.startDate.format("L") + " - " + _selectedDateRange.endDate.format("L");
    };

    var getNoDataInfo = function () {
        return $("<div/>")
            .addClass("note")
            .addClass("note-info")
            .addClass("text-center")
            .append(
                $("<small/>")
                    .addClass("text-muted")
                    .text("- " + app.localize("NoData") + " -")
            );
    };

    var drawEditionStatisticsData = function (data) {
        if (!data || data.length === 0) {
            _$editionStatisticsChartContainer.html(getNoDataInfo());
            return;
        }

        var colorPalette = ["#81A17E", "#BA9B7C", "#569BC6", "#e08283", "#888888"];
        var chartData = [];
        for (var i = 0; i < data.length; i++) {
            var pie = {
                label: data[i].label,
                data: data[i].value
            };

            if (colorPalette[i]) {
                pie.color = colorPalette[i];
            }

            chartData.push(pie);
        }

        $.plot(_$editionStatisticsChartContainer, chartData, {
            series: {
                pie: {
                    show: true,
                    innerRadius: 0.3,
                    radius: 1,
                    label: {
                        show: true,
                        radius: 1,
                        formatter: function (label, series) {
                            return "<div class='pie-chart-label'>" + label + " : " + Math.round(series.percent) + "%</div>";
                        },
                        background: {
                            opacity: 0.8
                        }
                    }
                }
            },
            legend: {
                show: false
            },
            grid: {
                hoverable: true,
                clickable: true
            }
        });

        _$editionStatisticsSubtitle.text(getCurrentDateRangeText());
    };

    var getEditionDataAndDrawChart = function () {
        abp.ui.setBusy(_$container);
        _hostDashboardService
            .getEditionTenantStatistics({
                startDate: _selectedDateRange.startDate,
                endDate: _selectedDateRange.endDate
            })
            .done(function (result) {
                drawEditionStatisticsData(result.editionStatistics);
            }).always(function () {
            abp.ui.clearBusy(_$container);
        });
    };

    abp.event.on('app.dashboardFilters.DateRangePicker.OnDateChange', function (dateRange) {
        if (!dateRange || (_selectedDateRange.startDate === dateRange.startDate && _selectedDateRange.endDate === dateRange.endDate)) {
            return;
        }
        _selectedDateRange.startDate = dateRange.startDate;
        _selectedDateRange.endDate = dateRange.endDate;

        _widgetBase.runDelayed(getEditionDataAndDrawChart);
    });

    _widgetBase.runDelayed(getEditionDataAndDrawChart);
});