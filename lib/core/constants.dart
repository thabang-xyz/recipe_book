class AppStrings {
  // header strings
  static const String cookingQuestionHeader = 'What are we cooking today?';
  static const String favoiteRcipeHeader = 'My Favorite Recipes';

  // button strings
  static const String loadMoreButton = 'Load more recipes';
  static const String addIngredientButton = 'Add ingredient';
  static const String addInstructionButton = 'Add instruction';
  static const String resetFiltersButton = 'Reset Filters';
  static const String applyFiltersButton = 'Apply Filters';
  static const String submitButton = 'Submit';
  static const String rateRecipeButton = 'Rate this recipe';

  // label strings
  static const String recipeNameLabel = 'Recipe Name';
  static const String descriptionLabel = 'Description';
  static const String imageURLLabel = 'Image URL';
  static const String estimatedCookingTimeLabel = 'Estimated Cooking Time';
  static const String recipeTypeLabel = 'Estimated Cooking Time';
  static const String ingredientsLabel = 'Ingredients';
  static const String instructionsLabel = 'Instructions';
  static const String filterByLabel = 'FILTER BY';
  static const String rateRecipeLabel = 'Rate this recipe';

  // label hint strings
  static const String searchRecipesHint = 'Search recipes...';
  static const String recipeNameHint = 'e.g. Chocolate Cake';
  static const String descriptionHint =
      'e.g. Delicious and moist chocolate cake';
  static const String imageURLHint = 'e.g. https://example-recipes/images.png';
  static const String estimatedCookingTimeHint = 'e.g. 120 MIN';
  static const String recipeTypeHint = 'e.g. Non-Vegan';

  // input field error strings
  static const String recipeNameErrorMessage = 'Recipe Name cannot be empty';
  static const String descriptionErrorMessage = 'Description cannot be empty';
  static const String ingredientsErrorMessage =
      'At least one ingredient is required';
  static const String instructionsErrorMessage =
      'At least one instruction is required';

  // fallout messages
  static const String connectErrorMessage = 'Failed to connect to Supabase';
  static const String fetchErrorMessage = 'Failed to fetch recipes';
  static const String saveErrorMessage = 'Failed to save recipe';
  static const String addFavoriteErrorMessage =
      'Failed to add recipe to favorites';
  static const String removeFavoriteErrorMessage =
      'Failed to remove recipe from favorites';
  static const String noFavoritesMessage = 'No favorite recipes found';
  static const String noRcipesMatchMessage =
      'No recipes match your search or filters';
  static const String loadingMessage = 'Loading...';
  static const String noRecipesAvailableMessage = 'No recipes available';
  static const String noInstructionsErrorMessage = 'No instructions available';
  static const String noIngredientsErroeMessage = 'No ingredients available';
  static const String noDescriptionErroeMessage = 'No description available.';
}
