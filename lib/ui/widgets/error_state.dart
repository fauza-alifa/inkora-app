import 'package:flutter/material.dart';

import '../../data/services/news_api_exception.dart';
import 'empty_state.dart';

/// Tampilan error yang ramah dengan tombol "Coba lagi".
class ErrorState extends StatelessWidget {
  const ErrorState({super.key, required this.error, required this.onRetry});

  final Object error;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    // Error apa pun yang tidak dikenal tetap ditampilkan dengan bahasa ramah.
    final friendly = error is NewsApiException
        ? error as NewsApiException
        : NewsApiException.unknown;

    return EmptyState(
      icon: identical(friendly, NewsApiException.offline)
          ? Icons.wifi_off_rounded
          : Icons.cloud_off_rounded,
      title: friendly.title,
      message: friendly.message,
      actionLabel: 'Coba lagi',
      onAction: onRetry,
    );
  }
}
