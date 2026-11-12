import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:news_app/data/models/article.dart';
import 'package:news_app/providers/dependency_provider.dart';

/// Mengelola tanggal yang dipilih pada halaman arsip.
class SelectedArchiveDateNotifier extends Notifier<DateTime> {
  @override
  DateTime build() {
    final now = DateTime.now();

    return DateTime(now.year, now.month, now.day);
  }

  /// Memilih tanggal dari kalender.
  void selectDate(DateTime date) {
    state = DateTime(date.year, date.month, date.day);
  }

  /// Memilih kembali tanggal hari ini.
  void selectToday() {
    final now = DateTime.now();

    state = DateTime(now.year, now.month, now.day);
  }
}

/// Provider untuk tanggal arsip yang sedang dipilih.
final selectedArchiveDateProvider =
    NotifierProvider<SelectedArchiveDateNotifier, DateTime>(
      SelectedArchiveDateNotifier.new,
    );

/// Provider untuk mengambil artikel berdasarkan tanggal.
final archiveArticlesProvider = FutureProvider.family<List<Article>, DateTime>((
  ref,
  date,
) async {
  final repository = ref.watch(newsRepositoryProvider);

  return repository.getArticlesByDate(date);
});
