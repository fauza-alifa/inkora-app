import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_app/providers/navigation_provider.dart';

import '../../../../core/utils/date_formatter.dart';
import '../../../widgets/theme_toggle_button.dart';
import '../../archive/archive_screen.dart';

// HomeAppBar menggunakan ConsumerWidget agar dapat
// mengakses navigationProvider.
class HomeAppBar extends ConsumerWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    return SliverAppBar(
      floating: true,
      snap: true,
      toolbarHeight: 76,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            DateFormatter.today(),
            style: theme.textTheme.labelLarge?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 2),
          Text('Inkora', style: theme.textTheme.headlineMedium),
        ],
      ),
      actions: [
        // Tombol kalender untuk membuka arsip berita.
        IconButton(
          tooltip: 'Arsip berita',
          icon: const Icon(Icons.calendar_month_rounded),
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const ArchiveScreen()),
            );
          },
        ),

        // Tombol pengaturan tema.
        const ThemeToggleButton(),

        // Tombol pencarian berita.
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
