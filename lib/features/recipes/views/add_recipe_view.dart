import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipe_book/core/constants.dart';
import '../controllers/add_recipe_controller.dart';

class AddRecipeView extends StatelessWidget {
  final VoidCallback onRecipeAdded;
  const AddRecipeView({super.key, required this.onRecipeAdded});

  @override
  Widget build(BuildContext context) {
    final recipeController = Provider.of<AddRecipeController>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(''),
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.black),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: () {
              if (!recipeController.isLoading) {
                recipeController.addRecipe(context, onRecipeAdded);
              }
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            TextFormField(
              controller: recipeController.recipeNameController,
              decoration: InputDecoration(
                hintStyle: const TextStyle(fontSize: 14),
                hintText: AppStrings.recipeNameHint,
                floatingLabelBehavior: FloatingLabelBehavior.always,
                labelText: AppStrings.recipeNameLabel,
                errorText: recipeController.recipeNameError,
              ),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: recipeController.descriptionController,
              decoration: InputDecoration(
                hintStyle: const TextStyle(fontSize: 14),
                hintText: AppStrings.descriptionHint,
                floatingLabelBehavior: FloatingLabelBehavior.always,
                labelText: AppStrings.descriptionLabel,
                errorText: recipeController.descriptionError,
              ),
              maxLines: 4,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: recipeController.imageUrlController,
              decoration: const InputDecoration(
                hintStyle: TextStyle(fontSize: 14),
                hintText: AppStrings.imageURLHint,
                labelText: AppStrings.imageURLLabel,
                floatingLabelBehavior: FloatingLabelBehavior.always,
              ),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: recipeController.estCookingTimeController,
              decoration: const InputDecoration(
                hintStyle: TextStyle(fontSize: 14),
                hintText: AppStrings.estimatedCookingTimeHint,
                labelText: AppStrings.estimatedCookingTimeLabel,
                floatingLabelBehavior: FloatingLabelBehavior.always,
              ),
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              value: recipeController.selectedRecipeType,
              items: const [
                DropdownMenuItem(
                    value: 'Non-Vegetarian', child: Text('Non-Vegetarian')),
                DropdownMenuItem(
                    value: 'Vegetarian', child: Text('Vegetarian')),
                DropdownMenuItem(value: 'Vegan', child: Text('Vegan')),
              ],
              onChanged: (value) {
                recipeController.selectedRecipeType = value!;
              },
              decoration: const InputDecoration(labelText: 'Recipe Type'),
            ),
            const SizedBox(height: 16),
            const Text('Ingredients:',
                style: TextStyle(fontWeight: FontWeight.bold)),
            ElevatedButton(
              onPressed: () {
                _showIngredientBottomSheet(context, recipeController);
              },
              child: const Text('Add Ingredient'),
            ),
            const SizedBox(height: 8),
            for (var ingredient in recipeController.ingredients)
              ListTile(
                title:
                    Text('${ingredient['name']} - ${ingredient['quantity']}'),
              ),
            if (recipeController.ingredientsError != null)
              Text(recipeController.ingredientsError!,
                  style: const TextStyle(color: Colors.red)),
            const SizedBox(height: 16),
            const Text('Instructions:',
                style: TextStyle(fontWeight: FontWeight.bold)),
            ElevatedButton(
              onPressed: () {
                _showInstructionBottomSheet(context, recipeController);
              },
              child: const Text('Add Instruction'),
            ),
            const SizedBox(height: 8),
            for (var instruction in recipeController.instructions)
              ListTile(
                title: Text(
                    'Step ${instruction['step_number']}: ${instruction['description']}'),
              ),
            if (recipeController.instructionsError != null)
              Text(recipeController.instructionsError!,
                  style: const TextStyle(color: Colors.red)),
          ],
        ),
      ),
    );
  }

  void _showIngredientBottomSheet(
      BuildContext context, AddRecipeController controller) {
    final TextEditingController ingredientNameController =
        TextEditingController();
    final TextEditingController ingredientQuantityController =
        TextEditingController();

    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: ingredientNameController,
                decoration: const InputDecoration(labelText: 'Ingredient Name'),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: ingredientQuantityController,
                decoration: const InputDecoration(labelText: 'Quantity'),
              ),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  onPressed: () {
                    final String name = ingredientNameController.text;
                    final String quantity = ingredientQuantityController.text;

                    if (name.isNotEmpty && quantity.isNotEmpty) {
                      controller.addIngredient(name, quantity);
                      Navigator.of(context).pop();
                    }
                  },
                  child: const Text('Add Ingredient'),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showInstructionBottomSheet(
      BuildContext context, AddRecipeController controller) {
    final TextEditingController instructionDescriptionController =
        TextEditingController();
    final TextEditingController instructionStepNumberController =
        TextEditingController();

    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: instructionDescriptionController,
                decoration:
                    const InputDecoration(labelText: 'Instruction Description'),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: instructionStepNumberController,
                decoration: const InputDecoration(labelText: 'Step Number'),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  final String description =
                      instructionDescriptionController.text;
                  final int stepNumber =
                      int.tryParse(instructionStepNumberController.text) ?? 0;

                  if (description.isNotEmpty && stepNumber > 0) {
                    controller.addInstruction(description, stepNumber);
                    Navigator.of(context).pop();
                  }
                },
                child: const Text('Add Instruction'),
              ),
            ],
          ),
        );
      },
    );
  }
}
