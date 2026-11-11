// for homeScreen

// import '../data/models/article.dart';

// TODO 8: Implementasi HeadlinesProvider
// 1. Buat class HeadlinesNotifier extends AsyncNotifier<List<Article>>
// 2. Di dalam build(), panggil NewsRepository.getTopHeadlines()
// 3. Buat fungsi fetchHeadlines(String category) untuk memuat ulang data dengan kategori berbeda
// 4. Buat headlinesProvider (AsyncNotifierProvider) untuk digunakan di UI

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_app/core/constants/news_category.dart';
import 'package:news_app/data/models/article.dart';
import 'package:news_app/providers/dependency_provider.dart';

// category that is selected in home page
class SelectedCategoryNotifier extends Notifier<NewsCategory> {
  @override
  NewsCategory build() => NewsCategory.general;

  void select(NewsCategory category) => state = category;
}

final selectedCategoryProvider = NotifierProvider<SelectedCategoryNotifier, NewsCategory>(
  SelectedCategoryNotifier.new,
);

// Top Headlines per-Category
// use function `.family` so the result of each category in cache (data trash) when user back to the same category 
// data will directly show up without repeating request (without GET API)

final headlinesProvider = FutureProvider.family<List<Article>, NewsCategory>((ref, category) {
  return ref.watch(newsRepositoryProvider).getTopHeadlines(category);
});