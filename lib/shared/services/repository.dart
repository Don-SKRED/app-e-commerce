import 'dart:convert';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

abstract class Repository<T> {
  String get filename;
  String get assetPath;

  T fromJson(Map<String, dynamic> json);
  Map<String, dynamic> toJson(T item);

  // ── Accès au fichier local ───────────────────────────────────────────────

  Future<File> getLocalfile() async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      return File('${directory.path}/$filename');
    } catch (e) {
      throw RepositoryException(
        'Impossible d\'accéder au répertoire de l\'application : $e',
      );
    }
  }

  /// Initialise le fichier local depuis l'asset si absent.
  /// En cas d'asset manquant ou inaccessible, crée un fichier vide `[]`.
  Future<File> initFile() async {
    final file = await getLocalfile();

    if (!await file.exists()) {
      String initialData;
      try {
        initialData = await rootBundle.loadString(assetPath);
      } catch (_) {
        // L'asset n'existe pas ou est inaccessible → on démarre avec une liste vide.
        initialData = '[]';
      }
      try {
        await file.writeAsString(initialData);
      } catch (e) {
        throw RepositoryException(
          'Impossible d\'initialiser le fichier "$filename" : $e',
        );
      }
    }
    return file;
  }

  // ── Lecture ─────────────────────────────────────────────────────────────

  /// Lit la liste depuis le fichier JSON local.
  ///
  /// - Si le fichier est vide → retourne `[]`.
  /// - Si le JSON est corrompu → réinitialise le fichier depuis l'asset
  ///   et retourne `[]` (évite un crash irrémédiable).
  /// - Si un enregistrement individuel est invalide → il est ignoré
  ///   (les autres restent accessibles).
  Future<List<T>> readFile() async {
    final file = await initFile();

    String jsonString;
    try {
      jsonString = await file.readAsString();
    } catch (e) {
      throw RepositoryException(
        'Impossible de lire le fichier "$filename" : $e',
      );
    }

    // Fichier réellement vide (0 octet ou seulement des espaces).
    if (jsonString.trim().isEmpty) {
      return [];
    }

    List<dynamic> jsonList;
    try {
      jsonList = jsonDecode(jsonString) as List<dynamic>;
    } on FormatException catch (e) {
      // JSON corrompu → on réinitialise le fichier pour restaurer un état cohérent.
      await _resetFile();
      throw RepositoryException(
        'Le fichier "$filename" contient du JSON invalide et a été réinitialisé. '
        'Détail : $e',
      );
    }

    // Désérialisation item par item : un enregistrement invalide n'empêche
    // pas les autres d'être chargés.
    final List<T> list = [];
    for (int i = 0; i < jsonList.length; i++) {
      try {
        list.add(fromJson(jsonList[i] as Map<String, dynamic>));
      } catch (e) {
        // Enregistrement corrompu ignoré sans bloquer le reste.
        // ignore: avoid_print
        print('[Repository] Entrée $i ignorée dans "$filename" — fromJson() a échoué : $e');
      }
    }
    return list;
  }

  // ── Recherche ────────────────────────────────────────────────────────────

  Future<T?> findById(int id) async {
    final list = await readFile();
    for (final item in list) {
      if ((item as dynamic).id == id) {
        return item;
      }
    }
    return null;
  }

  // ── Écriture ─────────────────────────────────────────────────────────────

  Future<void> add(T item) async {
    final items = await readFile();
    final file = await getLocalfile();
    items.add(item);
    await _writeJson(file, items);
  }

  Future<void> update(int id, T updatedItem) async {
    final items = await readFile();
    final file = await getLocalfile();
    final index = items.indexWhere((item) => (item as dynamic).id == id);
    if (index != -1) {
      items[index] = updatedItem;
      await _writeJson(file, items);
    }
  }

  // ── Génération d'ID ───────────────────────────────────────────────────────

  Future<int> generateNewId() async {
    final list = await readFile();
    if (list.isEmpty) return 1;

    int maxId = 0;
    for (final item in list) {
      final itemId = (item as dynamic).id as int;
      if (itemId > maxId) maxId = itemId;
    }
    return maxId + 1;
  }

  // ── Méthodes privées ─────────────────────────────────────────────────────

  /// Sérialise la liste et l'écrit dans le fichier de manière atomique.
  Future<void> _writeJson(File file, List<T> items) async {
    String encoded;
    try {
      encoded = jsonEncode(items.map(toJson).toList());
    } catch (e) {
      throw RepositoryException(
        'Impossible de sérialiser les données de "$filename" : $e',
      );
    }
    try {
      await file.writeAsString(encoded);
    } catch (e) {
      throw RepositoryException(
        'Impossible d\'écrire dans le fichier "$filename" : $e',
      );
    }
  }

  /// Réinitialise le fichier local depuis l'asset d'origine.
  /// Utilisé automatiquement quand le fichier est détecté comme corrompu.
  Future<void> _resetFile() async {
    try {
      final file = await getLocalfile();
      final initialData = await rootBundle.loadString(assetPath);
      await file.writeAsString(initialData);
    } catch (_) {
      // Si même la réinitialisation échoue, on abandonne silencieusement.
      // Le prochain accès retournera une liste vide.
    }
  }
}

// ── Exception métier ──────────────────────────────────────────────────────────

/// Exception levée par [Repository] pour tout problème d'accès ou de
/// format de fichier. Permet aux controllers de la distinguer des autres
/// exceptions et d'afficher un message clair à l'utilisateur.
class RepositoryException implements Exception {
  final String message;

  const RepositoryException(this.message);

  @override
  String toString() => 'RepositoryException: $message';
}
