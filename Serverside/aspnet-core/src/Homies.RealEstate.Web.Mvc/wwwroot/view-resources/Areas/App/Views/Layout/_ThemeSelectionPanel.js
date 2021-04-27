$(function () {
    var _uiCustomizationSettingsService = abp.services.app.uiCustomizationSettings;

    var quickSidebarOffCanvas = new KTOffcanvas('kt_theme_selection_panel', {
        baseClass: 'kt-demo-panel',
        closeBy: 'kt-theme_selection_panel_close',
        toggleBy: 'kt_theme_selection_panel_toggle'
    });

    $('#kt_theme_selection_panel .m-scrollable').slimScroll({ destroy: true });
    $('#kt_theme_selection_panel .m-scrollable').slimScroll({
        height: $(window).height() - 20
    });

    $('.theme-selection-link').click(function () {
        var theme = $(this).data('theme');
        
        _uiCustomizationSettingsService.changeThemeWithDefaultValues(theme).done(function () {
            window.location.reload();
        });
    });
});
