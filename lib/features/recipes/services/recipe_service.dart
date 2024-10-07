import 'package:recipe_book/config/keys.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';
import '../models/recipe_model.dart';

part 'recipe_service.g.dart';

@RestApi(baseUrl: 'https://qnqcjonhemvjgefmjeox.supabase.co/rest/v1/')
abstract class RecipeService {
  factory RecipeService(Dio dio, {String baseUrl}) = _RecipeService;

  @GET('/recipes')
  Future<List<RecipeModel>> getRecipes(
    @Header('apikey') String apiKey,
  );

  @POST('/recipes')
  Future<void> addRecipe(
    @Header('apikey') String apiKey,
    @Header('Authorization') String authorization,
    @Body() Map<String, dynamic> recipe,
  );

  @PATCH('/recipes?id=eq.{id}')
  Future<void> markAsFavorite(
    @Path('id') int recipeId,
    @Header('apikey') String apiKey,
    @Header('Authorization') String authorization,
    @Body() Map<String, dynamic> data,
  );

  @GET('/recipes?is_favorite=eq.true')
  Future<List<RecipeModel>> getFavoriteRecipes(
    @Header('apikey') String apiKey,
  );
}

class RecipeServiceFactory {
  static RecipeService create() {
    final dio = Dio();

    dio.options.headers["Authorization"] = ConfigKeys.bearerToken;
    dio.options.headers["apikey"] = ConfigKeys.apiKey;

    return RecipeService(dio);
  }
}
