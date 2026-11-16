import 'package:flutter/material.dart';
import 'package:news_app/core/theme/app_theme.dart';

import '../../core/router/app_router.dart';
import '../../core/utils/date_formatter.dart';
import '../../data/models/article.dart';
import 'article_image.dart';
import 'bookmark_button.dart';
import 'source_label.dart';

class ArticleTile extends StatelessWidget {
  const ArticleTile({super.key, required this.article});

  final Article article;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final author = article.author;

    return Material(
      color: colors.surface,
      child: InkWell(
        onTap: () => AppRouter.openArticle(context, article),
        child: Padding(
          padding: EdgeInsets.fromLTRB(16, 14, 16, 14),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Article information
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Source and bookmark
                    Row(
                      children: [
                        Expanded(child: SourceLabel(name: article.sourceName)),
                        BookmarkButton(article: article),
                      ],
                    ),

                    SizedBox(height: 10),

                    // Article title
                    Text(
                      article.title,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w800,
                        height: 1.25,
                        letterSpacing: -0.3,
                      ),
                    ),

                    SizedBox(height: 28),

                    Row(
                      children: [
                        if (author != null && author.trim().isNotEmpty) ...[
                          Expanded(
                            child: Text(
                              author.trim(),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: theme.textTheme.bodySmall?.copyWith(
                                color: colors.onSurfaceVariant,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],

                        SizedBox(width: 6),

                        Flexible(
                          child: Text(
                            DateFormatter.relative(article.publishedAt),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: colors.onSurfaceVariant,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              SizedBox(width: 14),

              Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 2),
                    child: ArticleImage(
                      url: article.imageUrl,
                      width: 100,
                      height: 100,
                      radius: 12,
                    ),
                  ),

                  SizedBox(height: 10),

                  Row(
                    children: [
                      Text(
                        'READ MORE',
                        style: theme.textTheme.labelSmall?.copyWith(
                          color: AppTheme.primaryOrange,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 0.6,
                        ),
                      ),
                      
                      SizedBox(width: 3),

                      Icon(
                        Icons.arrow_forward_rounded,
                        size: 13,
                        color: AppTheme.primaryOrange,
                      ),
                    ],
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
