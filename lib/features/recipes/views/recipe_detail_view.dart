// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:recipe_book/core/constants.dart';
import '../models/recipe_model.dart';

class RecipeDetailView extends StatefulWidget {
  final RecipeModel recipe;

  const RecipeDetailView({super.key, required this.recipe});

  @override
  _RecipeDetailViewState createState() => _RecipeDetailViewState();
}

class _RecipeDetailViewState extends State<RecipeDetailView> {
  double _currentRating = 4.6;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.close, color: Colors.black),
            onPressed: () {
              Navigator.pop(context);
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              Text(
                widget.recipe.recipeName ?? 'No title available',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300, width: 2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Image.network(
                        widget.recipe.imageUrl ??
                            'https://order.foodworks.org/assets/img/foodworks/default-menu-image-placeholder.png',
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: 250,
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) {
                            return child;
                          }
                          return const Center(
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                            ),
                          );
                        },
                        errorBuilder: (context, error, stackTrace) {
                          return Image.network(
                            'https://order.foodworks.org/assets/img/foodworks/default-menu-image-placeholder.png',
                            fit: BoxFit.cover,
                            width: double.infinity,
                            height: 250,
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildDetailInfo('Estimated Time',
                      widget.recipe.estCookingTime ?? 'Unknown'),
                  _buildDetailInfo(
                      'Recipe Type', widget.recipe.recipeType ?? 'Unknown'),
                  _buildStarRating(context),
                ],
              ),
              const SizedBox(height: 20),
              const Text(
                AppStrings.descriptionLabel,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                widget.recipe.description ??
                    AppStrings.noDescriptionErroeMessage,
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 30),
              const Text(
                AppStrings.ingredientsLabel,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: widget.recipe.ingredients?.map((ingredient) {
                      return Text(
                        '- ${ingredient['quantity']} of ${ingredient['name']}',
                        style: const TextStyle(fontSize: 16),
                      );
                    }).toList() ??
                    [const Text(AppStrings.noIngredientsErroeMessage)],
              ),
              const SizedBox(height: 30),
              const Text(
                AppStrings.instructionsLabel,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              Column(
                children: widget.recipe.instructions?.map((step) {
                      return _buildRecipeStep(step['step_number'] ?? 0,
                          step['description'] ?? 'No description available');
                    }).toList() ??
                    [const Text(AppStrings.noInstructionsErrorMessage)],
              ),
              const SizedBox(height: 30),
              _buildRatingButton(),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailInfo(String title, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(color: Colors.grey.shade600, fontSize: 14),
        ),
        Text(
          value,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildStarRating(BuildContext context) {
    return InkWell(
      onTap: () {
        _showRatingBottomSheet(context, _currentRating);
      },
      child: Row(
        children: [
          const Icon(Icons.star, color: Colors.orange, size: 20),
          const SizedBox(width: 4),
          Text(
            _currentRating.toStringAsFixed(1),
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget _buildRecipeStep(int stepNumber, String stepText) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              CircleAvatar(
                radius: 15,
                backgroundColor:
                    stepNumber == 1 ? Colors.green : Colors.grey[300],
                child: Text(
                  '$stepNumber',
                  style: const TextStyle(color: Colors.white),
                ),
              ),
              if (stepNumber != widget.recipe.instructions?.length)
                Container(
                  height: 50,
                  width: 2,
                  color: Colors.grey[300],
                ),
            ],
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Text(
              stepText,
              style: const TextStyle(fontSize: 16),
            ),
          ),
          const SizedBox(width: 20),
        ],
      ),
    );
  }

  Widget _buildRatingButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0),
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
            _showRatingBottomSheet(context, _currentRating);
          },
          child: const Text(AppStrings.rateRecipeButton),
        ),
      ),
    );
  }

  void _showRatingBottomSheet(BuildContext context, double currentRating) {
    showModalBottomSheet(
      backgroundColor: Colors.white,
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        int selectedRating = (currentRating).ceil();

        return StatefulBuilder(
          builder: (context, setStateBottomSheet) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    AppStrings.rateRecipeLabel,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(5, (index) {
                      return IconButton(
                        icon: Icon(
                          index < selectedRating
                              ? Icons.star
                              : Icons.star_border,
                          size: 30,
                          color: index < selectedRating
                              ? Colors.orange
                              : Colors.grey,
                        ),
                        onPressed: () {
                          setStateBottomSheet(() {
                            selectedRating = index + 1;
                          });
                        },
                      );
                    }),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20.0),
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
                          setState(() {
                            _currentRating = selectedRating.toDouble();
                          });
                          Navigator.pop(context);
                        },
                        child: const Text(AppStrings.submitButton),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
