import 'dart:convert';
import 'dart:io';
import 'package:app_e_commerce/features/Console/domain/models/console_model.dart';
import 'package:app_e_commerce/features/games/domain/model/game_model.dart';
import 'package:app_e_commerce/features/products/domain/product_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';

class FavoritesRepository {
  String get filename => "favorites.json";

  Future<File> getLocalFile() async {
    final directory = await getApplicationDocumentsDirectory();
    return File('${directory.path}/$filename');
  }

  Future<List<Product>> loadFavorites() async {
    try {
      final file = await getLocalFile();
      if (!await file.exists()) {
        return [];
      }
      final jsonString = await file.readAsString();
      if (jsonString.trim().isEmpty) {
        return [];
      }
      final List jsonList = jsonDecode(jsonString);
      return jsonList.map<Product>((json) {
        if (json.containsKey('platform')) {
          return Game.fromJson(json);
        } else {
          return Console.fromJson(json);
        }
      }).toList();
    } catch (e) {
      return [];
    }
  }

  Future<void> saveFavorites(List<Product> favorites) async {
    try {
      final file = await getLocalFile();
      final jsonList = favorites.map((item) {
        if (item is Game) {
          return item.toJson();
        } else if (item is Console) {
          return item.toJson();
        }
        return {};
      }).toList();
      await file.writeAsString(jsonEncode(jsonList));
    } catch (e) {
      // Ignores write errors quietly
    }
  }
}

final favoritesRepositoryProvider = Provider<FavoritesRepository>((ref) {
  return FavoritesRepository();
});
