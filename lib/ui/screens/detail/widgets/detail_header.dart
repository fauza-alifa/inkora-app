import 'package:flutter/material.dart';
import 'package:news_app/core/theme/app_theme.dart';

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
    final isDark = theme.brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SourceLabel(name: article.sourceName),
        SizedBox(height: 8),
        Text(article.title, style: theme.textTheme.headlineSmall),
        SizedBox(height: 20),
        Row(
          children: [
            CircleAvatar(
              radius: 20,
              backgroundColor: AppTheme.primaryOrange,
              child: Text(
                byline.isNotEmpty ? byline.characters.first.toUpperCase() : '?',
                style: TextStyle(
                  color: isDark ? AppTheme.inkoraBlue : Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(width: 12),
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
