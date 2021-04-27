﻿(function () {
    $(function () {

        var _$paymentHistoryTable = $('#PaymentHistoryTable');
        var _paymentService = abp.services.app.payment;
        var _invoiceService = abp.services.app.invoice;
        var _subscriptionService = abp.services.app.subscription;

        var _dataTable;

        function createDatatable() {
            var dataTable = _$paymentHistoryTable.DataTable({
                paging: true,
                serverSide: true,
                processing: true,
                listAction: {
                    ajaxFunction: _paymentService.getPaymentHistory
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
                        data: null,
                        orderable: false,
                        defaultContent: '',
                        rowAction: {
                            element: $("<button/>")
                                .addClass("btn btn-xs btn-primary")
                                .text(app.localize('ShowInvoice'))
                                .click(function () {
                                    createOrShowInvoice($(this).data());
                                })
                        }
                    },
                    {
                        targets: 2,
                        data: "creationTime",
                        render: function (creationTime) {
                            return moment(creationTime).format('L');
                        }
                    },
                    {
                        targets: 3,
                        data: "editionDisplayName"
                    },
                    {
                        targets: 4,
                        data: "gateway",
                        render: function (gateway) {
                            return app.localize("SubscriptionPaymentGatewayType_" + gateway);
                        }
                    },
                    {
                        targets: 5,
                        data: "amount",
                        render: $.fn.dataTable.render.number(',', '.', 2)
                    },
                    {
                        targets: 6,
                        data: "status",
                        render: function (status) {
                            return app.localize("SubscriptionPaymentStatus_" + status);
                        }
                    },
                    {
                        targets: 7,
                        data: "paymentPeriodType",
                        render: function (paymentPeriodType) {
                            return app.localize("PaymentPeriodType_" + paymentPeriodType);
                        }
                    },
                    {
                        targets: 8,
                        data: "dayCount"
                    },
                    {
                        targets: 9,
                        data: "externalPaymentId"
                    },
                    {
                        targets: 10,
                        data: "invoiceNo"
                    },
                    {
                        targets: 11,
                        visible: false,
                        data: "id"
                    }
                ]
            });

            return dataTable;
        }

        $('a[data-toggle="tab"]').on('shown.bs.tab', function (e) {
            var target = $(e.target).attr("href");
            if (target === '#SubscriptionManagementPaymentHistoryTab') {

                if (_dataTable) {
                    return;
                }

                _dataTable = createDatatable();
            }
        });

        $('#btnDisableRecurringPayments').click(function () {
            abp.ui.setBusy();

            _subscriptionService.disableRecurringPayments({}).done(function () {
                abp.ui.clearBusy();
                $('#btnEnableRecurringPayments').closest("div.form-group").removeClass("d-none");
                $('#btnDisableRecurringPayments').closest("div.form-group").addClass("d-none");
                if ($('#btnExtend')) {
                    $('#btnExtend').removeClass('d-none');
                }
            });
        });

        $('#btnEnableRecurringPayments').click(function () {
            abp.ui.setBusy();

            _subscriptionService.enableRecurringPayments({}).done(function () {
                abp.ui.clearBusy();
                $('#btnDisableRecurringPayments').closest("div.form-group").removeClass("d-none");
                $('#btnEnableRecurringPayments').closest("div.form-group").addClass("d-none");
                $('#btnExtend').addClass('d-none');
            });
        });

        function createOrShowInvoice(data) {
            var invoiceNo = data["invoiceNo"];
            var paymentId = data["id"];

            if (invoiceNo) {
                window.open('/App/Invoice?paymentId=' + paymentId, '_blank');
            } else {
                _invoiceService.createInvoice({
                    subscriptionPaymentId: paymentId
                }).done(function () {
                    _dataTable.ajax.reload();
                    window.open('/App/Invoice?paymentId=' + paymentId, '_blank');
                });
            }
        }
    });
})();