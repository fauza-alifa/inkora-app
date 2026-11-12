import 'package:flutter/material.dart';

import '../../../../data/models/article.dart';
import '../../../widgets/article_tile.dart';

class ArchiveArticleList extends StatelessWidget {
  const ArchiveArticleList({
    super.key,
    required this.articles,
    this.isLoading = false,
    this.errorMessage,
    this.onRetry,
  });

  final List<Article> articles;
  final bool isLoading;
  final String? errorMessage;
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    if (isLoading) {
      return const Padding(
        padding: EdgeInsets.symmetric(vertical: 40),
        child: Center(child: CircularProgressIndicator()),
      );
    }

    if (errorMessage != null) {
      return _buildErrorState(theme, colors);
    }

    if (articles.isEmpty) {
      return _buildEmptyState(theme, colors);
    }

    return Column(
      children: [
        for (int index = 0; index < articles.length; index++) ...[
          ArticleTile(
            key: ValueKey(articles[index].url),
            article: articles[index],
          ),

          if (index != articles.length - 1)
            Divider(
              height: 1,
              indent: 16,
              endIndent: 16,
              color: colors.outlineVariant.withValues(alpha: 0.5),
            ),
        ],
      ],
    );
  }

  Widget _buildEmptyState(ThemeData theme, ColorScheme colors) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
      child: Column(
        children: [
          Icon(
            Icons.newspaper_outlined,
            size: 48,
            color: colors.onSurfaceVariant.withValues(alpha: 0.6),
          ),
          const SizedBox(height: 16),
          Text(
            'Belum ada berita',
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Tidak ditemukan berita pada tanggal ini. '
            'Coba pilih tanggal lainnya.',
            textAlign: TextAlign.center,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: colors.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState(ThemeData theme, ColorScheme colors) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
      child: Column(
        children: [
          Icon(Icons.cloud_off_outlined, size: 48, color: colors.error),
          const SizedBox(height: 16),
          Text(
            'Gagal memuat berita',
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            errorMessage!,
            textAlign: TextAlign.center,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: colors.onSurfaceVariant,
            ),
          ),
          if (onRetry != null) ...[
            const SizedBox(height: 16),
            OutlinedButton.icon(
              onPressed: onRetry,
              icon: const Icon(Icons.refresh_rounded),
              label: const Text('Coba lagi'),
            ),
          ],
        ],
      ),
    );
  }
}
