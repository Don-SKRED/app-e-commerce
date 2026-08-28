import 'package:app_e_commerce/features/Console/data/repositories/console_data.dart';
import 'package:app_e_commerce/features/Console/domain/models/console_model.dart';
import 'package:app_e_commerce/features/games/data/repositories/game_data.dart';
import 'package:app_e_commerce/features/games/domain/model/game_model.dart';
import 'package:app_e_commerce/features/products/application/services/filter_services.dart';
import 'package:app_e_commerce/features/products/application/services/sort_services.dart';
import 'package:app_e_commerce/features/products/domain/product_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// 1. Providers de données brutes (FutureProvider)
final gamesProvider = FutureProvider<List<Game>>((ref) async {
  final repository = ref.watch(gameDataRepositoryProvider);
  return await repository.readFile();
});

final consolesProvider = FutureProvider<List<Console>>((ref) async {
  final repository = ref.watch(consoleDataRepositoryProvider);
  return await repository.readFile();
});

// 2. State Controllers pour le filtrage et le tri (Notifier)
class ProductSearchController extends Notifier<String> {
  @override
  String build() => "";

  void setSearchQuery(String query) {
    state = query;
  }

  void clearSearch() {
    state = "";
  }
}

final productSearchProvider =
    NotifierProvider<ProductSearchController, String>(
  ProductSearchController.new,
);

class ProductSortController extends Notifier<String?> {
  @override
  String? build() => null;

  void setSortOption(String? sortOption) {
    state = sortOption;
  }
}

final productSortProvider = NotifierProvider<ProductSortController, String?>(
  ProductSortController.new,
);

// 3. Helper de tri générique
void applySortOption(List<Product> products, String? sortOption) {
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

// 4. Providers combinés pour les jeux et les consoles
final filteredSortedGamesProvider = Provider<AsyncValue<List<Game>>>((ref) {
  final gamesAsync = ref.watch(gamesProvider);
  final searchQuery = ref.watch(productSearchProvider);
  final sortOption = ref.watch(productSortProvider);

  return gamesAsync.whenData((games) {
    var list = filterBySearch(List<Product>.from(games), searchQuery).cast<Game>();
    applySortOption(list, sortOption);
    return list;
  });
});

final filteredSortedConsolesProvider = Provider<AsyncValue<List<Console>>>((ref) {
  final consolesAsync = ref.watch(consolesProvider);
  final searchQuery = ref.watch(productSearchProvider);
  final sortOption = ref.watch(productSortProvider);

  return consolesAsync.whenData((consoles) {
    var list = filterBySearch(List<Product>.from(consoles), searchQuery).cast<Console>();
    applySortOption(list, sortOption);
    return list;
  });
});
