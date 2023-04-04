import 'package:flutter/material.dart';

class ReusableSliverAppBar extends StatelessWidget {
  const ReusableSliverAppBar({
    required this.title,
    super.key,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar.medium(
      title: Text(title),
      automaticallyImplyLeading: false,
    );
  }
}
