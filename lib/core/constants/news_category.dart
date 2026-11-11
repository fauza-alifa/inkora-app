/// Kategori berita yang didukung oleh endpoint top-headlines NewsAPI.
enum NewsCategory {
  general('Utama'),
  business('Bisnis'),
  technology('Teknologi'),
  science('Sains'),
  health('Kesehatan'),
  sports('Olahraga'),
  entertainment('Hiburan');

  const NewsCategory(this.label);

  /// Label yang ditampilkan di UI.
  final String label;

  /// Nilai yang dikirim ke API.
  String get apiValue => name;
}
