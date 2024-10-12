import 'package:flutter/material.dart';
import 'package:resepku/models/recipe.dart';

class RecipeDetailPage extends StatelessWidget {
  final Recipe recipe;

  RecipeDetailPage({required this.recipe});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(recipe.name),
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Bagian gambar
            Stack(
              children: [
                Container(
                  height: 250,
                  width: double.infinity,
                  child: Image.network(
                    recipe.images,
                    fit: BoxFit.cover,
                  ),
                ),
                Container(
                  height: 250,
                  width: double.infinity,
                  color: Colors.black.withOpacity(0.3),
                ),
                Positioned(
                  bottom: 16,
                  left: 16,
                  child: Text(
                    recipe.name,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            // Bagian detail resep
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Bahan-bahan
                  Text(
                    'Bahan-bahan:',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 8),
                  ...recipe.ingredients.map((ingredient) => ListTile(
                        leading: Icon(Icons.check_box_outline_blank),
                        title: Text(ingredient.wholeLine),
                      )),
                  SizedBox(height: 16),
                  // Instruksi
                  Text(
                    'Instruksi:',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 8),
                  ...recipe.instructions.asMap().entries.map((entry) {
                    int idx = entry.key + 1;
                    String step = entry.value;
                    return ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.orangeAccent,
                        child: Text(
                          '$idx',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      title: Text(step),
                    );
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
