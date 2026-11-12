import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:news_app/core/constants/api_constants.dart';
import 'package:news_app/data/services/news_api_exception.dart';

import '../models/article.dart';

class NewsApiService {
  NewsApiService({http.Client? client}) : _client = client ?? http.Client();

  final http.Client _client;

  /// Mengambil berita utama berdasarkan kategori.
  Future<List<Article>> fetchTopHeadlines(String category) async {
    return _get('/top-headlines', {
      'country': ApiConstants.country,
      'category': category,
    });
  }

  /// Mencari artikel berdasarkan keyword.
  Future<List<Article>> searchArticles(String query) async {
    return _get('/everything', {
      'q': query,
      'sortBy': 'publishedAt',
      'language': ApiConstants.language,
    });
  }

  /// Mengambil artikel berdasarkan tanggal kalender.
  ///
  /// Tanggal yang dipilih menggunakan waktu lokal perangkat.
  /// Rentang tanggal dikonversi ke UTC sebelum dikirim ke API.
  Future<List<Article>> fetchArticlesByDate(
    DateTime date, {
    String query = 'news',
  }) async {
    final localStart = DateTime(date.year, date.month, date.day);

    final localEnd = DateTime(date.year, date.month, date.day + 1);

    final from = localStart.toUtc().toIso8601String();

    final to = localEnd
        .toUtc()
        .subtract(const Duration(milliseconds: 1))
        .toIso8601String();

    return _get('/everything', {
      'q': query,
      'from': from,
      'to': to,
      'sortBy': 'publishedAt',
      'language': ApiConstants.language,
    });
  }

  /// Helper untuk seluruh HTTP GET request.
  Future<List<Article>> _get(String path, Map<String, String> params) async {
    final apiKey = ApiConstants.apiKey;

    if (apiKey.isEmpty) {
      debugPrint('[Inkora] NEWS_API_KEY kosong. Isi API key di file .env.');
      throw NewsApiException.serviceUnavailable;
    }

    final uri = Uri.parse('${ApiConstants.baseUrl}$path').replace(
      queryParameters: {...params, 'pageSize': '${ApiConstants.pageSize}'},
    );

    try {
      final response = await _client
          .get(uri, headers: {'X-Api-Key': apiKey})
          .timeout(ApiConstants.timeout);

      if (response.statusCode != 200) {
        debugPrint('[Inkora] HTTP ${response.statusCode}: ${response.body}');

        throw _fromStatusCode(response.statusCode);
      }

      final body = jsonDecode(response.body) as Map<String, dynamic>;

      if (body['status'] != 'ok') {
        debugPrint('[Inkora] NewsAPI error: ${body['message']}');

        throw NewsApiException.unknown;
      }

      final articles = body['articles'] as List<dynamic>? ?? [];

      return articles
          .map((json) => Article.fromJson(json as Map<String, dynamic>))
          .where((article) => article.isValid)
          .toList();
    } on NewsApiException {
      rethrow;
    } on SocketException {
      throw NewsApiException.offline;
    } on http.ClientException {
      throw NewsApiException.offline;
    } on TimeoutException {
      throw NewsApiException.slowConnection;
    } catch (error) {
      debugPrint('[Inkora] Unexpected error: $error');
      throw NewsApiException.unknown;
    }
  }

  /// Mengubah HTTP status code menjadi NewsApiException.
  NewsApiException _fromStatusCode(int code) => switch (code) {
    401 || 403 => NewsApiException.serviceUnavailable,
    429 => NewsApiException.tooManyRequests,
    >= 500 => NewsApiException.serverBusy,
    _ => NewsApiException.unknown,
  };

  /// Menutup HTTP client.
  void dispose() {
    _client.close();
  }
}
