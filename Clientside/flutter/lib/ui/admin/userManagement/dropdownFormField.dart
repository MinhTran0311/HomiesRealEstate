import 'package:flutter/material.dart';

class DropdownFormField extends StatefulWidget {
  @override
  _DropdownFormFieldState createState() => _DropdownFormFieldState();
}

/// This is the private State class that goes with MyStatefulWidget.
class _DropdownFormFieldState extends State<DropdownFormField> {
  String dropdownRoleValue = 'One';


  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: dropdownRoleValue,
      icon: const Icon(Icons.arrow_downward),
      iconSize: 24,
      elevation: 16,
      hint: Text("Chọn vai trò"),
      style: const TextStyle(color: Colors.deepPurple),
      // underline: Container(
      //   height: 2,
      //   color: Colors.deepPurpleAccent,
      // ),
      onChanged: (String newValue) {
        setState(() {
          dropdownRoleValue = newValue;
        });
      },
      onSaved: (String newValue) {
        setState(() {
          dropdownRoleValue = newValue;
        });
      },
      items: <String>['One', 'Two', 'Free', 'Four']
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}
