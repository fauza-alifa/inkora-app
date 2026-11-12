import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_app/core/theme/app_theme.dart';
import 'package:news_app/providers/search_provider.dart';

class SearchSuggestions extends ConsumerWidget {
  const SearchSuggestions({super.key});

  static const _topics = [
    'Artificial Intelligence',
    'Technology',
    'Cybersecurity',
    'Robotics',
    'Startup',
    'Climate',
    'Environment',
    'Renewable Energy',
    'Space',
    'Science',
    'Economy',
    'Business',
    'Finance',
    'Education',
    'Politics',
    'Election',
    'Health',
    'Football',
    'Entertainment',
    'Culture',
  ];

  static const _icons = [
    Icons.smart_toy_outlined,
    Icons.devices_outlined,
    Icons.security_outlined,
    Icons.precision_manufacturing_outlined,
    Icons.lightbulb_outline_rounded,
    Icons.cloud_outlined,
    Icons.eco_outlined,
    Icons.energy_savings_leaf_outlined,
    Icons.rocket_launch_outlined,
    Icons.science_outlined,
    Icons.trending_up_rounded,
    Icons.business_center_outlined,
    Icons.account_balance_wallet_outlined,
    Icons.school_outlined,
    Icons.account_balance_outlined,
    Icons.how_to_vote_outlined,
    Icons.health_and_safety_outlined,
    Icons.sports_soccer_rounded,
    Icons.movie_outlined,
    Icons.palette_outlined,
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = Theme.of(context).colorScheme;

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Wrap(
          spacing: 8,
          runSpacing: 10,
          children: [
            for (int index = 0; index < _topics.length; index++)
              ActionChip(
                avatar: Icon(
                  _icons[index],
                  size: 17,
                  color: AppTheme.primaryOrange,
                ),
                label: Text(_topics[index]),
                labelStyle: TextStyle(
                  color: colors.onSurface,
                  fontWeight: FontWeight.w500,
                ),
                backgroundColor: colors.surface,
                side: BorderSide(color: AppTheme.primaryOrange.withValues(alpha: 0.10)),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                onPressed: () {
                  ref.read(searchQueryProvider.notifier).submit(_topics[index]);
                },
              ),
          ],
        ),
      ],
    );
  }
}
