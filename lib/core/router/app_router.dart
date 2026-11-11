import 'package:flutter/material.dart';

import '../../data/models/article.dart';
import '../../ui/screens/detail/article_detail_screen.dart';

/// Semua navigasi antar halaman dikumpulkan di sini.
class AppRouter {
  AppRouter._();

  static Future<void> openArticle(BuildContext context, Article article) {
    return Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => ArticleDetailScreen(article: article)),
    );
  }
}
