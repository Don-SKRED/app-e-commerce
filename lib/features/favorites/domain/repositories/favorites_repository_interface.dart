import 'package:app_e_commerce/features/products/domain/product_model.dart';

/// Interface abstraite pour la persistance des favoris (Couche Domaine).
/// Permet d'isoler la logique applicative du stockage physique (JSON, SQLite, API).
abstract class IFavoritesRepository {
  Future<List<Product>> loadFavorites();
  Future<void> saveFavorites(List<Product> favorites);
}
