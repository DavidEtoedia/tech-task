import 'package:flutter/material.dart';

class TextFormInput extends StatelessWidget {
  const TextFormInput(
      {Key? key,
      required this.controller,
      this.labelText,
      this.obscureText = false,
      this.suffixIcon,
      this.prefixIcon,
      this.onChanged,
      this.onTap,
      this.enabled,
      this.textLength,
      this.isColor = Colors.black,
      this.fillColor = Colors.white,
      this.horizontal = 20,
      this.filled = false,
      this.readOnly = false,
      this.borderRadius = 6,
      this.keyboardType})
      : super(key: key);

  final String? labelText;
  final bool obscureText;
  final Widget? suffixIcon;
  final bool? enabled;
  final bool readOnly;
  final bool filled;
  final double borderRadius;
  final Widget? prefixIcon;
  final Color isColor;
  final Color fillColor;
  final TextInputType? keyboardType;
  final TextEditingController controller;
  final int? textLength;
  final void Function(String)? onChanged;
  final void Function()? onTap;
  final double horizontal;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enabled: enabled,
      controller: controller,
      cursorColor: isColor,
      readOnly: readOnly,
      textCapitalization: TextCapitalization.words,
      obscureText: obscureText,
      style: Theme.of(context).textTheme.labelSmall?.copyWith(
          color: Colors.black,
          fontSize: 16,
          letterSpacing: 0.5,
          fontWeight: FontWeight.w400),
      textInputAction: TextInputAction.done,
      keyboardType: keyboardType,
      onChanged: onChanged,
      decoration: InputDecoration(
          fillColor: fillColor,
          filled: filled,
          errorStyle: Theme.of(context).textTheme.labelSmall?.copyWith(
              height: 0.2, color: Colors.red, letterSpacing: 0.5, fontSize: 0),
          suffixIcon: suffixIcon,
          prefixIcon: prefixIcon,
          prefixIconConstraints: const BoxConstraints(
            minWidth: 25,
            minHeight: 21,
          ),
          iconColor: Colors.grey,
          focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius),
              borderSide: const BorderSide(
                width: 0.5,
                color: Colors.black,
              )
              //<-- SEE HERE
              ),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius),
              borderSide: const BorderSide(
                color: Colors.black,
                width: 0.5,
              )),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius),
              borderSide: BorderSide(
                color: Colors.black.withOpacity(0.5),
                width: 0.5,
              )),
          contentPadding:
              EdgeInsets.symmetric(vertical: 15, horizontal: horizontal),
          floatingLabelBehavior: FloatingLabelBehavior.never,
          hintText: labelText,
          hintStyle: Theme.of(context).textTheme.labelMedium?.copyWith(
              color: Colors.black38,
              fontSize: 15,
              fontWeight: FontWeight.w400,
              letterSpacing: 0.0),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius),
              borderSide: const BorderSide(
                color: Colors.black,
                width: 0.5,
              ))),
      onTap: onTap,
    );
  }
}
