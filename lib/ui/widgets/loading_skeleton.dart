import 'package:flutter/material.dart';

/// Skeleton loading berdenyut yang meniru bentuk [ArticleTile].
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

  late final Animation<double> _opacity = _controller.drive(
    Tween(begin: 0.45, end: 1.0),
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _opacity,
      child: Column(
        children: List.generate(widget.itemCount, (_) => const _SkeletonTile()),
      ),
    );
  }
}

class _SkeletonTile extends StatelessWidget {
  const _SkeletonTile();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _Bar(width: 80, height: 10),
                SizedBox(height: 10),
                _Bar(height: 14),
                SizedBox(height: 6),
                _Bar(width: 180, height: 14),
              ],
            ),
          ),
          SizedBox(width: 16),
          _Bar(width: 92, height: 92, radius: 12),
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
  });

  final double width;
  final double height;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(radius),
      ),
    );
  }
}
