import 'package:flutter/material.dart';

/// Label nama sumber berita (mis. "BBC News") berwarna primary.
class SourceLabel extends StatelessWidget {
  const SourceLabel({super.key, required this.name});

  final String name;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Text(
      name,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: theme.textTheme.labelMedium?.copyWith(
        color: theme.colorScheme.primary,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.2,
      ),
    );
  }
}
