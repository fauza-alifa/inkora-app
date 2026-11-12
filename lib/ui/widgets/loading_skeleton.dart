import 'package:flutter/material.dart';

/// Skeleton loading berdenyut solid yang meniru bentuk [ArticleTile] (Tanpa Opacity).
class LoadingSkeleton extends StatefulWidget {
  const LoadingSkeleton({super.key, this.itemCount = 6});

  final int itemCount;

  @override
  State<LoadingSkeleton> createState() => _LoadingSkeletonState();
}

class _LoadingSkeletonState extends State<LoadingSkeleton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 900),
  )..repeat(reverse: true);

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Menggunakan AnimatedBuilder untuk mengubah warna bar secara solid tanpa opacity
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Column(
          children: List.generate(
            widget.itemCount,
            (_) => _SkeletonTile(animationValue: _controller.value),
          ),
        );
      },
    );
  }
}

class _SkeletonTile extends StatelessWidget {
  const _SkeletonTile({required this.animationValue});

  final double animationValue;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _Bar(width: 80, height: 10, animationValue: animationValue),
                const SizedBox(height: 10),
                _Bar(height: 14, animationValue: animationValue),
                const SizedBox(height: 6),
                _Bar(width: 180, height: 14, animationValue: animationValue),
              ],
            ),
          ),
          const SizedBox(width: 16),
          _Bar(
            width: 92,
            height: 92,
            radius: 12,
            animationValue: animationValue,
          ),
        ],
      ),
    );
  }
}

class _Bar extends StatelessWidget {
  const _Bar({
    this.width = double.infinity,
    required this.height,
    this.radius = 6,
    required this.animationValue,
  });

  final double width;
  final double height;
  final double radius;
  final double animationValue;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    // Transisi warna solid tanpa menggunakan opacity/transparansi
    final color1 = scheme.surfaceContainerHighest;
    final color2 = isDark ? const Color(0xFF38495D) : const Color(0xFFD6DFEC);
    final solidColor = Color.lerp(color1, color2, animationValue)!;

    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: solidColor,
        borderRadius: BorderRadius.circular(radius),
      ),
    );
  }
}
