import 'package:flutter/material.dart';

import '../../../../data/models/article.dart';

/// Ringkasan + cuplikan isi artikel.
///
/// NewsAPI hanya mengembalikan ±200 karakter konten, jadi kita tampilkan
/// catatan agar user membaca versi lengkap di situs sumber.
class DetailContent extends StatelessWidget {
  const DetailContent({super.key, required this.article});

  final Article article;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final description = article.description ?? '';
    final content = article.cleanContent;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (description.isNotEmpty)
          Text(
            description,
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w500,
              height: 1.5,
            ),
          ),
        if (content.isNotEmpty && content != description) ...[
          const SizedBox(height: 16),
          Text(content, style: theme.textTheme.bodyLarge),
        ],
        const SizedBox(height: 24),
        Card.filled(
          color: scheme.surfaceContainerHigh,
          margin: EdgeInsets.zero,
          child: ListTile(
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 4,
            ),
            leading: Icon(Icons.info_outline_rounded, color: scheme.primary),
            title: Text(
              'Ini adalah cuplikan. Baca artikel lengkap di situs '
              '${article.sourceName}.',
              style: theme.textTheme.bodyMedium,
            ),
          ),
        ),
      ],
    );
  }
}
