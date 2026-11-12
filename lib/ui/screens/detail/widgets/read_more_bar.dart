import 'package:flutter/material.dart';

import '../../../../core/utils/url_helper.dart';

/// Tombol "Baca artikel lengkap" yang menempel di bawah layar.
class ReadMoreBar extends StatelessWidget {
  const ReadMoreBar({super.key, required this.url});

  final String url;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      minimum: EdgeInsets.fromLTRB(20, 8, 20, 16),
      child: FilledButton.icon(
        style: FilledButton.styleFrom(minimumSize: Size.fromHeight(52)),
        icon: Icon(Icons.open_in_new_rounded),
        label: Text('Baca artikel lengkap'),
        onPressed: () => UrlHelper.open(context, url),
      ),
    );
  }
}
