import 'package:flutter/material.dart';

import 'widgets/search_input.dart';
import 'widgets/search_results.dart';

/// Halaman Jelajahi: kolom pencarian + hasil / saran topik.
class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return SafeArea(
      bottom: false,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 20, 16, 12),
            child: Text('Jelajahi', style: textTheme.headlineMedium),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: SearchInput(),
          ),
          const SizedBox(height: 8),
          const Expanded(child: SearchResults()),
        ],
      ),
    );
  }
}
