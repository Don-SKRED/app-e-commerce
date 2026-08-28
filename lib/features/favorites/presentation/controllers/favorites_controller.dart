import 'package:app_e_commerce/features/favorites/application/favorites_service.dart';
import 'package:app_e_commerce/features/products/domain/product_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FavoritesController extends Notifier<List<Product>> {
  @override
  List<Product> build() {
    _loadFromLocal();
    return [];
  }

  Future<void> _loadFromLocal() async {
    try {
      final service = ref.read(favoritesServiceProvider);
      final savedFavorites = await service.loadFavorites();
      if (savedFavorites.isNotEmpty) {
        state = savedFavorites;
      }
    } catch (e, stack) {
      debugPrint("Erreur lors du chargement des favoris : $e\n$stack");
    }
  }

  Future<void> toggleFavorite(Product product) async {
    final previousState = state;
    final exists = state.any((item) => item.id == product.id);
    if (exists) {
      state = state.where((item) => item.id != product.id).toList();
    } else {
      state = [...state, product];
    }

    try {
      await _saveToLocal();
    } catch (e, stack) {
      debugPrint("Échec de la sauvegarde des favoris, rollback : $e\n$stack");
      // Restaure l'état en mémoire si la persistance sur disque a échoué
      state = previousState;
    }
  }

  bool isFavorite(Product product) {
    return state.any((item) => item.id == product.id);
  }

  Future<void> removeFavorite(Product product) async {
    final previousState = state;
    state = state.where((item) => item.id != product.id).toList();

    try {
      await _saveToLocal();
    } catch (e, stack) {
      debugPrint("Échec de la suppression du favori, rollback : $e\n$stack");
      state = previousState;
    }
  }

  Future<void> clearFavorites() async {
    final previousState = state;
    state = [];

    try {
      await _saveToLocal();
    } catch (e, stack) {
      debugPrint("Échec de la réinitialisation des favoris, rollback : $e\n$stack");
      state = previousState;
    }
  }

  Future<void> _saveToLocal() async {
    final service = ref.read(favoritesServiceProvider);
    await service.saveFavorites(state);
  }
}

final favoritesControllerProvider =
    NotifierProvider<FavoritesController, List<Product>>(
  FavoritesController.new,
);
