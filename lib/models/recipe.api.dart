import 'dart:convert';
import 'package:resepku/models/recipe.dart';
import 'package:http/http.dart' as http;

class RecipeApi {
    static Future<List<Recipe>> getRecipe() async{
      var uri = Uri.https("yummly2.p.rapidapi.com", "feeds/list", 
        {	"limit": '24',"start": '0'});

      final response = await http.get(uri,headers:{	
        'x-rapidapi-key': '889d38223emsh38d34d2328ed933p11264fjsn7d4912612a91',
	      'x-rapidapi-host': 'yummly2.p.rapidapi.com'}
        );

      Map data = jsonDecode(response.body);
      List temp = [];

      for (var i in data['feed']) {
        temp.add(i['content']['details']);
      }
      return Recipe.recipesFromSnapshot(temp);
    }
}


