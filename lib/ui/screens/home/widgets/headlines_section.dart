import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_app/providers/headlines_provider.dart';
import 'package:news_app/ui/widgets/empty_state.dart';
import 'package:news_app/ui/widgets/error_state.dart';
import 'package:news_app/ui/widgets/loading_skeleton.dart';

import '../../../widgets/article_tile.dart';
import 'featured_article_card.dart';

class HeadlinesSection extends ConsumerWidget {
  const HeadlinesSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final category = ref.watch(selectedCategoryProvider);
    final headlines = ref.watch(headlinesProvider(category));
    final colors = Theme.of(context).colorScheme;

    return headlines.when(
      loading: () => SliverToBoxAdapter(child: LoadingSkeleton()),
      error: (error, _) => SliverFillRemaining(
        hasScrollBody: false,
        child: ErrorState(
          error: error,
          onRetry: () {
            ref.invalidate(headlinesProvider(category));
          },
        ),
      ),
      data: (articles) {
        if (articles.isEmpty) {
          return SliverFillRemaining(
            hasScrollBody: false,
            child: EmptyState(
              icon: Icons.newspaper_rounded,
              title: 'Belum ada berita',
              message: 'Coba pilih kategori lain atau tarik untuk refresh.',
            ),
          );
        }

        return SliverMainAxisGroup(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.fromLTRB(16, 20, 16, 14),
                child: Row(
                  children: [
                    SizedBox(width: 10),
                    Text(
                      'LATEST STORIES',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 1.5,
                        color: colors.onSurface,
                      ),
                    ),
                    Spacer(),
                    Text(
                      '${articles.length} ARTICLES',
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.8,
                        color: colors.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Container(height: 2, color: colors.onSurface),
              ),
            ),

            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.only(top: 8),
                child: FeaturedArticleCard(article: articles.first),
              ),
            ),

            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Divider(thickness: 2, color: colors.onSurface),
              ),
            ),

            SliverList.separated(
              itemCount: articles.length - 1,
              separatorBuilder: (_, _) => Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Divider(height: 1, color: colors.outlineVariant),
              ),
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.symmetric(vertical: 6),
                  child: ArticleTile(article: articles[index + 1]),
                );
              },
            ),

            SliverToBoxAdapter(child: SizedBox(height: 24)),
          ],
        );
      },
    );
  }
}
