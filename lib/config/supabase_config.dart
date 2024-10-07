import 'package:recipe_book/config/keys.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseConfig {
  static const String supabaseUrl = 'https://qnqcjonhemvjgefmjeox.supabase.co';
  static const String supabaseAnonKey = ConfigKeys.apiKey;

  static Future<void> initializeSupabase() async {
    await Supabase.initialize(
      url: supabaseUrl,
      anonKey: supabaseAnonKey,
    );
  }

  static SupabaseClient get client => Supabase.instance.client;
}
