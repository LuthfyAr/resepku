import 'package:resepku/models/ingredient.dart';

class Recipe {
  final String name;
  final String images;
  final double rating;
  final String totalTime;
  final List<Ingredient> ingredients;
  final List<String> instructions;
  final String category; 

  Recipe({
    required this.name,
    required this.images,
    required this.rating,
    required this.totalTime,
    required this.ingredients,
    required this.instructions,
    required this.category, 
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

    
    String category = json['category'] as String? ?? 'Uncategorized';

    return Recipe(
      name: json['name'] as String? ?? 'No Name',
      images: (json['images'] != null && json['images'].isNotEmpty)
          ? json['images'][0]['hostedLargeUrl'] as String? ?? ''
          : '',
      rating: (json['rating'] as double?) ?? 0.0,
      totalTime: json['totalTime'] as String? ?? 'Unknown',
      ingredients: ingredientsList,
      instructions: instructionsList,
      category: category, 
    );
  }


  static List<Recipe> recipesFromSnapshot(List snapshot) {
    return snapshot.map((data) {
      return Recipe.fromJson(data);
    }).toList();
  }

  @override
  String toString() {
    return 'Recipe {name: $name, image: $images, rating: $rating, totalTime: $totalTime, category: $category, ingredients: $ingredients, instructions: $instructions}';
  }
}
