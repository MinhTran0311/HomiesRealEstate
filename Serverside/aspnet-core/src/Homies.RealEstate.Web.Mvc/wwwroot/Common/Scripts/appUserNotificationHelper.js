﻿var app = app || {};
(function ($) {

    app.UserNotificationHelper = (function () {

        return function () {

            /* Message Extracting based on Notification Data Type ********/

            //add your custom notification data types here...

            /* Example:
            abp.notifications.messageFormatters['Homies.RealEstate.MyNotificationDataType'] = function(userNotification) {
                return ...; //format and return message here
            };
            */

            var _notificationService = abp.services.app.notification;

            /* Converter functions ***************************************/

            function getUrl(userNotification) {
                switch (userNotification.notification.notificationName) {
                    case 'App.NewUserRegistered':
                        return '/App/users?filterText=' + userNotification.notification.data.properties.emailAddress;
                    case 'App.NewTenantRegistered':
                        return '/App/tenants?filterText=' + userNotification.notification.data.properties.tenancyName;
                    case 'App.GdprDataPrepared':
                        return '/File/DownloadBinaryFile?id=' + userNotification.notification.data.properties.binaryObjectId + '&contentType=application/zip&fileName=collectedData.zip';
                    case 'App.DownloadInvalidImportUsers':
                        return '/File/DownloadTempFile?fileToken=' + userNotification.notification.data.properties.fileToken + '&fileType=' + userNotification.notification.data.properties.fileType + '&fileName=' + userNotification.notification.data.properties.fileName;
                        //Add your custom notification names to navigate to a URL when user clicks to a notification.
                }

                //No url for this notification
                return '#';
            };

            /* PUBLIC functions ******************************************/

            var format = function (userNotification, truncateText) {
                var formatted = {
                    userNotificationId: userNotification.id,
                    text: abp.notifications.getFormattedMessageFromUserNotification(userNotification),
                    time: moment(userNotification.notification.creationTime).format("YYYY-MM-DD HH:mm:ss"),
                    icon: app.notification.getUiIconBySeverity(userNotification.notification.severity),
                    state: abp.notifications.getUserNotificationStateAsString(userNotification.state),
                    data: userNotification.notification.data,
                    url: getUrl(userNotification),
                    isUnread: userNotification.state === abp.notifications.userNotificationState.UNREAD,
                    timeAgo: moment(userNotification.notification.creationTime).fromNow(),
                    iconFontClass: app.notification.getIconFontClassBySeverity(userNotification.notification.severity)
                };

                if (truncateText || truncateText === undefined) {
                    formatted.text = abp.utils.truncateStringWithPostfix(formatted.text, 50);
                }
                
                return formatted;
            };

            var show = function (userNotification) {
                //Application notification
                abp.notifications.showUiNotifyForUserNotification(userNotification, {
                    'onclick': function () {
                        //Take action when user clicks to live toastr notification
                        var url = getUrl(userNotification);
                        if (url) {
                            location.href = url;
                        }
                    }
                });

                //Desktop notification
                Push.create("RealEstate", {
                    body: format(userNotification).text,
                    icon: abp.appPath + 'Common/Images/app-logo-small.svg',
                    timeout: 6000,
                    onClick: function () {
                        window.focus();
                        this.close();
                    }
                });
            };

            var setAllAsRead = function (callback) {
                _notificationService.setAllNotificationsAsRead().done(function () {
                    abp.event.trigger('app.notifications.refresh');
                    callback && callback();
                });
            };

            var setAsRead = function (userNotificationId, callback) {
                _notificationService.setNotificationAsRead({
                    id: userNotificationId
                }).done(function () {
                    abp.event.trigger('app.notifications.read', userNotificationId);
                    callback && callback(userNotificationId);
                });
            };

            var openSettingsModal = function () {
                new app.ModalManager({
                    viewUrl: abp.appPath + 'App/Notifications/SettingsModal',
                    scriptUrl: abp.appPath + 'view-resources/Areas/App/Views/Notifications/_SettingsModal.js',
                    modalClass: 'NotificationSettingsModal'
                }).open();
            };

            /* Expose public API *****************************************/

            return {
                format: format,
                show: show,
                setAllAsRead: setAllAsRead,
                setAsRead: setAsRead,
                openSettingsModal: openSettingsModal
            };

        };

    })();

})(jQuery);
