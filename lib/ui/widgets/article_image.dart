import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

/// Gambar artikel dengan cache, placeholder, dan fallback saat error.
class ArticleImage extends StatelessWidget {
  const ArticleImage({
    super.key,
    required this.url,
    this.width,
    this.height,
    this.radius = 12,
  });

  final String? url;
  final double? width;
  final double? height;
  final double radius;

  @override
  Widget build(BuildContext context) {
    final placeholder = _Placeholder(width: width, height: height);
    final imageUrl = url;

    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: imageUrl == null || imageUrl.isEmpty
          ? placeholder
          : CachedNetworkImage(
              imageUrl: imageUrl,
              width: width,
              height: height,
              fit: BoxFit.cover,
              fadeInDuration: const Duration(milliseconds: 250),
              placeholder: (_, _) => placeholder,
              errorWidget: (_, _, _) => placeholder,
            ),
    );
  }
}

class _Placeholder extends StatelessWidget {
  const _Placeholder({this.width, this.height});

  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Container(
      width: width,
      height: height,
      color: scheme.surfaceContainerHighest,
      alignment: Alignment.center,
      child: Icon(Icons.image_outlined, color: scheme.onSurfaceVariant),
    );
  }
}
