import 'package:boilerplate/constants/strings.dart';
import 'package:boilerplate/widgets/rounded_button_widget.dart';
import 'package:flushbar/flushbar_helper.dart';
import 'package:flutter/material.dart';


dynamic showErrorMessage(String message, BuildContext context) {
  Future.delayed(Duration(milliseconds: 0), () {
    if (message != null && message.isNotEmpty) {
      FlushbarHelper.createError(
        message: message,
        title: "Lỗi",
        duration: Duration(seconds: 4),
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
        duration: Duration(seconds: 4),
      )
          .show(context);
    }
    return SizedBox.shrink();
  });
}

String translateErrorMessage(String error){
  print(error);
  if (Strings.errorString.containsKey(error))
    return Strings.errorString[error];
  else
    return "Hãy kiểm tra lại !";
}

Future<dynamic> showSimpleModalDialog(context, String message) {
  return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Thông báo"),
          content: Text(message),
          actions:<Widget>[
          TextButton(
            child: Text('Xác nhận'),
            onPressed: () async {
            Navigator.of(context).pop(true);
            },
          ),
          TextButton(
            child: Text('Hủy'),
            onPressed: () {
                Navigator.of(context).pop(false);
            },
          ),
        ]);
      }
    );
}
