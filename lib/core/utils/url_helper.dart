import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

/// Membuka URL artikel di in-app browser.
class UrlHelper {
  UrlHelper._();

  static Future<void> open(BuildContext context, String url) async {
    final messenger = ScaffoldMessenger.of(context);
    var success = false;

    try {
      success = await launchUrl(
        Uri.parse(url),
        mode: LaunchMode.inAppBrowserView,
      );
    } catch (_) {
      success = false;
    }

    if (!success) {
      messenger.showSnackBar(
        const SnackBar(
          content: Text('Artikelnya belum bisa dibuka. Coba lagi sebentar ya.'),
        ),
      );
    }
  }
}
