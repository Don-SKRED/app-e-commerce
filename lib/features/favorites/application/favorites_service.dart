import 'package:app_e_commerce/features/favorites/data/repositories/favorites_repository.dart';
import 'package:app_e_commerce/features/products/domain/product_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Provider de la couche [application] pour [FavoritesRepository].
/// Déplacé depuis la couche [data] pour respecter la séparation des couches :
/// les providers Riverpod appartiennent à la couche application, pas à la couche data.
final favoritesRepositoryProvider = Provider<FavoritesRepository>((ref) {
  return FavoritesRepository();
});

/// Service applicatif pour la gestion des favoris.
/// Encapsule la logique de persistance locale en exposant
/// une API claire à la couche de présentation.
class FavoritesService {
  final FavoritesRepository _repository;

  FavoritesService(this._repository);

  /// Charge la liste des produits favoris depuis le fichier local.
  Future<List<Product>> loadFavorites() => _repository.loadFavorites();

  /// Persiste la liste complète des favoris dans le fichier local.
  Future<void> saveFavorites(List<Product> favorites) =>
      _repository.saveFavorites(favorites);
}

/// Provider du service applicatif des favoris.
/// La couche [presentation] (FavoritesController) doit utiliser ce provider.
final favoritesServiceProvider = Provider<FavoritesService>((ref) {
  return FavoritesService(ref.read(favoritesRepositoryProvider));
});
