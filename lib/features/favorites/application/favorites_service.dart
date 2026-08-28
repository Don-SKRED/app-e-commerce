import 'package:app_e_commerce/features/favorites/data/repositories/favorites_repository.dart';
import 'package:app_e_commerce/features/favorites/domain/repositories/favorites_repository_interface.dart';
import 'package:app_e_commerce/features/products/domain/product_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Provider de l'interface [IFavoritesRepository] dans la couche application.
final favoritesRepositoryProvider = Provider<IFavoritesRepository>((ref) {
  return FavoritesRepository();
});

/// Service applicatif pour la gestion des favoris.
/// Dépend exclusivement du contrat abstrait [IFavoritesRepository].
class FavoritesService {
  final IFavoritesRepository _repository;

  FavoritesService(this._repository);

  /// Charge la liste des produits favoris.
  Future<List<Product>> loadFavorites() => _repository.loadFavorites();

  /// Persiste la liste complète des favoris.
  Future<void> saveFavorites(List<Product> favorites) =>
      _repository.saveFavorites(favorites);
}

/// Provider du service applicatif des favoris.
final favoritesServiceProvider = Provider<FavoritesService>((ref) {
  return FavoritesService(ref.read(favoritesRepositoryProvider));
});
