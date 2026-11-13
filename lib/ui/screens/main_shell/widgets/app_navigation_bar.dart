import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_app/core/theme/app_theme.dart';
import 'package:news_app/providers/bookmark_provider.dart';

/// Bottom Navigation Bar aplikasi INKORA.
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
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    // Mengambil jumlah bookmark secara real-time.
    final bookmarkCount = ref.watch(bookmarksProvider).length;

    final items = [
      (
        icon: Icons.home_outlined,
        selected: Icons.home_rounded,
        label: 'Beranda',
      ),
      (
        icon: Icons.explore_outlined,
        selected: Icons.explore_rounded,
        label: 'Jelajahi',
      ),
      (
        icon: Icons.bookmarks_outlined,
        selected: Icons.bookmarks_rounded,
        label: 'Tersimpan',
      ),
    ];

    return Container(
      height: 100,
      decoration: BoxDecoration(
        color: scheme.surfaceContainer,
        border: Border(
          top: BorderSide(
            color: scheme.brightness == Brightness.dark
                ? Color(0xFF293746)
                : Color(0xFFE5E7EB),
          ),
        ),
      ),
      child: SafeArea(
        top: false,
        child: Row(
          children: List.generate(items.length, (index) {
            final item = items[index];
            final isSelected = currentIndex == index;

            return Expanded(
              child: InkWell(
                onTap: () => onTap(index),
                splashColor: AppTheme.primaryOrange.withValues(alpha: 0.08),
                highlightColor: AppTheme.primaryOrange.withValues(alpha: 0.04),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Ikon navigasi.
                    Badge.count(
                      count: bookmarkCount,
                      isLabelVisible: index == 2 && bookmarkCount > 0,
                      child: Icon(
                        isSelected ? item.selected : item.icon,
                        color: isSelected
                            ? AppTheme.primaryOrange
                            : scheme.onSurfaceVariant,
                        size: 23,
                      ),
                    ),

                    SizedBox(height: 4),

                    // Label navigasi.
                    Text(
                      item.label,
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: isSelected
                            ? AppTheme.primaryOrange
                            : scheme.onSurfaceVariant,
                        fontWeight: isSelected
                            ? FontWeight.w700
                            : FontWeight.w500,
                      ),
                    ),

                    SizedBox(height: 5),

                    // Indikator aktif di bawah label.
                    AnimatedContainer(
                      duration: Duration(milliseconds: 200),
                      curve: Curves.easeInOut,
                      width: isSelected ? 24 : 0,
                      height: 3,
                      decoration: BoxDecoration(
                        color: isSelected
                            ? AppTheme.primaryOrange
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
