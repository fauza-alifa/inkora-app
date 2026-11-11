import 'package:flutter/material.dart';

import '../../core/router/app_router.dart';
import '../../core/utils/date_formatter.dart';
import '../../data/models/article.dart';
import 'article_image.dart';
import 'bookmark_button.dart';
import 'source_label.dart';

/// Item daftar berita: teks di kiri, thumbnail di kanan.
class ArticleTile extends StatelessWidget {
  const ArticleTile({super.key, required this.article});

  final Article article;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return InkWell(
      onTap: () => AppRouter.openArticle(context, article),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 14, 16, 6),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SourceLabel(name: article.sourceName),
                  const SizedBox(height: 6),
                  Text(
                    article.title,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.titleMedium,
                  ),
                  Row(
                    children: [
                      Text(
                        DateFormatter.relative(article.publishedAt),
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                      const Spacer(),
                      BookmarkButton(article: article),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(width: 16),
            ArticleImage(url: article.imageUrl, width: 92, height: 92),
          ],
        ),
      ),
    );
  }
}
