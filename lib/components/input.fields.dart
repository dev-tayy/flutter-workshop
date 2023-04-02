import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatelessWidget {
  final TextInputType? keyboardType;
  final bool obscureText;
  final String? hintText;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final TextCapitalization textCapitalization;
  final int? maxLength;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final bool autocorrect;
  final bool isDense;
  final TextStyle hintStyle;
  final TextStyle textStyle;

  const CustomTextField(
      {Key? key,
      this.keyboardType,
      this.hintText,
      this.obscureText = false,
      this.validator,
      this.maxLength = 30,
      this.controller,
      this.prefixIcon,
      this.autocorrect = false,
      this.suffixIcon,
      this.isDense = false,
      this.hintStyle = const TextStyle(color: Color(0xFF666666), fontSize: 15),
      this.textStyle = const TextStyle(color: Colors.black, fontSize: 20),
      required this.textCapitalization})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: keyboardType,
      obscureText: obscureText,
      controller: controller,
      style: textStyle,
      autocorrect: autocorrect,
      textCapitalization: textCapitalization,
      validator: validator,
      inputFormatters: [
        LengthLimitingTextInputFormatter(maxLength),
      ],
      decoration: InputDecoration(
        isDense: isDense,
        hintText: hintText,
        hintStyle: hintStyle,
        filled: false,
        suffixIcon: suffixIcon,
        prefixIcon: prefixIcon,
        enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.black, width: 0.5)),
        focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.black, width: 0.5)),
      ),
    );
  }
}
