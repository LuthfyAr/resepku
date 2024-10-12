import 'package:resepku/models/ingredient.dart';

class Recipe {
  final String name;
  final String images;
  final double rating;
  final String totalTime;
  final List<Ingredient> ingredients;
  final List<String> instructions;

  Recipe({
    required this.name,
    required this.images,
    required this.rating,
    required this.totalTime,
    required this.ingredients,
    required this.instructions,
  });

  factory Recipe.fromJson(dynamic json) {
    List<Ingredient> ingredientsList =
        (json['ingredientLines'] as List).map((e) {
      return Ingredient.fromJson(e);
    }).toList();

    json = json['details'];
    List<String> instructionsList = (json['preparationSteps'] != null)
        ? List<String>.from(json['preparationSteps'])
        : [];

    return Recipe(
      name: json['name'] as String? ?? 'No Name',
      images: (json['images'] != null && json['images'].isNotEmpty)
          ? json['images'][0]['hostedLargeUrl'] as String? ?? ''
          : '',
      rating: (json['rating'] as double?) ?? 0.0,
      totalTime: json['totalTime'] as String? ?? 'Unknown',
      ingredients: ingredientsList,
      instructions: instructionsList,
    );
  }

  static List<Recipe> recipesFromSnapshot(List snapshot) {
    return snapshot.map((data) {
      return Recipe.fromJson(data);
    }).toList();
  }

  @override
  String toString() {
    return 'Recipe {name: $name, image: $images, rating: $rating, totalTime: $totalTime, ingredients: $ingredients, instructions: $instructions}';
  }
}
