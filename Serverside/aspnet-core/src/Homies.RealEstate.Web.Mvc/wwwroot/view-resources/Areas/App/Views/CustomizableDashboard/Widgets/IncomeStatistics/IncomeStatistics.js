$(function () {

    var _hostDashboardService = abp.services.app.hostDashboard;
    var _$container = $(".income-statistics");
    var _$incomeStatisticsDatePeriod = _$container.find("input[name='IncomeStatisticsDatePeriod']");
    var _$incomeStatisticsChartContainer = _$container.find(".income-statistics-chart");
    var _$incomeStatisticsCaptionHelper = _$container.find(".sub-title");
    var _incomeStatisticsData = [];
    var _currency = "$";
    var _widgetBase = app.widgetBase.create();

    var chartDateInterval = {
        daily: 1,
        weekly: 2,
        monthly: 3
    };

    var _selectedDateRange = {
        startDate: moment().add(-7, 'days').startOf('day'),
        endDate: moment().endOf("day")
    };

    var getCurrentDateRangeText = function () {
        return _selectedDateRange.startDate.format("L") + " - " + _selectedDateRange.endDate.format("L");
    };

    var getSelectedIncomeStatisticsDatePeriod = function () {
        return parseInt(_$incomeStatisticsDatePeriod.closest(":checked").val());
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

    var drawIncomeStatisticsChart = function (data) {
        var incomeStatisticsChartLastTooltipIndex = null;
        _$incomeStatisticsCaptionHelper.text(getCurrentDateRangeText());
        var chartData = [];
        for (var i = 0; i < data.length; i++) {
            var point = new Array(2);
            point[0] = moment(data[i].date).utc().valueOf(); // data[i].label;
            point[1] = data[i].amount;
            chartData.push(point);
        }

        _incomeStatisticsData = chartData;
        if (!data || data.length === 0) {
            _$incomeStatisticsChartContainer.html(getNoDataInfo());
            return;
        }

        $.plot(_$incomeStatisticsChartContainer,
            [{
                data: chartData,
                lines: {
                    fill: 0.2,
                    lineWidth: 1
                },
                color: ["#BAD9F5"]
            }, {
                data: chartData,
                points: {
                    show: true,
                    fill: true,
                    radius: 4,
                    fillColor: "#9ACAE6",
                    lineWidth: 2
                },
                color: "#9ACAE6",
                shadowSize: 1
            }, {
                data: chartData,
                lines: {
                    show: true,
                    fill: false,
                    lineWidth: 3
                },
                color: "#9ACAE6",
                shadowSize: 0
            }],
            {
                xaxis: {
                    mode: "time",
                    timeformat: app.localize("ChartDateFormat"),
                    minTickSize: [1, "day"],
                    font: {
                        lineHeight: 20,
                        style: "normal",
                        variant: "small-caps",
                        color: "#6F7B8A",
                        size: 10
                    }
                },
                yaxis: {
                    ticks: 5,
                    tickDecimals: 0,
                    tickColor: "#eee",
                    font: {
                        lineHeight: 14,
                        style: "normal",
                        variant: "small-caps",
                        color: "#6F7B8A"
                    }
                },
                grid: {
                    hoverable: true,
                    clickable: false,
                    tickColor: "#eee",
                    borderColor: "#eee",
                    borderWidth: 1,
                    margin: {
                        bottom: 20
                    }
                }
            });

        var removeChartTooltipIfExists = function () {
            var $chartTooltip = $("#chartTooltip");
            if ($chartTooltip.length === 0) {
                return;
            }

            $chartTooltip.remove();
        };

        var showChartTooltip = function (x, y, label, value) {
            removeChartTooltipIfExists();
            $("<div id='chartTooltip' class='chart-tooltip'>" + label + "<br/>" + value + "</div >")
                .css({
                    position: "absolute",
                    display: "none",
                    top: y - 60,
                    left: x - 40,
                    border: "0",
                    padding: "2px 6px",
                    opacity: "0.9"
                })
                .appendTo("body")
                .fadeIn(200);
        };

        _$incomeStatisticsChartContainer.bind("plothover", function (event, pos, item) {
            if (!item) {
                return;
            }

            if (incomeStatisticsChartLastTooltipIndex !== item.dataIndex) {
                var interval = getSelectedIncomeStatisticsDatePeriod();
                var label = "";
                var isSingleDaySelected = _selectedDateRange.startDate.format("L") === _selectedDateRange.endDate.format("L");

                if (interval === chartDateInterval.daily || isSingleDaySelected) {
                    label = moment(item.datapoint[0]).format("dddd, DD MMMM YYYY");
                }
                else {
                    var isLastItem = item.dataIndex === item.series.data.length - 1;
                    label += moment(item.datapoint[0]).format("LL");
                    if (isLastItem) {
                        label += " - " + _selectedDateRange.endDate.format("LL");
                    } else {
                        var nextItem = item.series.data[item.dataIndex + 1];
                        label += " - " + moment(nextItem[0]).format("LL");
                    }
                }

                incomeStatisticsChartLastTooltipIndex = item.dataIndex;
                var value = app.localize("IncomeWithAmount", "<strong>" + item.datapoint[1] + _currency + "</strong>");
                showChartTooltip(item.pageX, item.pageY, label, value);
            }
        });

        _$incomeStatisticsChartContainer.bind("mouseleave", function () {
            incomeStatisticsChartLastTooltipIndex = null;
            removeChartTooltipIfExists();
        });
    };

    var getAndDrawIncomeStatisticsData = function () {
        abp.ui.setBusy(_$container);
        _hostDashboardService
            .getIncomeStatistics({
                startDate: _selectedDateRange.startDate.format("YYYY-MM-DDT00:00:00Z"),
                endDate: _selectedDateRange.endDate.format("YYYY-MM-DDT23:59:59.999Z"),
                incomeStatisticsDateInterval: 1
            })
            .done(function (result) {
                drawIncomeStatisticsChart(result.incomeStatistics);
            }).always(function () {
                abp.ui.clearBusy(_$container);
            });
    };

    var refreshAllData = function () {
        getAndDrawIncomeStatisticsData();
    };


    var initIncomeStatisticsDatePeriod = function () {
        _$container.find("input[name='IncomeStatisticsDatePeriod']").change(function () {
            if (!this.checked) {
                return;
            }
            refreshAllData();
        });
    };

    var initialize = function () {
        initIncomeStatisticsDatePeriod();
        _widgetBase.runDelayed(refreshAllData);
    };

    abp.event.on('app.dashboardFilters.DateRangePicker.OnDateChange', function (dateRange) {
        if (!dateRange || (_selectedDateRange.startDate === dateRange.startDate && _selectedDateRange.endDate === dateRange.endDate)) {
            return;
        }
        _selectedDateRange.startDate = dateRange.startDate;
        _selectedDateRange.endDate = dateRange.endDate;

        _widgetBase.runDelayed(refreshAllData);
    });
    initialize();
});