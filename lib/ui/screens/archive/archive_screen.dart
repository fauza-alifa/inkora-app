import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:news_app/providers/archive_provider.dart';

import 'widgets/archive_calendar.dart';
import 'widgets/archive_article_list.dart';
import 'widgets/archive_date_header.dart';

class ArchiveScreen extends ConsumerWidget {
  const ArchiveScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedDate = ref.watch(selectedArchiveDateProvider);

    final archiveArticlesAsync = ref.watch(
      archiveArticlesProvider(selectedDate),
    );

    return Scaffold(
      appBar: AppBar(title: const Text('Arsip Berita'), centerTitle: false),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(bottom: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                child: ArchiveCalendar(
                  selectedDate: selectedDate,
                  onDateSelected: (date) {
                    ref
                        .read(selectedArchiveDateProvider.notifier)
                        .selectDate(date);
                  },
                ),
              ),

              const SizedBox(height: 16),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: archiveArticlesAsync.when(
                  loading: () => ArchiveDateHeader(
                    selectedDate: selectedDate,
                    articleCount: 0,
                  ),
                  error: (error, stackTrace) => ArchiveDateHeader(
                    selectedDate: selectedDate,
                    articleCount: 0,
                  ),
                  data: (articles) => ArchiveDateHeader(
                    selectedDate: selectedDate,
                    articleCount: articles.length,
                  ),
                ),
              ),

              const SizedBox(height: 8),

              archiveArticlesAsync.when(
                loading: () =>
                    const ArchiveArticleList(articles: [], isLoading: true),
                error: (error, stackTrace) => ArchiveArticleList(
                  articles: const [],
                  errorMessage:
                      'Terjadi kesalahan saat memuat berita. '
                      'Periksa koneksi internet dan coba lagi.',
                  onRetry: () {
                    ref.invalidate(archiveArticlesProvider(selectedDate));
                  },
                ),
                data: (articles) => ArchiveArticleList(articles: articles),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
