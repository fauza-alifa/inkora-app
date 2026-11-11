// local storage article that's in bookmark (shared preferences)
import 'dart:convert';

import 'package:news_app/data/models/article.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BookmarkStorage {
  static const String _key = 'bookmarked_articles';

  final SharedPreferencesAsync _prefs = SharedPreferencesAsync();

  Future<List<Article>> load() async {
    final raw = await _prefs.getStringList(_key) ?? [];
    return raw
        .map(
          (item) => Article.fromJson(jsonDecode(item) as Map<String, dynamic>),
        )
        // change string format to json and to fit data type that was before map to list
        .toList();
  }

  // function that's run when user bookmarked an article
  Future<void> save(List<Article> articles) {
    final raw = articles
        .map((article) => jsonEncode(article.toJson()))
        .toList();
    return _prefs.setStringList(_key, raw);
  }
}
