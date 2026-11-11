// TODO 1: Buat class Article
// 1. Buat class dengan properti: title, sourceName, author, description, url, imageUrl, publishedAt, content
// 2. Buat factory constructor `fromJson(Map<String, dynamic> json)`
// 3. Buat getter `cleanContent` untuk menghapus teks "[+... chars]" dari content
// 4. Buat getter `isValid` untuk memastikan artikel bukan "[Removed]"

class Article {
  // Siswi akan melengkapi bagian ini.
  const Article({
    required this.title,
    required this.sourceName,
    required this.url,
    required this.publishedAt,
    this.author,
    this.description,
    this.imageUrl,
    this.content,
  });

  final String title;
  final String sourceName;
  final String url;
  final DateTime? publishedAt;
  final String? author;
  final String? description;
  final String? imageUrl;
  final String? content;

  // TODO: Implementasi cleanContent
  String get cleanContent =>
      (content ?? '').replaceAll(RegExp(r'\s*\[\+\d+ chars\]$'), '').trim();

  // TODO: Implementasi isValid
  bool get isValid =>
      title.isNotEmpty && title != '[Removed]' && url.isNotEmpty;

  @override
  bool operator ==(Object other) => other is Article && other.url == url;

  // Syntax in dart language that was used in flutter to change override, how object make a random value, hashCode
  @override
  int get hashCode => url.hashCode;
  // that getter functioning to change all the code into random value code, the aim is to keep the code safe

  // JSON CONVERTION
  // TODO: Implementasi fromJson. to converse into Dart Language, not raw Json.
  factory Article.fromJson(Map<String, dynamic> json) {
    final source = json['source'] as Map<String, dynamic>?;
    return Article(
      title: json['title'] as String? ?? '',
      sourceName: source?['name'] as String? ?? 'Tanpa Sumber',
      url: json['url'] as String? ?? '',
      publishedAt: DateTime.tryParse(json['publishedAt'] as String? ?? ''),
      author: json['author'] as String?,
      description: json['description'] as String?,
      imageUrl: json['urlToImage'] as String?,
      content: json['content'] as String?,
    );
  }

  // TODO: Implementasi toJson. return to json so it doesn't get the wrong address. 2 steps verifications.
  Map<String, dynamic> toJson() => {
    'title': title,
    'url': url,
    'source': {'name': sourceName},
    'description': description,
    'content': content,
    'author': author,
    'urlToImage': imageUrl,
    'publishedAt': publishedAt?.toIso8601String(),
  };

  // Dummy article untuk UI sementara
  static final dummy = Article(
    title: 'Berita Menarik Hari Ini',
    sourceName: 'Inkora News',
    url: 'https://example.com',
    publishedAt: DateTime.now(),
    description:
        'Ini adalah deskripsi berita sementara sebelum API disambungkan.',
    imageUrl: 'https://picsum.photos/400/200',
    content: 'Isi konten berita yang lebih panjang akan muncul di sini.',
  );
}
