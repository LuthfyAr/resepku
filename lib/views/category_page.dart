import 'package:flutter/material.dart';
import 'package:resepku/models/recipe.dart';
import 'package:resepku/models/recipe.api.dart';
import 'package:resepku/views/widgets/recipe_card.dart';
import 'package:resepku/views/recipe_detail.dart';
import 'package:cached_network_image/cached_network_image.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({super.key});

  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  late List<Recipe> _recipes;
  bool _isLoading = true;
  String selectedCategory = 'Semua'; // Kategori default

  final List<String> categories = [
    'Semua',
    'Breakfast',
    'Lunch/Dinner',
    'Dessert',
  ];

  @override
  void initState() {
    super.initState();
    fetchRecipes(); // Ambil semua resep saat halaman dibuka
  }

  Future<void> fetchRecipes([String? category]) async {
    setState(() {
      _isLoading = true;
    });

    try {
      List<Recipe> recipes = await RecipeApi.getRecipe(
        category: category != 'Semua' ? category : null,
      );

      setState(() {
        _recipes = recipes;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      print('Error: $e'); // Cetak error untuk debugging
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kategori Resep'),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Column(
        children: [
          // Grid button untuk kategori
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 2.5,
              ),
              itemCount: categories.length,
              itemBuilder: (context, index) {
                return _buildCategoryButton(categories[index]);
              },
            ),
          ),

          // Pemisah antara kategori dan daftar resep
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Divider(
              thickness: 2,
              color: Colors.grey.shade300,
              indent: 20,
              endIndent: 20,
            ),
          ),

          // Judul dan ikon di kiri layar
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              children: [
                Icon(Icons.restaurant_menu, size: 30, color: Colors.black),
                SizedBox(width: 10),
                Text(
                  'ResepKu',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),

          // Tulisan kategori aktif di bawah judul
          Padding(
            padding: const EdgeInsets.only(left: 20.0, top: 4.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Kategori: $selectedCategory',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Colors.black54,
                ),
              ),
            ),
          ),

          // Daftar resep berdasarkan kategori
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : _recipes.isEmpty
                    ? const Center(child: Text('Tidak ada resep ditemukan'))
                    : ListView.builder(
                        itemCount: _recipes.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => RecipeDetailPage(
                                    recipe: _recipes[index],
                                  ),
                                ),
                              );
                            },
                            child: RecipeCard(
                              title: _recipes[index].name,
                              cookTime: _recipes[index].totalTime,
                              rating: _recipes[index].rating.toString(),
                              thumbnailUrl: _recipes[index].images,
                            ),
                          );
                        },
                      ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryButton(String category) {
    final bool isSelected = category == selectedCategory;
    final String imageUrl = getCategoryImageUrl(category);

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedCategory = category;
        });
        fetchRecipes(selectedCategory); // Panggil API sesuai kategori
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          gradient: LinearGradient(
            colors: isSelected
                ? [Colors.blue, Colors.blueAccent]
                : [Colors.grey.shade500, Colors.grey.shade500],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          image: DecorationImage(
            image: CachedNetworkImageProvider(imageUrl),
            fit: BoxFit.cover,
            colorFilter: isSelected
                ? ColorFilter.mode(
                    Colors.black.withOpacity(0.4), BlendMode.darken)
                : null,
          ),
        ),
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Text(
            category,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  String getCategoryImageUrl(String category) {
    switch (category) {
      case 'Breakfast':
        return 'https://plus.unsplash.com/premium_photo-1700575182495-bc03ea22f871?q=80&w=1470&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D';
      case 'Lunch/Dinner':
        return 'https://images.unsplash.com/photo-1493808655842-aa308811e178?q=80&w=1470&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D';
      case 'Dessert':
        return 'https://plus.unsplash.com/premium_photo-1663133869198-0c3bb20d11ff?q=80&w=1470&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D';
      default:
        return 'https://plus.unsplash.com/premium_photo-1673108852141-e8c3c22a4a22?q=80&w=1470&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D';
    }
  }
}
