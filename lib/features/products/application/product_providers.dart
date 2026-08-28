import 'package:app_e_commerce/features/Console/application/console_service.dart';
import 'package:app_e_commerce/features/Console/domain/models/console_model.dart';
import 'package:app_e_commerce/features/games/application/game_service.dart';
import 'package:app_e_commerce/features/games/domain/model/game_model.dart';
import 'package:app_e_commerce/features/products/application/services/filter_services.dart';
import 'package:app_e_commerce/features/products/application/services/sort_services.dart';
import 'package:app_e_commerce/features/products/domain/product_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Provider réactif de la requête de recherche de produits.
class ProductSearchController extends Notifier<String> {
  @override
  String build() => '';

  void updateQuery(String query) {
    state = query;
  }

  void clear() {
    state = '';
  }
}

final productSearchProvider =
    NotifierProvider<ProductSearchController, String>(
  ProductSearchController.new,
);

/// Provider réactif du critère de tri sélectionné.
class ProductSortController extends Notifier<String?> {
  @override
  String? build() => null;

  void updateSort(String? sortOption) {
    state = sortOption;
  }

  void clear() {
    state = null;
  }
}

final productSortProvider =
    NotifierProvider<ProductSortController, String?>(
  ProductSortController.new,
);

/// Helper métier pour appliquer le tri sur une liste de produits.
void applyProductSort(List<Product> products, String? sortOption) {
  if (sortOption == null) return;
  switch (sortOption) {
    case "Tri par nom(croissante)":
      sortByName(products);
      break;
    case "Tri par nom(décroissante)":
      sortByDesc(products);
      break;
    case "Tri par prix(croissante)":
      sortByPriceAsc(products);
      break;
    case "Tri par prix(décroissante)":
      sortByPriceDesc(products);
      break;
  }
}

/// Provider combiné pour les jeux filtrés et triés réactivement.
final filteredSortedGamesProvider = Provider<AsyncValue<List<Game>>>((ref) {
  final gamesAsync = ref.watch(gamesListProvider);
  final search = ref.watch(productSearchProvider);
  final sortOption = ref.watch(productSortProvider);

  return gamesAsync.whenData((games) {
    var filtered = filterBySearch(List<Product>.from(games), search).cast<Game>();
    applyProductSort(filtered, sortOption);
    return filtered;
  });
});

/// Provider combiné pour les consoles filtrées et triées réactivement.
final filteredSortedConsolesProvider = Provider<AsyncValue<List<Console>>>((ref) {
  final consolesAsync = ref.watch(consolesListProvider);
  final search = ref.watch(productSearchProvider);
  final sortOption = ref.watch(productSortProvider);

  return consolesAsync.whenData((consoles) {
    var filtered = filterBySearch(List<Product>.from(consoles), search).cast<Console>();
    applyProductSort(filtered, sortOption);
    return filtered;
  });
});
