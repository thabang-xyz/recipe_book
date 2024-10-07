import 'package:flutter/material.dart';
import 'package:recipe_book/config/keys.dart';
import 'package:recipe_book/core/constants.dart';
import '../services/recipe_service.dart';

class AddRecipeController with ChangeNotifier {
  final RecipeService _recipeService = RecipeServiceFactory.create();

  final TextEditingController recipeNameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController imageUrlController = TextEditingController();
  final TextEditingController estCookingTimeController =
      TextEditingController();

  List<Map<String, String>> ingredients = [];
  List<Map<String, dynamic>> instructions = [];
  String selectedRecipeType = 'Non-Vegetarian';
  bool isLoading = false;

  String? recipeNameError;
  String? descriptionError;
  String? ingredientsError;
  String? instructionsError;

  final TextEditingController ingredientNameController =
      TextEditingController();
  final TextEditingController ingredientQuantityController =
      TextEditingController();
  final TextEditingController instructionDescriptionController =
      TextEditingController();
  final TextEditingController instructionStepController =
      TextEditingController();

  void addIngredient(String name, String quantity) {
    if (name.isNotEmpty && quantity.isNotEmpty) {
      ingredients.add({'name': name, 'quantity': quantity});
      notifyListeners();
    }
  }

  void addInstruction(String description, int stepNumber) {
    if (description.isNotEmpty && stepNumber > 0) {
      instructions.add({'description': description, 'step_number': stepNumber});
      notifyListeners();
    }
  }

  void clearFields() {
    recipeNameController.clear();
    descriptionController.clear();
    imageUrlController.clear();
    estCookingTimeController.clear();
    ingredients.clear();
    instructions.clear();
    selectedRecipeType = 'Non-Vegetarian';
    recipeNameError = null;
    descriptionError = null;
    ingredientsError = null;
    instructionsError = null;
    notifyListeners();
  }

  bool validate() {
    bool isValid = true;

    if (recipeNameController.text.isEmpty) {
      recipeNameError = AppStrings.recipeNameErrorMessage;
      isValid = false;
    } else {
      recipeNameError = null;
    }

    if (descriptionController.text.isEmpty) {
      descriptionError = AppStrings.descriptionErrorMessage;
      isValid = false;
    } else {
      descriptionError = null;
    }

    if (ingredients.isEmpty) {
      ingredientsError = AppStrings.ingredientsErrorMessage;
      isValid = false;
    } else {
      ingredientsError = null;
    }

    if (instructions.isEmpty) {
      instructionsError = AppStrings.instructionsErrorMessage;
      isValid = false;
    } else {
      instructionsError = null;
    }

    notifyListeners();
    return isValid;
  }

  Future<void> addRecipe(
      BuildContext context, VoidCallback onRecipeAdded) async {
    if (!validate()) {
      return;
    }

    isLoading = true;
    notifyListeners();

    final recipeData = {
      'recipe_name': recipeNameController.text,
      'description': descriptionController.text,
      'image_url': imageUrlController.text,
      'est_cooking_time': estCookingTimeController.text,
      'recipe_type': selectedRecipeType,
      'ingredients': ingredients,
      'instructions': instructions,
    };

    const String apiKey = ConfigKeys.apiKey;
    const String authorization = ConfigKeys.bearerToken;

    try {
      await _recipeService.addRecipe(apiKey, authorization, recipeData);
      isLoading = false;
      notifyListeners();
      clearFields();
      onRecipeAdded();
      Navigator.of(context).pop();
    } catch (error) {
      isLoading = false;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text(AppStrings.saveErrorMessage)),
      );
      notifyListeners();
    }
  }
}
