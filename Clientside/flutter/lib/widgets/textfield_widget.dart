import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextFieldWidget extends StatelessWidget {
  final IconData icon;
  final String hint;
  final String errorText;
  final bool isObscure;
  final bool isIcon;
  final TextInputType inputType;
  final TextEditingController textController;
  final EdgeInsets padding;
  final Color hintColor;
  final Color iconColor;
  final FocusNode focusNode;
  final ValueChanged onFieldSubmitted;
  final ValueChanged onChanged;
  final bool autoFocus;
  final TextInputAction inputAction;
  final double inputFontsize;

  const TextFieldWidget({
    Key key,
    this.icon,
    this.hint,
    this.errorText,
    this.isObscure = false,
    this.inputType,
    this.textController,
    this.isIcon = true,
    this.padding = const EdgeInsets.all(0),
    this.hintColor = Colors.grey,
    this.iconColor = Colors.grey,
    this.focusNode,
    this.onFieldSubmitted,
    this.onChanged,
    this.autoFocus = false,
    this.inputAction,
    this.inputFontsize=20,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: TextFormField(
        controller: textController,
        focusNode: focusNode,
        onFieldSubmitted: onFieldSubmitted,
        onChanged: onChanged,
        autofocus: autoFocus,
        textInputAction: inputAction,
        obscureText: this.isObscure,
        maxLength: 25,
        keyboardType: this.inputType,
        style: GoogleFonts.mavenPro(fontSize: this.inputFontsize,color: Colors.white),
        decoration: InputDecoration(
            hintText: this.hint,
            hintStyle: GoogleFonts.mavenPro(fontSize: (this.inputFontsize-3),color: Colors.white),
                //Theme.of(context).textTheme.body1.copyWith(color: hintColor),
            errorText: errorText,
            counterText: '',
            icon: this.isIcon ? Icon(this.icon, color: iconColor) : null),
      ),
    );
  }

}
