$(function () {
    var _tenantDashboardService = abp.services.app.tenantDashboard;

    var _$Container = $('.RegionalStatsContainer');

    var initRegionalStats = function () {

        _initSparklineChart = function (src, data, color, border) {
            if (src.length === 0) {
                return;
            }

            var config = {
                type: 'line',
                data: {
                    labels: ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October"],
                    datasets: [{
                        label: "",
                        borderColor: color,
                        borderWidth: border,

                        pointHoverRadius: 4,
                        pointHoverBorderWidth: 12,
                        pointBackgroundColor: Chart.helpers.color('#000000').alpha(0).rgbString(),
                        pointBorderColor: Chart.helpers.color('#000000').alpha(0).rgbString(),
                        pointHoverBackgroundColor: '#f4516c',
                        pointHoverBorderColor: Chart.helpers.color('#000000').alpha(0.1).rgbString(),
                        fill: false,
                        data: data,
                    }]
                },
                options: {
                    title: {
                        display: false,
                    },
                    tooltips: {
                        enabled: false,
                        intersect: false,
                        mode: 'nearest',
                        xPadding: 10,
                        yPadding: 10,
                        caretPadding: 10
                    },
                    legend: {
                        display: false,
                        labels: {
                            usePointStyle: false
                        }
                    },
                    responsive: true,
                    maintainAspectRatio: true,
                    hover: {
                        mode: 'index'
                    },
                    scales: {
                        xAxes: [{
                            display: false,
                            gridLines: false,
                            scaleLabel: {
                                display: true,
                                labelString: 'Month'
                            }
                        }],
                        yAxes: [{
                            display: false,
                            gridLines: false,
                            scaleLabel: {
                                display: true,
                                labelString: 'Value'
                            },
                            ticks: {
                                beginAtZero: true
                            }
                        }]
                    },

                    elements: {
                        point: {
                            radius: 4,
                            borderWidth: 12
                        },
                    },

                    layout: {
                        padding: {
                            left: 0,
                            right: 10,
                            top: 5,
                            bottom: 0
                        }
                    }
                }
            };

            return new Chart(src, config);
        };

        var refreshInitregionalStats = function () {
            _tenantDashboardService
                .getRegionalStats({})
                .done(function (result) {
                    for (var i = 0; i < _$Container.length; i++) {
                        var container = $(_$Container[i]);
                
                        var $tableBody = container.find('#region_statistics_content table tbody');
                        for (var rowIndex = 0; rowIndex < result.stats.length; rowIndex++) {
                            var stat = result.stats[rowIndex];
                            var $tr = $('<tr></tr>').append(
                                $(
                                    '<td class="m-datatable__cell--center m-datatable__cell m-datatable__cell--check">' +                                   
                                    '<label class="checkbox checkbox-outline checkbox-outline-2x checkbox-success">' +
                                    '<input type = "checkbox" > <span></span>' +
                                    '</label>' +
                                    '</td>'
                                ),
                                $('<td>' + stat.countryName + '</td>'),
                                $('<td>$' + stat.sales.toFixed(2) + '</td>'),
                                $(
                                    '<td>' +
                                    '<div class="m-widget11__chart" style="height:50px; width: 100px">' +
                                    '<iframe class="chartjs-hidden-iframe" tabindex="-1" style="display: block; overflow: hidden; border: 0px; margin: 0px; top: 0px; left: 0px; bottom: 0px; right: 0px; height: 100%; width: 100%; position: absolute; pointer-events: none; z-index: -1;"></iframe>' +
                                    '<canvas class="m_chart_sales_by_region" style="display: block; width: 100px; height: 50px;" width="100" height="50"></canvas>' +
                                    '</div>' +
                                    '</td>'
                                ),
                                $('<td>$' + stat.averagePrice.toFixed(2) + '</td>'),
                                $('<td>$' + stat.totalPrice.toFixed(2) + '</td>')
                            );

                            $tableBody.append($tr);
                        }

                        var colors = ['#36a3f7', '#f4516c', '#34bfa3', '#ffb822'];
                        var $canvasItems = container.find('canvas.m_chart_sales_by_region');
                        for (var statIndex = 0; statIndex < $canvasItems.length; statIndex++) {
                            var $canvas = $canvasItems[statIndex];
                            self._initSparklineChart($canvas, result.stats[statIndex].change, colors[statIndex % 4], 2);
                        }
                    }
                });
        };

        refreshInitregionalStats();
    };

    initRegionalStats();
});