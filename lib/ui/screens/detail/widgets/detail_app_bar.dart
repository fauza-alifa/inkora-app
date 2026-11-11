import 'package:flutter/material.dart';

import '../../../../data/models/article.dart';
import '../../../widgets/article_image.dart';
import '../../../widgets/bookmark_button.dart';

/// App bar dengan gambar besar yang menyusut saat di-scroll.
class DetailAppBar extends StatelessWidget {
  const DetailAppBar({super.key, required this.article});

  final Article article;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      stretch: true,
      expandedHeight: 300,
      leading: Padding(
        padding: const EdgeInsets.all(6),
        child: IconButton.filledTonal(
          tooltip: 'Kembali',
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      actions: [
        BookmarkButton(article: article, tonal: true),
        const SizedBox(width: 8),
      ],
      flexibleSpace: FlexibleSpaceBar(
        stretchModes: const [StretchMode.zoomBackground],
        background: ArticleImage(url: article.imageUrl, radius: 0),
      ),
    );
  }
}
