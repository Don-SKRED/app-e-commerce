import 'package:app_e_commerce/features/products/domain/product_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FavoritesController extends Notifier<List<Product>> {
  @override
  List<Product> build() {
    return [];
  }

  void toggleFavorite(Product product) {
    final exists = state.any((item) => item.id == product.id);
    if (exists) {
      state = state.where((item) => item.id != product.id).toList();
    } else {
      state = [...state, product];
    }
  }

  bool isFavorite(Product product) {
    return state.any((item) => item.id == product.id);
  }

  void removeFavorite(Product product) {
    state = state.where((item) => item.id != product.id).toList();
  }

  void clearFavorites() {
    state = [];
  }
}

final favoritesControllerProvider =
    NotifierProvider<FavoritesController, List<Product>>(
  FavoritesController.new,
);
