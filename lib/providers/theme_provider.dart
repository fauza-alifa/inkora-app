// TODO 6: Implementasi ThemeProvider
// 1. Install Riverpod: `flutter pub add flutter_riverpod`
// 2. Import 'package:flutter_riverpod/flutter_riverpod.dart';
// 3. Buat class ThemeNotifier extends Notifier<bool> (menyimpan state isDarkMode)
// 4. Implementasikan fungsi toggleTheme() untuk mengubah state dan menyimpannya di SharedPreferences
// 5. Buat themeProvider (NotifierProvider) untuk digunakan di UI

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_app/data/services/theme_storage.dart';

final themeStorageProvider = Provider<ThemeStorage>((ref) => ThemeStorage());

// The first theme that is read in 'main.dart' before app show up (run asynchronously)
// the value in override pass  `ProviderScope.overrides`

final initialThemeModeProvider = Provider<ThemeMode>((ref) => ThemeMode.system);

// active theme mode = light / dark (default following the system)
class ThemeNotifier extends Notifier<ThemeMode> {
  @override
  ThemeMode build() => ref.read(initialThemeModeProvider);

  // switch to opposite from the theme that's shown / active
  void toggle(Brightness currentBrightness) {
    // Assignment operator
    state = currentBrightness == Brightness.dark ? ThemeMode.light : ThemeMode.dark;
    ref.read(themeStorageProvider).save(state);
  }
}

// focus on how to give notification when there is changed state
// declare a notifier to tell the state that changed
// so the app will know if there will be change that will happen in theme
final themeModeProvider = NotifierProvider<ThemeNotifier, ThemeMode>(
  ThemeNotifier.new,
);
