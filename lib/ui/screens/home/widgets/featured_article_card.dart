import 'package:flutter/material.dart';

import '../../../../core/router/app_router.dart';
import '../../../../core/utils/date_formatter.dart';
import '../../../../data/models/article.dart';
import '../../../widgets/article_image.dart';
import '../../../widgets/bookmark_button.dart';
import '../../../widgets/source_label.dart';

/// Kartu berita utama dengan tampilan editorial.
class FeaturedArticleCard extends StatelessWidget {
  const FeaturedArticleCard({super.key, required this.article});

  final Article article;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    final description = article.description;

    return Material(
      color: colors.surface,
      child: InkWell(
        onTap: () => AppRouter.openArticle(context, article),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Featured image
              AspectRatio(
                aspectRatio: 16 / 9,
                child: ArticleImage(url: article.imageUrl, radius: 16),
              ),

              const SizedBox(height: 16),

              // Source and bookmark
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(child: SourceLabel(name: article.sourceName)),
                  BookmarkButton(article: article),
                ],
              ),

              const SizedBox(height: 8),

              // Article title
              Text(
                article.title,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: theme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w800,
                  height: 1.2,
                  letterSpacing: -0.4,
                ),
              ),

              // Article description
              if (description != null && description.trim().isNotEmpty) ...[
                const SizedBox(height: 10),
                Text(
                  description,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: colors.onSurfaceVariant,
                    height: 1.5,
                  ),
                ),
              ],

              const SizedBox(height: 14),

              // Publication date
              Row(
                children: [
                  Icon(
                    Icons.access_time_rounded,
                    size: 14,
                    color: colors.onSurfaceVariant,
                  ),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      DateFormatter.relative(article.publishedAt),
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: colors.onSurfaceVariant,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Text(
                    'READ MORE',
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: colors.primary,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 0.8,
                    ),
                  ),
                  const SizedBox(width: 4),
                  Icon(
                    Icons.arrow_forward_rounded,
                    size: 14,
                    color: colors.primary,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
