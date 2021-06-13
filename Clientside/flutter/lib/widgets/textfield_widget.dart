import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:boilerplate/stores/theme/theme_store.dart';

class TextFieldWidget extends StatelessWidget {
  final bool isDarkmode;
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
  final bool enable;
  final VoidCallback onEditingComplete;
  final String labelText;
  final Icon suffixIcon;
  final FormFieldValidator<String> errorMessage;
  final Key formKey;

  const TextFieldWidget({
    Key key,
    this.isDarkmode,
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
    this.enable = true,
    this.onEditingComplete,
    this.labelText,
    this.suffixIcon,
    this.errorMessage,
    this.formKey,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Form(
        key: formKey,
        autovalidateMode: AutovalidateMode.always,
        child: TextFormField(
          controller: textController,
          onEditingComplete: this.onEditingComplete,
          focusNode: focusNode,
          onFieldSubmitted: onFieldSubmitted,
          onChanged: onChanged,
          autofocus: autoFocus,
          textInputAction: inputAction,
          obscureText: this.isObscure,
          maxLength: 25,
          keyboardType: this.inputType,
          enabled: this.enable,
          style: GoogleFonts.mavenPro(fontSize: this.inputFontsize),
          decoration: InputDecoration(
              hintText: this.hint,
              hintStyle: GoogleFonts.mavenPro(fontSize:(this.inputFontsize-3),color: hintColor),
                  //Theme.of(context).textTheme.body1.copyWith(color: hintColor),
              errorText: errorText,
              counterText: '',
              icon: this.isIcon ? Icon(this.icon, color: iconColor) : null,
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.red),
              ),
              suffixIcon: IconButton(
                onPressed: () => textController.clear(),
                icon: suffixIcon != null ? suffixIcon : Icon(Icons.clear),
              ),
            labelText: labelText,
            labelStyle: TextStyle(
              color: (isDarkmode != null && isDarkmode) ? Colors.white : Colors.black,
            ),
          ),
          validator: errorMessage,
        ),
      ),
    );
  }
}
