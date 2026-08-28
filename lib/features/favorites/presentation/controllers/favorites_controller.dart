import 'package:app_e_commerce/features/favorites/data/repositories/favorites_repository.dart';
import 'package:app_e_commerce/features/products/domain/product_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FavoritesController extends Notifier<List<Product>> {
  @override
  List<Product> build() {
    _loadFromLocal();
    return [];
  }

  Future<void> _loadFromLocal() async {
    final repo = ref.read(favoritesRepositoryProvider);
    final savedFavorites = await repo.loadFavorites();
    state = savedFavorites;
  }

  Future<void> toggleFavorite(Product product) async {
    final exists = state.any((item) => item.id == product.id);
    if (exists) {
      state = state.where((item) => item.id != product.id).toList();
    } else {
      state = [...state, product];
    }
    await _saveToLocal();
  }

  bool isFavorite(Product product) {
    return state.any((item) => item.id == product.id);
  }

  Future<void> removeFavorite(Product product) async {
    state = state.where((item) => item.id != product.id).toList();
    await _saveToLocal();
  }

  Future<void> clearFavorites() async {
    state = [];
    await _saveToLocal();
  }

  Future<void> _saveToLocal() async {
    final repo = ref.read(favoritesRepositoryProvider);
    await repo.saveFavorites(state);
  }
}

final favoritesControllerProvider =
    NotifierProvider<FavoritesController, List<Product>>(
  FavoritesController.new,
);
