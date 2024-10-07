// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipe_book/core/constants.dart';
import 'package:recipe_book/features/recipes/controllers/favoites_controller.dart';
import 'package:recipe_book/widgets/recipe_item_card_widget.dart';
import 'recipe_detail_view.dart';

class FavoritesView extends StatefulWidget {
  const FavoritesView({super.key});

  @override
  _FavoritesViewState createState() => _FavoritesViewState();
}

class _FavoritesViewState extends State<FavoritesView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<FavoritesController>().fetchFavorites(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(''),
        backgroundColor: Colors.white,
        elevation: 0,
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
      body: Consumer<FavoritesController>(
        builder: (context, controller, _) {
          if (controller.isLoading) {
            return const Center(
              child: CircularProgressIndicator(
                strokeWidth: 2.0,
              ),
            );
          }

          if (controller.favorites.isEmpty) {
            return const Center(
              child: Text(AppStrings.noFavoritesMessage),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16.0),
            itemCount: controller.favorites.length + 1,
            itemBuilder: (context, index) {
              if (index == 0) {
                return const Padding(
                  padding: EdgeInsets.only(bottom: 10.0),
                  child: Text(
                    AppStrings.favoiteRcipeHeader,
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                );
              } else {
                final recipe = controller.favorites[index - 1];
                return RecipeItemCardWidget(
                  recipe: recipe,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RecipeDetailView(recipe: recipe),
                      ),
                    );
                  },
                );
              }
            },
          );
        },
      ),
    );
  }
}
