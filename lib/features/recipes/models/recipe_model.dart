import 'package:json_annotation/json_annotation.dart';

part 'recipe_model.g.dart';

@JsonSerializable()
class RecipeModel {
  final int? id;
  @JsonKey(name: 'recipe_name')
  final String? recipeName;
  final String? description;
  @JsonKey(name: 'image_url')
  final String? imageUrl;
  final List<Map<String, dynamic>>? ingredients;
  final List<Map<String, dynamic>>? instructions;
  @JsonKey(name: 'est_cooking_time')
  final String? estCookingTime;
  final bool? isFavorite;
  @JsonKey(name: 'recipe_type')
  final String? recipeType;

  RecipeModel({
    this.id,
    this.recipeName,
    this.description,
    this.imageUrl,
    this.ingredients,
    this.instructions,
    this.estCookingTime,
    this.isFavorite,
    this.recipeType,
  });

  factory RecipeModel.fromJson(Map<String, dynamic> json) =>
      _$RecipeModelFromJson(json);
  Map<String, dynamic> toJson() => _$RecipeModelToJson(this);
}
