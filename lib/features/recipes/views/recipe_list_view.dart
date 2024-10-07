// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipe_book/core/constants.dart';
import 'package:recipe_book/features/recipes/views/add_recipe_view.dart';
import 'package:recipe_book/features/recipes/views/favorites_view.dart';
import 'package:recipe_book/features/recipes/views/recipe_detail_view.dart';
import 'package:recipe_book/widgets/recipe_item_card_widget.dart';
import '../controllers/recipe_controller.dart';

class RecipeListView extends StatefulWidget {
  const RecipeListView({super.key});

  @override
  _RecipeListViewState createState() => _RecipeListViewState();
}

class _RecipeListViewState extends State<RecipeListView> {
  String _searchQuery = '';
  int _recipesToShow = 6; // initially show 6 recipes
  final int _recipesPerPage = 6;
  List<String> _selectedRecipeTypes = [];
  RangeValues _selectedCookingTime =
      const RangeValues(1, 720); // 1 min to 12 hours (in minutes)

  @override
  void initState() {
    super.initState();
    _loadRecipes();
  }

  _loadRecipes() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<RecipeController>(context, listen: false)
          .fetchRecipes(context);
    });
  }

  void _showFilterByBottomSheet(BuildContext context) {
    showModalBottomSheet(
      backgroundColor: Colors.white,
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    AppStrings.filterByLabel,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey.shade600,
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      backgroundColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 16),
                    ),
                    onPressed: () {
                      setState(() {
                        _resetFilters();
                      });
                    },
                    child: const Text(AppStrings.resetFiltersButton),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const Text(
                AppStrings.recipeTypeLabel,
                style: TextStyle(fontWeight: FontWeight.w900),
              ),
              _buildRecipeTypeFilter(),
              const SizedBox(height: 20),
              const Text(
                'Cooking Time (in minutes)',
                style: TextStyle(fontWeight: FontWeight.w900),
              ),
              _buildCookingTimeFilter(),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                      setState(() {});
                    },
                    child: const Text(AppStrings.applyFiltersButton),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildRecipeTypeFilter() {
    final List<String> recipeTypes = ['Vegan', 'Vegetarian', 'Non-Vegetarian'];
    return Column(
      children: recipeTypes.map((type) {
        return CheckboxListTile(
          title: Text(type),
          value: _selectedRecipeTypes.contains(type),
          onChanged: (isSelected) {
            setState(() {
              if (isSelected!) {
                _selectedRecipeTypes.add(type);
              } else {
                _selectedRecipeTypes.remove(type);
              }
            });
          },
        );
      }).toList(),
    );
  }

  Widget _buildCookingTimeFilter() {
    return Column(
      children: [
        RangeSlider(
          values: _selectedCookingTime,
          min: 1,
          max: 720,
          divisions: 24,
          labels: RangeLabels(
            '${_selectedCookingTime.start.round()} min',
            '${_selectedCookingTime.end.round()} min',
          ),
          onChanged: (RangeValues newRange) {
            setState(() {
              _selectedCookingTime = newRange;
            });
          },
        ),
        Text(
          'Selected time: ${_selectedCookingTime.start.round()} min to ${_selectedCookingTime.end.round()} min',
          style: const TextStyle(color: Colors.grey),
        ),
      ],
    );
  }

  bool _filterByRecipeType(String? recipeType) {
    if (_selectedRecipeTypes.isEmpty) {
      return true;
    }
    return _selectedRecipeTypes.contains(recipeType);
  }

  bool _filterByCookingTime(String estCookingTime) {
    final timeParts = estCookingTime.split(' ');
    if (timeParts.length < 2) return false;
    final timeValue = int.tryParse(timeParts[0]);
    final timeUnit = timeParts[1].toLowerCase();

    int cookingTimeInMinutes;
    if (timeUnit.contains('hr')) {
      cookingTimeInMinutes = timeValue! * 60;
    } else {
      cookingTimeInMinutes = timeValue!;
    }

    return cookingTimeInMinutes >= _selectedCookingTime.start &&
        cookingTimeInMinutes <= _selectedCookingTime.end;
  }

  void _resetFilters() {
    setState(() {
      _selectedRecipeTypes = [];
      _selectedCookingTime = const RangeValues(1, 720);
    });
  }

  void _loadMoreRecipes() {
    setState(() {
      _recipesToShow += _recipesPerPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: const Text('', style: TextStyle(color: Colors.black)),
        actions: [
          GestureDetector(
            onTap: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                ),
                builder: (context) {
                  return AddRecipeView(
                    onRecipeAdded: () {
                      _loadRecipes();
                    },
                  );
                },
              );
            },
            child: const Row(
              children: [
                Text(
                  'Add New',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(width: 4),
                Icon(Icons.add, color: Colors.black),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.favorite, color: Colors.red),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const FavoritesView(),
                ),
              );
            },
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(
            color: Colors.grey.shade300,
            height: 1.0,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              AppStrings.cookingQuestionHeader,
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Container(
                  height: 48,
                  width: 48,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.filter_list, color: Colors.black),
                    onPressed: () {
                      _showFilterByBottomSheet(context);
                    },
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: AppStrings.searchRecipesHint,
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onChanged: (query) {
                      setState(() {
                        _searchQuery = query;
                      });
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Consumer<RecipeController>(
                builder: (context, controller, _) {
                  if (controller.isLoading) {
                    return const Center(
                        child: CircularProgressIndicator(
                      strokeWidth: 2,
                    ));
                  }

                  if (controller.recipes == null ||
                      controller.recipes.isEmpty) {
                    return const Center(
                      child: Text(
                        AppStrings.noRecipesAvailableMessage,
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.grey,
                        ),
                      ),
                    );
                  }

                  final filteredRecipes = controller.recipes.where((recipe) {
                    final titleLower = recipe.recipeName!.toLowerCase();
                    final descriptionLower = recipe.description!.toLowerCase();
                    final queryLower = _searchQuery.toLowerCase();
                    return (titleLower.contains(queryLower) ||
                            descriptionLower.contains(queryLower)) &&
                        _filterByRecipeType(recipe.recipeType) &&
                        _filterByCookingTime(recipe.estCookingTime!);
                  }).toList();

                  if (filteredRecipes.isEmpty) {
                    return const Center(
                      child: Text(
                        AppStrings.noRcipesMatchMessage,
                      ),
                    );
                  }

                  final totalRecipes = filteredRecipes.length;
                  final recipesToShow = filteredRecipes.sublist(
                    0,
                    _recipesToShow > totalRecipes
                        ? totalRecipes
                        : _recipesToShow,
                  );

                  return ListView.builder(
                    itemCount: recipesToShow.length + 1,
                    itemBuilder: (context, index) {
                      if (index == recipesToShow.length) {
                        return Visibility(
                          visible: _recipesToShow < totalRecipes,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 40.0),
                            child: SizedBox(
                              width: double.infinity,
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 0.0),
                                child: ElevatedButton(
                                  onPressed: _loadMoreRecipes,
                                  style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 16),
                                  ),
                                  child: const Text(AppStrings.loadMoreButton),
                                ),
                              ),
                            ),
                          ),
                        );
                      } else {
                        final recipe = recipesToShow[index];
                        return RecipeItemCardWidget(
                          recipe: recipe,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    RecipeDetailView(recipe: recipe),
                              ),
                            );
                          },
                        );
                      }
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
