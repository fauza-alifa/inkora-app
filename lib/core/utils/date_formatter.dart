import 'package:intl/intl.dart';

/// Helper format tanggal berbahasa Indonesia.
class DateFormatter {
  DateFormatter._();

  static const String _locale = 'id_ID';

  /// Contoh: "5 menit lalu", "3 jam lalu", "12 Okt 2026".
  static String relative(DateTime? date) {
    if (date == null) return '';
    final local = date.toLocal();
    final diff = DateTime.now().difference(local);

    if (diff.inMinutes < 1) return 'Baru saja';
    if (diff.inMinutes < 60) return '${diff.inMinutes} menit lalu';
    if (diff.inHours < 24) return '${diff.inHours} jam lalu';
    if (diff.inDays < 7) return '${diff.inDays} hari lalu';
    return DateFormat('d MMM yyyy', _locale).format(local);
  }

  /// Contoh: "Rabu, 7 Oktober 2026 • 22:40".
  static String full(DateTime? date) {
    if (date == null) return '';
    return DateFormat(
      'EEEE, d MMMM yyyy • HH:mm',
      _locale,
    ).format(date.toLocal());
  }

  /// Contoh: "Rabu, 7 Oktober".
  static String today() =>
      DateFormat('EEEE, d MMMM', _locale).format(DateTime.now());
}
