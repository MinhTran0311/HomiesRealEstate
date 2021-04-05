$(function () {
    var _tenantDashboardService = abp.services.app.tenantDashboard;

    var _$Container = $('.ProfitShareContainer');

    //== Profit Share Chart.
    //** Based on Chartist plugin - https://gionkunz.github.io/chartist-js/index.html
    var profitShare = function (data) {
        for (var i = 0; i < _$Container.length; i++) {
            var $chart = $(_$Container[i]).find('.kt_chart_profit_share');
            $(_$Container[i]).find('.kt_chart_profit_share').attr('id', 'kt_chart_profit_share' + i);

            if ($chart.length === 0) {
                return;
            }

            var $chartItems = _$Container.find('.kt-widget14__legend-text');

            $($chartItems[0]).text(data[0] + '% Product Sales');
            $($chartItems[1]).text(data[1] + '% Online Courses');
            $($chartItems[2]).text(data[2] + '% Custom Development');

            var chart = new Chartist.Pie('#kt_chart_profit_share' + i, {
                series: [{
                    value: data[0],
                    className: 'custom',
                    meta: {
                        color: '#716aca'
                    }
                },
                {
                    value: data[1],
                    className: 'custom',
                    meta: {
                        color: '#36a3f7'
                    }
                },
                {
                    value: data[2],
                    className: 'custom',
                    meta: {
                        color: '#ffb822'
                    }
                }
                ],
                labels: [1, 2, 3]
            },
                {
                    donut: true,
                    donutWidth: 17,
                    showLabel: false
                });

            chart.on('draw', function (data) {
                if (data.type === 'slice') {
                    // Get the total path length in order to use for dash array animation
                    var pathLength = data.element._node.getTotalLength();

                    // Set a dasharray that matches the path length as prerequisite to animate dashoffset
                    data.element.attr({
                        'stroke-dasharray': pathLength + 'px ' + pathLength + 'px'
                    });

                    // Create animation definition while also assigning an ID to the animation for later sync usage
                    var animationDefinition = {
                        'stroke-dashoffset': {
                            id: 'anim' + data.index,
                            dur: 1000,
                            from: -pathLength + 'px',
                            to: '0px',
                            easing: Chartist.Svg.Easing.easeOutQuint,
                            // We need to use `fill: 'freeze'` otherwise our animation will fall back to initial (not visible)
                            fill: 'freeze',
                            'stroke': data.meta.color
                        }
                    };

                    // If this was not the first slice, we need to time the animation so that it uses the end sync event of the previous animation
                    if (data.index !== 0) {
                        animationDefinition['stroke-dashoffset'].begin = 'anim' + (data.index - 1) + '.end';
                    }

                    // We need to set an initial value before the animation starts as we are not in guided mode which would do that for us

                    data.element.attr({
                        'stroke-dashoffset': -pathLength + 'px',
                        'stroke': data.meta.color
                    });

                    // We can't use guided mode as the animations need to rely on setting begin manually
                    // See http://gionkunz.github.io/chartist-js/api-documentation.html#chartistsvg-function-animate
                    data.element.animate(animationDefinition, false);
                }
            });
        }
    };

    var getProfitShare = function () {
        _tenantDashboardService
            .getProfitShare()
            .done(function (result) {
                profitShare(result.profitShares);
            });
    };

    getProfitShare();
});