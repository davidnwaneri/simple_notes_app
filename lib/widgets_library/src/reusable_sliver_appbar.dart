// 🐦 Flutter imports:
import 'package:flutter/material.dart';

class ReusableSliverAppBar extends StatelessWidget {
  const ReusableSliverAppBar({
    required this.title,
    this.leading,
    this.actions,
    super.key,
  });

  final String title;
  final Widget? leading;
  final List<Widget>? actions;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar.medium(
      automaticallyImplyLeading: false,
      leading: leading,
      title: Text(title),
      actions: actions,
    );
  }
}
