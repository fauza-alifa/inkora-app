import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Menyimpan pilihan tema (terang/gelap) pengguna.
class ThemeStorage {
  static const String _key = 'theme_mode';

  final SharedPreferencesAsync _prefs = SharedPreferencesAsync();

  Future<ThemeMode> load() async {
    final saved = await _prefs.getString(_key);
    return ThemeMode.values.firstWhere(
      (mode) => mode.name == saved,
      orElse: () => ThemeMode.system,
    );
  }

  Future<void> save(ThemeMode mode) => _prefs.setString(_key, mode.name);
}
