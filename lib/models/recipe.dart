class Recipe {
  final String name;
  final String images;
  final double rating;
  final String totalTime;

  Recipe({
    required this.name,
    required this.images,
    required this.rating,
    required this.totalTime,
  });

  factory Recipe.fromJson(dynamic json) {
    
    return Recipe(
      name: json['name'] as String? ?? 'No Name', // Nilai default 'No Name'
      images: (json['images'] != null && json['images'].isNotEmpty)
          ? json['images'][0]['hostedLargeUrl'] as String? ?? ''
          : '', 
      rating: (json['rating'] as double?) ?? 0.0, // Default rating 0.0
      totalTime: json['totalTime'] as String? ?? 'Unknown', // Nilai default
    );
  }

  get ingredients => null;

  get instructions => null;

  static List<Recipe> recipesFromSnapshot(List snapshot) {
    return snapshot.map((data) {
      return Recipe.fromJson(data);
    }).toList();
  }

  @override
  String toString() {
    return 'Recipe {name: $name, image: $images, rating: $rating, totalTime: $totalTime}';
  }
}
