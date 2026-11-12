import 'package:news_app/core/constants/news_category.dart';

import '../models/article.dart';
import '../services/news_api_service.dart';

class NewsRepository {
  NewsRepository(this._apiService);

  final NewsApiService _apiService;

  /// Mengambil berita utama berdasarkan kategori.
  Future<List<Article>> getTopHeadlines(NewsCategory category) async {
    final articles = await _apiService.fetchTopHeadlines(category.apiValue);

    return _removeDuplicates(articles);
  }

  /// Mencari artikel berdasarkan keyword.
  Future<List<Article>> searchArticles(String query) async {
    final articles = await _apiService.searchArticles(query);

    return _removeDuplicates(articles);
  }

  /// Mengambil artikel berdasarkan tanggal.
  Future<List<Article>> getArticlesByDate(
    DateTime date, {
    String query = 'news',
  }) async {
    final articles = await _apiService.fetchArticlesByDate(date, query: query);

    return _removeDuplicates(articles);
  }

  /// Menghapus artikel duplikat berdasarkan URL.
  List<Article> _removeDuplicates(List<Article> articles) {
    final uniqueArticles = <String, Article>{};

    for (final article in articles) {
      final url = article.url.trim();

      if (url.isEmpty) continue;

      uniqueArticles.putIfAbsent(url, () => article);
    }

    return uniqueArticles.values.toList();
  }
}
