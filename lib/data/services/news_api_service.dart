// import '../../core/constants/api_constants.dart';
import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:news_app/core/constants/api_constants.dart';
import 'package:news_app/data/services/news_api_exception.dart';

import '../models/article.dart';

import 'dart:convert';

import 'package:http/http.dart' as http;

// TODO 3: Implementasi NewsApiService
// 1. Install package http: flutter pub add http
// 2. Import 'package:http/http.dart' as http;
// 3. Buat fungsi getTopHeadlines(String category) yang memanggil endpoint /v2/top-headlines
// 4. Buat fungsi searchArticles(String query) yang memanggil endpoint /v2/everything
// 5. Tangani error menggunakan NewsApiException
// service tingkat rendah yang berbicara langsung dengan NewsAPI (sebagai bentuk komunikasi dasar)
class NewsApiService {
  // Dependency Injections (DI) --> some technique to inject or put object (http.Client) in from outside the class, not created directly in this class
  // Objective --> is to easier the testing (application testing) with put 'client imitation' (mock) in without connect to the real internet
  // ?? symbol means if client is not filled (null), will automatically use http.Client() default standard
  NewsApiService({http.Client? client}) : _client = client ?? http.Client();
  // private variable (begin with _) used to store client HTTP that is used to communicate with server
  final http.Client _client;
  // To take list or endpoint of top headlines based on category and country
  Future<List<Article>> fetchTopHeadlines(String category) async {
    // Implementasi fetch API di sini
    return _get('/top-headlines', {
      'country': ApiConstants.country,
      'category': category,
    });
  }

  // Search article based on keyword (query) listed from the newest one (publishedAt)
  Future<List<Article>> searchArticles(String query) async {
    // Implementasi fetch API di sini
    return _get('/everything', {
      'q': query,
      'sortBy': 'publishedAt',
      'language': ApiConstants.language,
    });
  }

  // function has to have return value
  // helper method: as a helping function (private). So that we don't have to repeat the HTTP request code
  Future<List<Article>> _get(String path, Map<String, String> params) async {
    // validate: to check if API key already filled in file .env so there will be no failed authentication
    // API KEY (krudensial rahasia) cuman bisa diakses oleh developer dan tidak boleh ditampilkan ke user
    final apiKey = ApiConstants.apiKey;
    if (apiKey.isEmpty) {
      // technical guidelines just for developer (console), not for user
      debugPrint('[Inkora] NEWS_API_KEY kosong. Isi API key di file .env.');
      throw NewsApiException.serviceUnavailable;
    }
    // built the complete url: connect the BaseURL (main server address) + path (aimed endpoint)
    // insert query params (searching params and maximum of data quantity / PageSize)
    final uri = Uri.parse('${ApiConstants.baseUrl}$path').replace(
      queryParameters: {...params, 'PageSize': '${ApiConstants.pageSize}'}, //...params (spread operator), untuk ,eastikan tidak ada objek tertinggal tanpa terkecuali.
    );
    try {
      // send GET request to server with header 'X-Api-Key' as ticket access permission to server
      // and maximum time to wait (.timeout) so the application will not suspend if server take too long to response
      final response = await _client
          .get(uri, headers: {'X-Api-Key': apiKey})
          .timeout(ApiConstants.timeout);
      // check code status HTTP: 200 is request success (OK)
      // if not 200 (401, 429, 500 and more), throw error code as the status
      if (response.statusCode != 200) {
        debugPrint('[Inkora] HTTP ${response.statusCode}: ${response.body}');
        throw _fromStatusCode(response.statusCode);
      }

      // JSON Decoding: to change raw data (String text) from server to be a MAP DART format
      final body = jsonDecode(response.body) as Map<String, dynamic>;
      // take article list from key 'articles'. if null, use empty list [] as alternative
      final articles = body['articles'] as List<dynamic>? ?? [];
      // Data Mapping: Change all the json data into some object or properties or articles, then filtering that will be shown in return output just the valid and complete data
      return articles
          .map((json) => Article.fromJson(json as Map<String, dynamic>))
          // proses filter yang hanya menyisakan article yang valid.
          .where((article) => article.isValid)
          .toList();
      // throw: to continue again NewsApiException to function caller without changing the type of error
    } on NewsApiException {
      rethrow;
      // socketException: connection error on the system operation level (example: User's phone is offline or airplane mode)
    } on SocketException {
      throw NewsApiException.offline;
      // ClientException: error at HTTP connection (example: DNS failed to find server address or disconnection suddenly)
    } on http.ClientException {
      throw NewsApiException.offline;
      // TimeoutException: maximum time of waiting because the internet connection too slow (RTO)
    } on TimeoutException {
      throw NewsApiException.slowConnection;
      // Catch: catch all the other unexpected error (fallback situation) so the application will not crash or closed on its own (forced close)
    } catch (error) {
      debugPrint('[Inkora] Unexpected error: $error');
      throw NewsApiException.unknown;
    }
  }

  // Switch Expression (pattern matching feature in dart 3): short way to fit HTTP status code with error NewsApiException
  NewsApiException _fromStatusCode(int code) => switch (code) {
    // 401 (Unauthorized): API Key is false or null. 403 (Forbidden): access is denied by the server
    401 || 403 => NewsApiException.serviceUnavailable,

    // 429 (Too many request): maximum daily quota is out of stock cuz used
    429 => NewsApiException.tooManyRequests,

    // >=500 (Server error): happen when there's problem in NewsAPI Server
    >= 500 => NewsApiException.serverBusy,

    // _ (wildcard or default): to handle the other code that's not mentioned above
    _ => NewsApiException.unknown,
  };
}
