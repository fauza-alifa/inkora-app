import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_app/providers/headlines_provider.dart';

import 'widgets/category_chips.dart';
import 'widgets/headlines_section.dart';
import 'widgets/home_app_bar.dart';

// Beranda : app bar, filter
/// TODO: Ubah HomeScreen menjadi ConsumerWidget
class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  Future<void> _refresh(WidgetRef ref) async {
    // TODO: Refresh provider saat pull-to-refresh
    final provider = headlinesProvider(ref.read(selectedCategoryProvider));
    ref.invalidate(provider);
    try {
      await ref.read(provider.future);
    } catch (_) {
      // Won't do anything when error happens because it's all handled by headline provider
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return RefreshIndicator(
      onRefresh: () => _refresh(ref),
      child: const CustomScrollView(
        slivers: [
          HomeAppBar(),
          SliverToBoxAdapter(child: CategoryChips()),
          HeadlinesSection(),
        ],
      ),
    );
  }
}
