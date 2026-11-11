import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// TODO: Ubah menjadi ConsumerWidget saat Riverpod diimplementasikan
class AppNavigationBar extends ConsumerWidget {
  const AppNavigationBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  final int currentIndex;
  final ValueChanged<int> onTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // TODO: Ambil jumlah bookmark dari provider
    final bookmarkCount = 0;

    return NavigationBar(
      selectedIndex: currentIndex,
      onDestinationSelected: onTap,
      destinations: [
        const NavigationDestination(
          icon: Icon(Icons.home_outlined),
          selectedIcon: Icon(Icons.home_rounded),
          label: 'Beranda',
        ),
        const NavigationDestination(
          icon: Icon(Icons.explore_outlined),
          selectedIcon: Icon(Icons.explore_rounded),
          label: 'Jelajahi',
        ),
        NavigationDestination(
          icon: Badge.count(
            count: bookmarkCount,
            isLabelVisible: bookmarkCount > 0,
            child: const Icon(Icons.bookmarks_outlined),
          ),
          selectedIcon: const Icon(Icons.bookmarks_rounded),
          label: 'Tersimpan',
        ),
      ],
    );
  }
}
