// import '../data/models/article.dart';

// TODO 10: Implementasi BookmarkProvider
// 1. Buat class BookmarkNotifier extends AsyncNotifier<List<Article>>
// 2. Di dalam build(), panggil BookmarkStorage.getBookmarks()
// 3. Buat fungsi toggleBookmark(Article article) untuk menambah/menghapus artikel dari bookmark
// 4. Setelah mengubah list, panggil BookmarkStorage.saveBookmarks() untuk menyimpan ke local storage
// 5. Buat fungsi isBookmarked(Article article) untuk mengecek apakah artikel sudah ada di bookmark
// 6. Buat bookmarkProvider (AsyncNotifierProvider) untuk digunakan di UI

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_app/data/models/article.dart';
import 'package:news_app/data/services/bookmark_storage.dart';
import 'package:news_app/providers/dependency_provider.dart';

// list of article that's saved, synchronized in local storage
class BookmarkNotifier extends Notifier<List<Article>> {
  BookmarkStorage get _storage => ref.read(bookmarkStorageProvider);

  @override
  List<Article> build() {
    _loadFromStorage();
    return [];
  }

  Future<void> _loadFromStorage() async {
    state = await _storage.load();
  }

  bool isSaved(Article article) => state.contains(article);

  void toggle(Article article) {
    state = isSaved(article)
        ? state.where((item) => item != article).toList()
        : [article, ...state];
  }
}

final bookmarksProvider = NotifierProvider<BookmarkNotifier, List<Article>>(
  BookmarkNotifier.new,
);

// bookmark status for some article that will shown based on URL
// widget that use this only rebuild when article status changed
final isBookmarkedProvider = Provider.family<bool, String>((ref, url) {
  return ref.watch(bookmarksProvider).any((article) => article.url == url);
});