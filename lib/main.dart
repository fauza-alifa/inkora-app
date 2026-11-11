import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:news_app/data/services/theme_storage.dart';
import 'package:news_app/providers/theme_provider.dart';

import 'app.dart';

Future<void> main() async {
  // During this initialization process, the native splash screen remains visible.
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(isOptional: true);
  await initializeDateFormatting('id_ID');
  final initialTheme = await ThemeStorage().load();
  runApp(
    // TODO: Bungkus NewsApp dengan ProviderScope saat mengimplementasikan Riverpod
    ProviderScope(
      // matikan auto-retry bawaan riverpod agar kuota API tidak cepat habis.
      retry: (retryCount, error) => null,
      overrides: [
        // TODO: lengakapi pemanggilan theme provider
        initialThemeModeProvider.overrideWithValue(initialTheme),
      ],
      child: NewsApp(),
    ),
  );
}
