import 'dart:convert';
import 'package:resepku/models/recipe.dart';
import 'package:http/http.dart' as http;

class RecipeApi {
  static const String _baseUrl = "yummly2.p.rapidapi.com";

  // Fungsi untuk mengambil semua resep tanpa kategori
  static Future<List<Recipe>> getRecipe({String? category}) async {
    var queryParameters = {
      "limit": '24',
      "start": '0',
    };

    var uri = Uri.https(_baseUrl, "feeds/list", queryParameters);

    final response = await http.get(uri, headers: {
      'x-rapidapi-key': '889d38223emsh38d34d2328ed933p11264fjsn7d4912612a91',
      'x-rapidapi-host': _baseUrl,
    });
    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);

      if (data['feed'] != null && data['feed'] is List) {
        List temp = [];
        for (var i in data['feed']) {
          if (i['content'] != null) {
            temp.add(i['content']);
          }
        }
        return Recipe.recipesFromSnapshot(temp);
      } else {
        print('Feed is empty or null');
        return [];
      }
    } else {
      throw Exception('Failed to load recipes');
    }
  }
}
