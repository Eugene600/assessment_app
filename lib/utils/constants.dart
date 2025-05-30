import 'package:flutter_dotenv/flutter_dotenv.dart';

class Constants {
  static const baseUrl = 'https://kqgbftwsodpttpqgqnbh.supabase.co/rest/v1';
  static final Map<String, String> headers = {
    'apikey': dotenv.env['API_KEY'] ?? '',
    'Content-Type': 'application/json',
  };
  static const mediumScreenWidth = 600.00;
  static const spacing = 10.0;
  static const roundness = 10.0;
}
