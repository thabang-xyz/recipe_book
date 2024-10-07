import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:recipe_book/config/keys.dart';
import 'package:recipe_book/core/constants.dart';
import '../models/recipe_model.dart';
import '../services/recipe_service.dart';

class RecipeController with ChangeNotifier {
  final RecipeService _recipeService = RecipeServiceFactory.create();

  bool isLoading = false;
  List<RecipeModel> _recipes = [];

  List<RecipeModel> get recipes => _recipes;

  Future<void> fetchRecipes(BuildContext context) async {
    isLoading = true;
    notifyListeners();

    try {
      _recipes = await _recipeService.getRecipes(
        ConfigKeys.apiKey,
      );
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching recipes: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text(AppStrings.fetchErrorMessage)),
        );
      }
    }

    isLoading = false;
    notifyListeners();
  }
}
