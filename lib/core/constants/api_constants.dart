import 'package:flutter_dotenv/flutter_dotenv.dart';

// TODO 2: Setup API Constants
// 1. Definisikan baseUrl NewsAPI
// 2. Buat getter untuk mengambil API Key dari dotenv
// 3. Tentukan country (misal: 'us') dan language (misal: 'en')

class ApiConstants {
  ApiConstants._();

  static const String baseUrl = 'https://newsapi.org/v2'; // Isi dengan base URL NewsAPI
  
  static String get apiKey => (dotenv.maybeGet('NEWS_API_KEY') ?? '').trim();

  // for classifications of country that will be shown on top-headlines
  static const String country = 'us';

  // for language that will be shown on searching process
  static const String language = 'en';

  // to tell how much news will be shown in one request
  static const int pageSize = 30;

  // as the maximum time of how long application/client can connect with the API
  static const Duration timeout = Duration(seconds: 15);
}
