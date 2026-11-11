import 'package:flutter/material.dart';

import '../../../../core/router/app_router.dart';
import '../../../../core/utils/date_formatter.dart';
import '../../../../data/models/article.dart';
import '../../../widgets/article_image.dart';
import '../../../widgets/bookmark_button.dart';
import '../../../widgets/source_label.dart';

/// Kartu besar untuk berita utama (artikel pertama).
class FeaturedArticleCard extends StatelessWidget {
  const FeaturedArticleCard({super.key, required this.article});

  final Article article;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final description = article.description;

    return InkWell(
      onTap: () => AppRouter.openArticle(context, article),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AspectRatio(
              aspectRatio: 16 / 9,
              child: ArticleImage(url: article.imageUrl, radius: 20),
            ),
            const SizedBox(height: 14),
            SourceLabel(name: article.sourceName),
            const SizedBox(height: 6),
            Text(article.title, style: theme.textTheme.titleLarge),
            if (description != null && description.isNotEmpty) ...[
              const SizedBox(height: 8),
              Text(
                description,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
            ],
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
    );
  }
}
