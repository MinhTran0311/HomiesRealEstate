(function () {
    app.modals.CreateOrEditWebhookSubscriptionModal = function () {
        var _modalManager;
        var _webhookSubscriptionService = abp.services.app.webhookSubscription;
        var _headerKeyValueManager = new KeyValueListManager();

        this.init = function (modalManager) {
            _modalManager = modalManager;
            _modalManager.getModal().find('#Webhooks').select2();
            initializeHeaderKeyValueManager();
        };

        this.save = function () {
            var headers = {};
            _headerKeyValueManager.getValues().forEach(x => {
                headers[x.key] = x.value;
            });
            
            var subscription = {
                id: _modalManager.getModal().find("input[name=Id]").val(),
                webhookUri: _modalManager.getModal().find("#webhookEndpointURL").val(),
                webhooks: _modalManager.getModal().find("#Webhooks").val(),
                headers: headers
            };

            _modalManager.setBusy(true);

            if (createOrEditIsEdit) {
                _webhookSubscriptionService.updateSubscription(subscription)
                    .done(function () {
                        abp.notify.info(app.localize('SavedSuccessfully'));
                        _modalManager.close();
                        abp.event.trigger('app.createOrEditWebhookSubscriptionModalSaved');
                    }).always(function () {
                    _modalManager.setBusy(false);
                });
            } else {
                _webhookSubscriptionService.addSubscription(subscription)
                    .done(function () {
                        abp.notify.info(app.localize('SavedSuccessfully'));
                        _modalManager.close();
                        abp.event.trigger('app.createOrEditWebhookSubscriptionModalSaved');
                    }).always(function () {
                    _modalManager.setBusy(false);
                });
            }
        };

        function initializeHeaderKeyValueManager() {
            var keys = Object.keys(createOrEditHeaders);
            var items = [];
            if (createOrEditHeaders && keys.length > 0) {
                items = keys.map(x => {
                    return {
                        key: x,
                        value: createOrEditHeaders[x]
                    };
                });
            }
            
            _headerKeyValueManager.init({
                containerId: "additional-header-list",
                name: "openIdConnectClaimsMappings",
                keyName: "HeaderKey",
                valueName: "HeaderValue",
                items: items,
            });
        }
    };
})();