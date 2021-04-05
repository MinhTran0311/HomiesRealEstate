$(function () {

    var _hostDashboardService = abp.services.app.hostDashboard;
    var _$container = $(".HostTopStatsContainer");
    var _$newTenantsStatusTitle = _$container.find(".new-tenants-statistics .status-title");
    var _$newTenantsStatisticsCountPlaceholder = _$container.find(".new-tenants-statistics .new-tenants-count");
    var _$newSubscriptionAmountTitle = _$container.find(".new-subscription-statistics .status-title");
    var _$newSubscriptionAmountPlaceholder = _$container.find(".new-subscription-statistics .new-subscription-amount");
    var _$dashboardStatisticsPlaceholder1 = _$container.find(".dashboard-statistics1 .dashboard-placeholder1");
    var _$dashboardStatisticsPlaceholder2 = _$container.find(".dashboard-statistics2 .dashboard-placeholder2");
    var _$counterUp = _$container.find(".counterup");
    var _currency = "$";
    var _widgetBase = app.widgetBase.create();

    var _selectedDateRange = {
        startDate: moment().add(-7, 'days').startOf('day'),
        endDate: moment().endOf("day")
    };

    var getCurrentDateRangeText = function () {
        return _selectedDateRange.startDate.format("L") + " - " + _selectedDateRange.endDate.format("L");
    };

    var writeNewTenantsCount = function (newTenantsCount) {
        _$newTenantsStatusTitle.text(getCurrentDateRangeText());
        _$newTenantsStatisticsCountPlaceholder.text(newTenantsCount);
    };

    var writeNewSubscriptionsAmount = function (newSubscriptionAmount) {
        _$newSubscriptionAmountTitle.text(getCurrentDateRangeText());
        _$newSubscriptionAmountPlaceholder.text(newSubscriptionAmount);
    };

    //this is a sample placeholder. You can put your own statistics here.
    var writeDashboardPlaceholder1 = function (value) {
        _$dashboardStatisticsPlaceholder1.text(value);
    };

    //this is a sample placeholder. You can put your own statistics here.
    var writeDashboardPlaceholder2 = function (value) {
        _$dashboardStatisticsPlaceholder2.text(value);
    };

    var animateCounterUpNumbers = function () {
        _$counterUp.counterUp();
    };

    var getTopStatsData = function () {
        abp.ui.setBusy(_$container);
        _hostDashboardService
            .getTopStatsData({
                startDate: _selectedDateRange.startDate,
                endDate: _selectedDateRange.endDate
            })
            .done(function (result) {
                writeNewTenantsCount(result.newTenantsCount);
                writeNewSubscriptionsAmount(result.newSubscriptionAmount);
                writeDashboardPlaceholder1(result.dashboardPlaceholder1);
                writeDashboardPlaceholder2(result.dashboardPlaceholder2);
                animateCounterUpNumbers();
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

        _widgetBase.runDelayed(getTopStatsData);
    });

    _widgetBase.runDelayed(getTopStatsData);
});