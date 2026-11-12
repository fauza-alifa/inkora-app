import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_app/providers/bookmark_provider.dart';

import '../../../../data/models/article.dart';
import '../../../widgets/article_tile.dart';

/// Item bookmark dengan fitur geser (Dismissible) untuk menghapus artikel.
class BookmarkItem extends ConsumerWidget {
  const BookmarkItem({super.key, required this.article});

  final Article article;

  void _remove(BuildContext context, WidgetRef ref) {
    // Panggil ref.read(bookmarksProvider.notifier).toggle(article) untuk menghapus
    ref.read(bookmarksProvider.notifier).toggle(article);

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: const Text('Dihapus dari Tersimpan'),
          action: SnackBarAction(
            label: 'Urungkan',
            onPressed: () {
              // Panggil notifier.toggle(article) lagi untuk mengembalikan
              ref.read(bookmarksProvider.notifier).toggle(article);
            },
          ),
        ),
      );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scheme = Theme.of(context).colorScheme;

    return Dismissible(
      key: ValueKey(article.url),
      direction: DismissDirection.endToStart,
      onDismissed: (_) => _remove(context, ref),
      background: Container(
        color: scheme.errorContainer,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Icon(
          Icons.delete_outline_rounded,
          color: scheme.onErrorContainer,
        ),
      ),
      child: ArticleTile(article: article),
    );
  }
}
