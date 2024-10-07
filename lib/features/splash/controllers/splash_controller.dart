import 'package:flutter/material.dart';
import 'package:recipe_book/features/fallouts/views/fallout_view.dart';
import '../../recipes/views/recipe_list_view.dart';
import '../../../config/supabase_config.dart';

class SplashController {
  void initialize(BuildContext context) async {
    try {
      await SupabaseConfig.initializeSupabase();
      await Future.delayed(const Duration(seconds: 3));

      if (context.mounted) {
        _navigateToHome(context);
      }
    } catch (e) {
      await Future.delayed(const Duration(seconds: 3));

      if (context.mounted) {
        _navigateToFallout(context);
      }
    }
  }

  void _navigateToHome(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const RecipeListView(),
      ),
    );
  }

  void _navigateToFallout(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const FalloutView(),
      ),
    );
  }
}
