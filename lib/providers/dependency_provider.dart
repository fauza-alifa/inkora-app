import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:news_app/data/repositories/news_repository.dart';
import 'package:news_app/data/services/bookmark_storage.dart';
import 'package:news_app/data/services/news_api_service.dart';

/// Menyediakan NewsApiService.
final newsApiServiceProvider = Provider<NewsApiService>((ref) {
  final service = NewsApiService();

  ref.onDispose(service.dispose);

  return service;
});

/// Menyediakan NewsRepository.
final newsRepositoryProvider = Provider<NewsRepository>((ref) {
  final apiService = ref.watch(newsApiServiceProvider);

  return NewsRepository(apiService);
});

/// Menyediakan BookmarkStorage.
final bookmarkStorageProvider = Provider<BookmarkStorage>(
  (ref) => BookmarkStorage(),
);
