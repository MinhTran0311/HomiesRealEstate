import 'package:flushbar/flushbar_helper.dart';
import 'package:flutter/material.dart';


dynamic showErrorMessage(String message, BuildContext context) {
  Future.delayed(Duration(milliseconds: 0), () {
    if (message != null && message.isNotEmpty) {
      FlushbarHelper.createError(
        message: message,
        title: "Lỗi",
        duration: Duration(seconds: 3),
      )..show(context);
    }
  });
  return SizedBox.shrink();
}

dynamic showSuccssfullMesssage(String message, BuildContext context) {
  Future.delayed(Duration(milliseconds: 0), () {
    if (message != null && message.isNotEmpty) {
      FlushbarHelper.createSuccess(
        message: message,
        title: "Thông báo",
        duration: Duration(seconds: 3),
      )
          .show(context);
    }
    return SizedBox.shrink();
  });
}
