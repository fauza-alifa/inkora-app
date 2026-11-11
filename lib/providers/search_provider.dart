// import '../data/models/article.dart';

// TODO 9: Implementasi SearchProvider
// 1. Buat class SearchNotifier extends AsyncNotifier<List<Article>>
// 2. Di dalam build(), return [] sebagai nilai awal
// 3. Buat fungsi search(String query) untuk memanggil NewsRepository.searchArticles() dan menyimpan hasilnya di state
// 4. Buat searchProvider (AsyncNotifierProvider) untuk digunakan di UI

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_app/data/models/article.dart';
import 'package:news_app/providers/dependency_provider.dart';

class SearchQueryNotifier extends Notifier<String> {
  @override
  String build() => '';

  // run when user click enter
  void submit(String query) => state = query.trim();

  void clear() => state = '';
}


final searchQueryProvider = NotifierProvider<SearchQueryNotifier, String>(
  SearchQueryNotifier.new,
);

// control the result of search: automatically re-fetch every time query changes
final searchResultProvider = FutureProvider.autoDispose<List<Article>>((
  ref,
) async {
  final query = ref.watch(searchQueryProvider);

  if (query.isEmpty) return [];
  return ref.watch(newsRepositoryProvider).searchArticles(query);
});

// alias so it can be accessed with the name searchResultProvider or searchResultsProvider
final searchResultsProvider = searchResultProvider;