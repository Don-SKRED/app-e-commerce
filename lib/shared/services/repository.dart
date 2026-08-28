import 'dart:convert';
import 'dart:io';

import 'package:app_e_commerce/exceptions/storage_exception.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

abstract class Repository<T> {
  String get filename;
  String get assetPath;

  T fromJson(Map<String, dynamic> json);
  Map<String, dynamic> toJson(T item);

  Future<File> getLocalfile() async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      return File('${directory.path}/$filename');
    } catch (e, stack) {
      debugPrint("Erreur lors de l'accès au répertoire pour $filename : $e\n$stack");
      throw StorageException("Impossible d'accéder au dossier de stockage", e);
    }
  }

  Future<File> initFile() async {
    try {
      final file = await getLocalfile();

      if (!await file.exists()) {
        try {
          final initialData = await rootBundle.loadString(assetPath);
          await file.writeAsString(initialData, flush: true);
        } catch (e, stack) {
          debugPrint(
            "Impossible de charger les données initiales depuis $assetPath : $e\n$stack",
          );
          await file.writeAsString("[]", flush: true);
        }
      }
      return file;
    } catch (e, stack) {
      debugPrint("Erreur lors de l'initialisation du fichier $filename : $e\n$stack");
      throw StorageException("Erreur lors de l'initialisation du fichier $filename", e);
    }
  }

  Future<List<T>> readFile() async {
    try {
      final file = await initFile();
      String jsonString = await file.readAsString();

      if (jsonString.trim().isEmpty) {
        return [];
      }

      final dynamic decoded = jsonDecode(jsonString);
      if (decoded is! List) {
        debugPrint("Format inattendu pour $filename : une liste est attendue");
        return [];
      }

      return decoded
          .map((json) => fromJson(json as Map<String, dynamic>))
          .toList();
    } on FormatException catch (e, stack) {
      debugPrint("Format JSON corrompu ou invalide dans $filename : $e\n$stack");
      return [];
    } on FileSystemException catch (e, stack) {
      debugPrint("Erreur système de fichiers lors de la lecture de $filename : $e\n$stack");
      return [];
    } catch (e, stack) {
      debugPrint("Erreur inattendue lors de la lecture de $filename : $e\n$stack");
      return [];
    }
  }

  Future<T?> findById(int id) async {
    try {
      final list = await readFile();
      for (var item in list) {
        if ((item as dynamic).id == id) {
          return item;
        }
      }
      return null;
    } catch (e, stack) {
      debugPrint("Erreur findById dans $filename pour l'id $id : $e\n$stack");
      return null;
    }
  }

  Future<void> add(T item) async {
    try {
      List<T> items = await readFile();
      final file = await getLocalfile();
      items.add(item);
      await file.writeAsString(
        jsonEncode(items.map((item) => toJson(item)).toList()),
        flush: true,
      );
    } on FileSystemException catch (e, stack) {
      debugPrint("Erreur I/O lors de l'ajout dans $filename : $e\n$stack");
      throw StorageException("Échec de l'enregistrement dans $filename", e);
    } catch (e, stack) {
      debugPrint("Erreur inattendue lors de l'ajout dans $filename : $e\n$stack");
      throw StorageException("Erreur inattendue lors de l'enregistrement", e);
    }
  }

  Future<void> update(int id, T updatedItem) async {
    try {
      List<T> items = await readFile();
      final file = await getLocalfile();
      final index = items.indexWhere((item) => (item as dynamic).id == id);
      if (index != -1) {
        items[index] = updatedItem;
        await file.writeAsString(
          jsonEncode(items.map((item) => toJson(item)).toList()),
          flush: true,
        );
      }
    } on FileSystemException catch (e, stack) {
      debugPrint("Erreur I/O lors de la mise à jour dans $filename : $e\n$stack");
      throw StorageException("Échec de la mise à jour dans $filename", e);
    } catch (e, stack) {
      debugPrint("Erreur inattendue lors de la mise à jour dans $filename : $e\n$stack");
      throw StorageException("Erreur inattendue lors de la mise à jour", e);
    }
  }

  Future<int> generateNewId() async {
    final list = await readFile();
    if (list.isEmpty) return 1;

    int maxId = 0;
    for (var item in list) {
      final itemId = (item as dynamic).id;
      if (itemId > maxId) {
        maxId = itemId;
      }
    }
    return maxId + 1;
  }
}
