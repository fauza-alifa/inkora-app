import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_app/providers/headlines_provider.dart';

import '../../../../core/constants/news_category.dart';

/// Pilihan kategori berita berbentuk tab horizontal.
class CategoryChips extends ConsumerWidget {
  const CategoryChips({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const categories = NewsCategory.values;
    final selected = ref.watch(selectedCategoryProvider);

    return SizedBox(
      height: 52,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: categories.length,
        separatorBuilder: (_, _) => const SizedBox(width: 24),
        itemBuilder: (context, index) {
          final category = categories[index];
          final isSelected = category == selected;

          return GestureDetector(
            onTap: () {
              ref.read(selectedCategoryProvider.notifier).select(category);
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: isSelected ? Colors.orange : Colors.transparent,
                    width: 3,
                  ),
                ),
              ),
              child: Center(
                child: Text(
                  category.label,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                    color: isSelected ? Colors.orange : Colors.white,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
