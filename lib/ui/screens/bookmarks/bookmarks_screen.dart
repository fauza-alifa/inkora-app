import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_app/providers/bookmark_provider.dart';

import '../../widgets/empty_state.dart';
import '../../widgets/theme_toggle_button.dart';
import 'widgets/bookmark_item.dart';

/// Halaman untuk menampilkan daftar artikel yang disimpan (Bookmarks).
class BookmarksScreen extends ConsumerWidget {
  const BookmarksScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Ambil daftar bookmark dari provider
    final bookmarks = ref.watch(bookmarksProvider);
    final textTheme = Theme.of(context).textTheme;

    return CustomScrollView(
      slivers: [
        SliverAppBar(
          title: Text('Tersimpan', style: textTheme.headlineMedium),
          actions: [ThemeToggleButton(), SizedBox(width: 8)],
        ),

        if (bookmarks.isEmpty)
          SliverFillRemaining(
            hasScrollBody: false,
            child: EmptyState(
              icon: Icons.bookmark_border_rounded,
              title: 'Belum ada berita tersimpan',
              message:
                  'Ketuk ikon bookmark pada berita\nuntuk membacanya nanti.',
            ),
          )
        else
          SliverList.separated(
            itemCount: bookmarks.length,
            separatorBuilder: (_, _) =>
                Divider(indent: 16, endIndent: 16),
            itemBuilder: (_, index) => BookmarkItem(article: bookmarks[index]),
          ),
      ],
    );
  }
}
