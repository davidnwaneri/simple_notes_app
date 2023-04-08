import 'dart:math' as math;

import 'package:flutter/material.dart';

part 'custom_outline_input_border.dart';

class AppReusableTextField extends StatelessWidget {
  const AppReusableTextField({
    required TextEditingController controller,
    this.textInputAction = TextInputAction.next,
    this.textInputType,
    this.contentPadding = const EdgeInsets.symmetric(horizontal: 15),
    this.suffixIcon,
    this.hintText,
    this.labelText,
    this.maxLines = 1,
    this.expands = false,
    this.hideText = false,
    this.outlined = false,
    this.validate = false,
    this.validator,
    super.key,
  }) : _controller = controller;

  final TextEditingController _controller;
  final TextInputAction textInputAction;
  final TextInputType? textInputType;
  final EdgeInsetsGeometry? contentPadding;
  final Widget? suffixIcon;
  final String? hintText;
  final String? labelText;

  /// If [expands] is true, [maxLines] is ignored.
  final int? maxLines;
  final bool expands;
  final bool hideText;
  final bool outlined;
  final bool validate;
  final String? Function(String?)? validator;

  InputBorder get _border => InputBorder.none;

  @override
  Widget build(BuildContext context) {
    if (outlined) {
      return AppOutlinedReusableTextField(
        key: key,
        controller: _controller,
        textInputAction: textInputAction,
        textInputType: textInputType,
        contentPadding: contentPadding,
        hintText: hintText,
        labelText: labelText,
        hideText: hideText,
        suffixIcon: suffixIcon,
        validate: validate,
        validator: validator,
      );
    }
    return TextFormField(
      controller: _controller,
      obscureText: hideText,
      textInputAction: textInputAction,
      expands: expands,
      maxLines: expands ? null : maxLines,
      scrollPhysics: const NeverScrollableScrollPhysics(),
      decoration: InputDecoration(
        contentPadding: contentPadding,
        border: _border,
        enabledBorder: _border,
        focusedBorder: _border,
        hintText: hintText,
        labelText: labelText,
      ),
    );
  }
}

class AppOutlinedReusableTextField extends StatelessWidget {
  const AppOutlinedReusableTextField({
    required TextEditingController controller,
    this.textInputAction,
    this.textInputType,
    this.contentPadding,
    this.suffixIcon,
    this.hintText,
    this.labelText,
    this.hideText = false,
    this.validate = false,
    this.validator,
    super.key,
  }) : _controller = controller;

  final TextEditingController _controller;
  final TextInputAction? textInputAction;
  final TextInputType? textInputType;
  final EdgeInsetsGeometry? contentPadding;
  final Widget? suffixIcon;
  final String? hintText;
  final String? labelText;
  final bool hideText;
  final bool validate;
  final String? Function(String?)? validator;

  InputBorder get _border {
    return CustomOutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: const BorderSide(style: BorderStyle.none),
    );
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _controller,
      obscureText: hideText,
      obscuringCharacter: '●',
      textInputAction: textInputAction,
      keyboardType: textInputType,
      decoration: InputDecoration(
        contentPadding: contentPadding,
        filled: true,
        border: _border,
        enabledBorder: _border,
        focusedBorder: _border,
        hintText: hintText,
        labelText: labelText,
        suffixIcon: suffixIcon,
      ),
      validator: validate ? validator : null,
    );
  }
}
