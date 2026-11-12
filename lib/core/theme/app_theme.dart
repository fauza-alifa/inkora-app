import 'package:flutter/cupertino.dart' show CupertinoPageTransitionsBuilder;
import 'package:flutter/material.dart';

/// INKORA App Theme
/// Modern Editorial News Platform
class AppTheme {
  AppTheme._();

  // Brand Colors
  static const Color primaryOrange = Color(0xFFF7931E);
  static const Color inkoraBlue = Color(0xFF0B2D52);
  static const Color charcoal = Color(0xFF1F2937);
  static const Color paperGray = Color(0xFFF4F6F8);

  static ThemeData light() => _build(Brightness.light);

  static ThemeData dark() => _build(Brightness.dark);

  static ThemeData _build(Brightness brightness) {
    final isDark = brightness == Brightness.dark;

    // Color Scheme
    final generatedScheme = ColorScheme.fromSeed(
      seedColor: primaryOrange,
      brightness: brightness,
    );

    final scheme = generatedScheme.copyWith(
      primary: primaryOrange,
      onPrimary: Colors.white,

      secondary: isDark ? const Color(0xFF8EABD0) : inkoraBlue,

      onSecondary: isDark ? const Color(0xFF101820) : Colors.white,

      surface: isDark ? const Color(0xFF101820) : paperGray,

      onSurface: isDark ? const Color(0xFFF4F6F8) : charcoal,

      surfaceContainer: isDark ? const Color(0xFF1B2733) : Colors.white,

      surfaceContainerHighest: isDark
          ? const Color(0xFF293746)
          : const Color(0xFFE9EDF2),

      secondaryContainer: isDark
          ? const Color(0xFF263B52)
          : const Color(0xFFE4EBF3),

      onSecondaryContainer: isDark ? const Color(0xFFDCE7F4) : inkoraBlue,
    );

    final base = ThemeData(
      useMaterial3: true,
      brightness: brightness,
      colorScheme: scheme,
    );

    final text = base.textTheme;

    return base.copyWith(
      // Background
      scaffoldBackgroundColor: scheme.surface,

      // Typography
      textTheme: text.copyWith(
        headlineMedium: text.headlineMedium?.copyWith(
          fontWeight: FontWeight.w700,
          letterSpacing: -0.5,
        ),
        headlineSmall: text.headlineSmall?.copyWith(
          fontWeight: FontWeight.w700,
          height: 1.25,
        ),
        titleLarge: text.titleLarge?.copyWith(
          fontWeight: FontWeight.w700,
          height: 1.3,
        ),
        titleMedium: text.titleMedium?.copyWith(
          fontWeight: FontWeight.w600,
          height: 1.3,
        ),
        bodyLarge: text.bodyLarge?.copyWith(height: 1.6),
        bodyMedium: text.bodyMedium?.copyWith(height: 1.5),
      ),

      // AppBar
      appBarTheme: AppBarTheme(
        backgroundColor: scheme.surface,
        foregroundColor: scheme.onSurface,
        surfaceTintColor: Colors.transparent,
        scrolledUnderElevation: 0,
        centerTitle: false,
        elevation: 0,
        titleTextStyle: text.titleLarge?.copyWith(
          color: scheme.onSurface,
          fontWeight: FontWeight.w700,
        ),
      ),

      // Card (Menggunakan warna solid untuk border tanpa opacity)
      cardTheme: CardThemeData(
        color: scheme.surfaceContainer,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(
            color: isDark ? const Color(0xFF293746) : const Color(0xFFD1D5DB),
          ),
        ),
      ),

      // Buttons
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryOrange,
          foregroundColor: Colors.white,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),

      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: primaryOrange,
          foregroundColor: Colors.white,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),

      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: scheme.secondary,
          side: BorderSide(color: scheme.outlineVariant),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),

      // Chips (Menggunakan warna solid pengganti opacity)
      chipTheme: base.chipTheme.copyWith(
        shape: const StadiumBorder(),
        selectedColor: isDark
            ? const Color(0xFF332718)
            : const Color(0xFFFDF3E7),
        secondarySelectedColor: isDark
            ? const Color(0xFF332718)
            : const Color(0xFFFDF3E7),
        side: BorderSide.none,
        labelStyle: text.labelLarge,
      ),

      // Divider (Menggunakan warna solid)
      dividerTheme: DividerThemeData(
        color: isDark ? const Color(0xFF293746) : const Color(0xFFE5E7EB),
        thickness: 1,
        space: 1,
      ),

      // Navigation Bar (Menggunakan warna solid pengganti opacity)
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: scheme.surfaceContainer,
        indicatorColor: isDark
            ? const Color(0xFF332718)
            : const Color(0xFFFDF3E7),
        elevation: 0,
        height: 72,
        labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
        iconTheme: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return const IconThemeData(color: primaryOrange);
          }

          return IconThemeData(color: scheme.onSurfaceVariant);
        }),
        labelTextStyle: WidgetStateProperty.resolveWith((states) {
          return text.labelSmall?.copyWith(
            fontWeight: states.contains(WidgetState.selected)
                ? FontWeight.w700
                : FontWeight.w500,
            color: states.contains(WidgetState.selected)
                ? primaryOrange
                : scheme.onSurfaceVariant,
          );
        }),
      ),

      // Input Fields
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: scheme.surfaceContainer,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: scheme.outlineVariant),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: scheme.outlineVariant),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: primaryOrange, width: 1.5),
        ),
      ),

      // SnackBar
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        backgroundColor: isDark ? const Color(0xFF293746) : charcoal,
        contentTextStyle: const TextStyle(color: Colors.white),
      ),

      // Page Transitions
      pageTransitionsTheme: const PageTransitionsTheme(
        builders: {
          TargetPlatform.android: PredictiveBackPageTransitionsBuilder(),
          TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
        },
      ),
    );
  }
}
