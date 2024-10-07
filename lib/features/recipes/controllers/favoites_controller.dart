import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:recipe_book/config/keys.dart';
import 'package:recipe_book/core/constants.dart';
import '../models/recipe_model.dart';
import '../services/recipe_service.dart';

class FavoritesController with ChangeNotifier {
  final List<RecipeModel> _favorites = [];
  final RecipeService _recipeService = RecipeServiceFactory.create();
  bool _isLoading = false;

  List<RecipeModel> get favorites => _favorites;
  bool get isLoading => _isLoading;

  Future<void> fetchFavorites(BuildContext context) async {
    _isLoading = true;
    notifyListeners();

    try {
      final favoriteRecipes =
          await _recipeService.getFavoriteRecipes(ConfigKeys.apiKey);
      _favorites.clear();
      _favorites.addAll(favoriteRecipes);
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching favorite recipes: $e');
      }
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text(AppStrings.fetchErrorMessage)),
      );
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> addToFavorites(BuildContext context, RecipeModel recipe) async {
    if (!_favorites.contains(recipe)) {
      _favorites.add(recipe);
      notifyListeners();

      try {
        if (kDebugMode) {
          print('attempting to mark recipe ${recipe.id} as favorite');
        }
        await _recipeService.markAsFavorite(
          recipe.id!,
          ConfigKeys.apiKey,
          ConfigKeys.bearerToken,
          {"is_favorite": true},
        );
      } catch (e) {
        _favorites.remove(recipe);
        notifyListeners();
        if (kDebugMode) {
          print('Error adding recipe to favorites: $e');
        }
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text(AppStrings.addFavoriteErrorMessage)),
        );
      }
    }
  }

  Future<void> removeFromFavorites(
      BuildContext context, RecipeModel recipe) async {
    if (_favorites.contains(recipe)) {
      _favorites.remove(recipe);
      notifyListeners();

      try {
        await _recipeService.markAsFavorite(
          recipe.id!,
          ConfigKeys.apiKey,
          ConfigKeys.bearerToken,
          {"is_favorite": false},
        );
      } catch (e) {
        _favorites.add(recipe);
        notifyListeners();
        if (kDebugMode) {
          print('Error removing recipe from favorites: $e');
        }
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text(AppStrings.removeFavoriteErrorMessage)),
        );
      }
    }
  }

  bool isFavorite(RecipeModel recipe) {
    return _favorites.contains(recipe);
  }
}
