$(function () {
    var _tenantDashboardService = abp.services.app.tenantDashboard;

    var _$Container = $('.MemberActivityContainer');

    var initMemberActivity = function () {
        var refreshMemberActivity = function () {
            _tenantDashboardService
                .getMemberActivity({})
                .done(function (result) {

                    for (var i = 0; i < _$Container.length; i++) {
                        $(_$Container[i]).find("#memberActivityTable tbody>tr").each(function (index) {
                            var cells = $(this).find("td");
                            var $link = $("<a/>")
                                .attr("href", "javascript:;")
                                .addClass("primary-link")
                                .text(result.memberActivities[index].name);

                            $(cells[1]).empty().append($link);
                            $(cells[2]).html(result.memberActivities[index].cases);
                            $(cells[3]).html(result.memberActivities[index].closed);
                            $(cells[4]).html(result.memberActivities[index].rate);
                            $(cells[5]).html(result.memberActivities[index].rate);
                            $(cells[6]).html(result.memberActivities[index].earnings);
                        });
                    }


                });
        };

        $(".refreshMemberActivityButton").click(function () {
            refreshMemberActivity();
        });

        refreshMemberActivity();
    };

    initMemberActivity();
});