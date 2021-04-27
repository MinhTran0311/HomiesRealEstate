(function () {
    app.modals.SelectAnEntityForDynamicPropertyModal = function () {
        var _modalManager;
        this.init = function (modalManager) {
            _modalManager = modalManager;
        };

        this.save = function () {
            var entityFullName = _modalManager.getModal().find("select[name=entityFullName]").val();
            window.location.href = "/App/DynamicEntityProperty/" + entityFullName;
        };
    };
})();