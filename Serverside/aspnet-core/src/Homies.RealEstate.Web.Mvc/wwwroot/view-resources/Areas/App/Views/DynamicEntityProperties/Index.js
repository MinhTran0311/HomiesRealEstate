(function () {
    $(function () {
        var _table = $('#DynamicEntityPropertiesTable');
        var _dynamicEntityPropertyAppService = abp.services.app.dynamicEntityProperty;

        var _createModal = new app.ModalManager({
            viewUrl: abp.appPath + 'App/DynamicEntityProperty/CreateModal',
            scriptUrl: abp.appPath + 'view-resources/Areas/App/Views/DynamicEntityProperties/_CreateModal.js',
            modalClass: 'CreateDynamicEntityPropertyModal',
            cssClass: 'scrollable-modal'
        });

        var _permissions = {
            delete: abp.auth.hasPermission('Pages.Administration.DynamicEntityProperties.Delete')
        };

        $('#CreateNewDynamicEntityProperty').click(function () {
            _createModal.open({entityFullName: $("input[name=entity-full-name]").val()});
        });

        $('#GetDynamicEntityPropertiesButton').click(function (e) {
            e.preventDefault();
            loadDynamicEntityProperties();
        });

        var _dataTable = _table.DataTable({
            paging: false,
            serverSide: false,
            processing: false,
            listAction: {
                ajaxFunction: _dynamicEntityPropertyAppService.getAllPropertiesOfAnEntity,
                inputFilter: function () {
                    return {
                        entityFullName: $("input[name=entity-full-name]").val()
                    };
                }
            },
            columnDefs: [
                {
                    className: 'control responsive',
                    orderable: false,
                    render: function () {
                        return '';
                    },
                    targets: 0
                },             
                {
                    targets: 1,
                    orderable: false,
                    data: "dynamicPropertyName",
                },
                {
                    targets: 2,
                    data: null,
                    orderable: false,
                    defaultContent: '',
                    visible: _permissions.delete,
                    rowAction: {
                        element: $("<button/>")
                            .addClass("btn btn-danger")
                            .text(app.localize('Delete'))
                            .click(function () {
                                deleteDynamicEntityProperty($(this).data());
                            })
                    }
                }
            ]
        });

        function loadDynamicEntityProperties() {
            _dataTable.ajax.reload();
        }

        abp.event.on('app.createOrEditDynamicEntityPropertiesModalSaved', function () {
            loadDynamicEntityProperties();
        });

        function deleteDynamicEntityProperty(data) {
            abp.message.confirm(
                app.localize('DeleteDynamicEntityPropertyMessage', data.entityFullName, data.dynamicPropertyName),
                app.localize('AreYouSure'),
                function (isConfirmed) {
                    if (isConfirmed) {
                        abp.ui.setBusy();
                        _dynamicEntityPropertyAppService.delete(data.id)
                            .done(function () {
                                loadDynamicEntityProperties();
                                abp.notify.success(
                                    app.localize('SuccessfullyDeleted')
                                );
                            })
                            .always(function () {
                                abp.ui.clearBusy();
                            });
                    }
                }
            );
        }
    });
})();
