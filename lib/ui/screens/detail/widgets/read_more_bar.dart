import 'package:flutter/material.dart';

import '../../../../core/utils/url_helper.dart';

/// Tombol "Baca artikel lengkap" yang menempel di bawah layar.
class ReadMoreBar extends StatelessWidget {
  const ReadMoreBar({super.key, required this.url});

  final String url;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      minimum: const EdgeInsets.fromLTRB(20, 8, 20, 16),
      child: FilledButton.icon(
        style: FilledButton.styleFrom(minimumSize: const Size.fromHeight(52)),
        icon: const Icon(Icons.open_in_new_rounded),
        label: const Text('Baca artikel lengkap'),
        onPressed: () => UrlHelper.open(context, url),
      ),
    );
  }
}
