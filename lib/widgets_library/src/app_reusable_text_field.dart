import 'package:flutter/material.dart';

class AppReusableTextField extends StatelessWidget {
  const AppReusableTextField({
    required TextEditingController controller,
    this.textInputAction = TextInputAction.next,
    this.hintText,
    this.maxLines,
    this.expands = false,
    super.key,
  }) : _controller = controller;

  final TextEditingController _controller;
  final TextInputAction textInputAction;
  final String? hintText;

  /// If [expands] is true, [maxLines] is ignored.
  final int? maxLines;
  final bool expands;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _controller,
      textInputAction: textInputAction,
      expands: expands,
      maxLines: expands ? null : maxLines,
      scrollPhysics: const NeverScrollableScrollPhysics(),
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(horizontal: 15),
        border: InputBorder.none,
        enabledBorder: InputBorder.none,
        focusedBorder: InputBorder.none,
        hintText: hintText,
      ),
    );
  }
}
