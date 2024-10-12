class Ingredient {
  final String ingredient;
  final double quantity;
  final String wholeLine;

  Ingredient({
    required this.ingredient,
    required this.quantity,
    required this.wholeLine,
  });

  factory Ingredient.fromJson(dynamic json) {
    return Ingredient(
      ingredient: json['ingredient'] as String? ?? 'No ingredient',
      quantity: json['quantity'] as double? ?? 0,
      wholeLine: json['wholeLine'] as String? ?? 'No wholeLine',
    );
  }
}
