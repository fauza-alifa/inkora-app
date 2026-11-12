import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_app/core/theme/app_theme.dart';
import 'package:news_app/providers/navigation_provider.dart';

import '../../../../core/utils/date_formatter.dart';
import '../../../widgets/theme_toggle_button.dart';
import '../../archive/archive_screen.dart';

class HomeAppBar extends ConsumerWidget {
  const HomeAppBar({super.key});

  static const String _logoPath = 'assets\images\inkora_logo.png';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return SliverAppBar(
      floating: true,
      snap: true,
      toolbarHeight: 76,
      title: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset(
              _logoPath,
              width: 42,
              height: 42,
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  width: 42,
                  height: 42,
                  decoration: BoxDecoration(
                    color: AppTheme.inkoraBlue,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(
                    Icons.newspaper_rounded,
                    color: AppTheme.primaryOrange,
                    size: 25,
                  ),
                );
              },
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  DateFormatter.today(),
                  style: theme.textTheme.labelLarge?.copyWith(
                    color: colors.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  'Inkora',
                  style: theme.textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      actions: [
        IconButton(
          tooltip: 'Arsip berita',
          icon: const Icon(Icons.calendar_month_rounded),
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const ArchiveScreen()),
            );
          },
        ),
        const ThemeToggleButton(),
        IconButton(
          tooltip: 'Cari berita',
          icon: const Icon(Icons.search_rounded),
          onPressed: () {
            ref.read(navigationProvider.notifier).select(1);
          },
        ),
        const SizedBox(width: 8),
      ],
    );
  }
}
