import 'dart:convert';
import 'dart:io';
import 'package:app_e_commerce/exceptions/storage_exception.dart';
import 'package:app_e_commerce/features/Console/domain/models/console_model.dart';
import 'package:app_e_commerce/features/favorites/domain/repositories/favorites_repository_interface.dart';
import 'package:app_e_commerce/features/games/domain/model/game_model.dart';
import 'package:app_e_commerce/features/products/domain/product_model.dart';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';

class FavoritesRepository implements IFavoritesRepository {
  String get filename => "favorites.json";

  Future<File> getLocalFile() async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      return File('${directory.path}/$filename');
    } catch (e, stack) {
      debugPrint("Erreur lors de l'accès au répertoire pour $filename : $e\n$stack");
      throw StorageException("Impossible d'accéder au dossier des documents", e);
    }
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
      final dynamic decoded = jsonDecode(jsonString);
      if (decoded is! List) {
        debugPrint("Format inattendu pour $filename : une liste est attendue");
        return [];
      }
      return decoded.map<Product>((json) {
        if (json is! Map<String, dynamic>) {
          throw FormatException("Élément non valide dans $filename : $json");
        }
        if (json.containsKey('platform')) {
          return Game.fromJson(json);
        } else {
          return Console.fromJson(json);
        }
      }).toList();
    } on FormatException catch (e, stack) {
      debugPrint("Erreur de parsing JSON dans $filename : $e\n$stack");
      return [];
    } on FileSystemException catch (e, stack) {
      debugPrint("Erreur système de fichiers lors de la lecture de $filename : $e\n$stack");
      return [];
    } catch (e, stack) {
      debugPrint("Erreur inattendue lors de la lecture de $filename : $e\n$stack");
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
        return <String, dynamic>{};
      }).toList();
      await file.writeAsString(jsonEncode(jsonList), flush: true);
    } on FileSystemException catch (e, stack) {
      debugPrint("Erreur système de fichiers lors de l'écriture de $filename : $e\n$stack");
      throw StorageException("Échec de l'écriture du fichier des favoris", e);
    } catch (e, stack) {
      debugPrint("Erreur inattendue lors de l'écriture de $filename : $e\n$stack");
      throw StorageException("Erreur inattendue lors de la sauvegarde des favoris", e);
    }
  }
}
