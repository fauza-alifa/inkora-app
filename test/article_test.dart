import 'package:flutter_test/flutter_test.dart';
import 'package:news_app/data/models/article.dart';

void main() {
  group('Article', () {
    final json = {
      'source': {'id': null, 'name': 'The Verge'},
      'author': 'Jane Doe',
      'title': 'Flutter 4 released',
      'description': 'Big news for mobile devs.',
      'url': 'https://example.com/flutter-4',
      'urlToImage': 'https://example.com/img.jpg',
      'publishedAt': '2026-10-07T10:00:00Z',
      'content': 'Flutter 4 brings many things… [+2048 chars]',
    };

    test('fromJson parses NewsAPI payload', () {
      final article = Article.fromJson(json);

      expect(article.title, 'Flutter 4 released');
      expect(article.sourceName, 'The Verge');
      expect(article.imageUrl, 'https://example.com/img.jpg');
      expect(article.publishedAt, DateTime.utc(2026, 10, 7, 10));
    });

    test('cleanContent strips the "[+N chars]" suffix', () {
      final article = Article.fromJson(json);
      expect(article.cleanContent, 'Flutter 4 brings many things…');
    });

    test('toJson -> fromJson round trip keeps data', () {
      final article = Article.fromJson(json);
      final copy = Article.fromJson(article.toJson());

      expect(copy, article);
      expect(copy.sourceName, article.sourceName);
      expect(copy.publishedAt, article.publishedAt);
    });

    test('isValid rejects removed articles', () {
      final removed = Article.fromJson({...json, 'title': '[Removed]'});
      expect(removed.isValid, isFalse);
    });
  });
}
