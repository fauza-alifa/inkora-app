import 'package:flutter/material.dart';

import '../../../../core/utils/date_formatter.dart';
import '../../../../data/models/article.dart';
import '../../../widgets/source_label.dart';

/// Judul artikel + info sumber, penulis, dan waktu terbit.
class DetailHeader extends StatelessWidget {
  const DetailHeader({super.key, required this.article});

  final Article article;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final author = article.author;
    final byline = author == null || author.isEmpty
        ? article.sourceName
        : author;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SourceLabel(name: article.sourceName),
        const SizedBox(height: 8),
        Text(article.title, style: theme.textTheme.headlineSmall),
        const SizedBox(height: 20),
        Row(
          children: [
            CircleAvatar(
              radius: 20,
              backgroundColor: scheme.primaryContainer,
              child: Text(
                byline.characters.first.toUpperCase(),
                style: TextStyle(color: scheme.onPrimaryContainer),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    byline,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.labelLarge,
                  ),
                  Text(
                    DateFormatter.full(article.publishedAt),
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: scheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
