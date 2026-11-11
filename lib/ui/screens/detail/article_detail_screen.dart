import 'package:flutter/material.dart';

import '../../../data/models/article.dart';
import 'widgets/detail_app_bar.dart';
import 'widgets/detail_content.dart';
import 'widgets/detail_header.dart';
import 'widgets/read_more_bar.dart';

/// Halaman detail artikel.
class ArticleDetailScreen extends StatelessWidget {
  const ArticleDetailScreen({super.key, required this.article});

  final Article article;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          DetailAppBar(article: article),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(20, 24, 20, 32),
            sliver: SliverList.list(
              children: [
                DetailHeader(article: article),
                const SizedBox(height: 24),
                DetailContent(article: article),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: ReadMoreBar(url: article.url),
    );
  }
}
