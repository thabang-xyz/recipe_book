// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recipe_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RecipeModel _$RecipeModelFromJson(Map<String, dynamic> json) => RecipeModel(
      id: (json['id'] as num?)?.toInt(),
      recipeName: json['recipe_name'] as String?,
      description: json['description'] as String?,
      imageUrl: json['image_url'] as String?,
      ingredients: (json['ingredients'] as List<dynamic>?)
          ?.map((e) => e as Map<String, dynamic>)
          .toList(),
      instructions: (json['instructions'] as List<dynamic>?)
          ?.map((e) => e as Map<String, dynamic>)
          .toList(),
      estCookingTime: json['est_cooking_time'] as String?,
      isFavorite: json['isFavorite'] as bool?,
      recipeType: json['recipe_type'] as String?,
    );

Map<String, dynamic> _$RecipeModelToJson(RecipeModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'recipe_name': instance.recipeName,
      'description': instance.description,
      'image_url': instance.imageUrl,
      'ingredients': instance.ingredients,
      'instructions': instance.instructions,
      'est_cooking_time': instance.estCookingTime,
      'isFavorite': instance.isFavorite,
      'recipe_type': instance.recipeType,
    };
