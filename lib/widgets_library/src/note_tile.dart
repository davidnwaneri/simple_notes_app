import 'package:flutter/material.dart';
import 'package:simple_notes_app/core/extensions.dart';

class NoteTile extends StatelessWidget {
  const NoteTile({
    required this.title,
    required this.shortInfo,
    required this.lastModified,
    super.key,
  });

  final String title;
  final String shortInfo;
  final String lastModified;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 8,
          vertical: 16,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: context.textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              shortInfo,
              style: context.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w300,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 10),
            Text(
              'Last modified: $lastModified',
              style: context.textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }
}
