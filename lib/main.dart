import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipe_book/features/recipes/controllers/favoites_controller.dart';
import 'features/recipes/controllers/recipe_controller.dart';
import 'features/recipes/controllers/add_recipe_controller.dart';
import 'features/splash/views/splash_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => RecipeController()),
        ChangeNotifierProvider(create: (_) => FavoritesController()),
        ChangeNotifierProvider(create: (_) => AddRecipeController()),
      ],
      child: const MaterialApp(
        title: 'Recipe Book',
        debugShowCheckedModeBanner: false,
        home: SplashView(),
      ),
    );
  }
}
