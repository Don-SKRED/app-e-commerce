import 'package:app_e_commerce/features/favorites/data/repositories/favorites_repository.dart';
import 'package:app_e_commerce/features/favorites/presentation/controllers/favorites_controller.dart';
import 'package:app_e_commerce/features/games/domain/model/game_model.dart';
import 'package:app_e_commerce/features/products/domain/product_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

class FakeFavoritesRepository extends FavoritesRepository {
  List<Product> storage = [];

  @override
  Future<List<Product>> loadFavorites() async {
    return storage;
  }

  @override
  Future<void> saveFavorites(List<Product> favorites) async {
    storage = List.from(favorites);
  }
}

void main() {
  group('FavoritesController Unit Tests', () {
    late ProviderContainer container;
    late Game testGame;
    late FakeFavoritesRepository fakeRepo;

    setUp(() async {
      fakeRepo = FakeFavoritesRepository();
      container = ProviderContainer(
        overrides: [
          favoritesRepositoryProvider.overrideWithValue(fakeRepo),
        ],
      );
      testGame = Game(
        10,
        name: 'Super Mario Odyssey',
        description: 'Jeu de plateforme',
        price: 49.99,
        image: 'https://example.com/mario.jpg',
        stock: 12,
        platform: ['Switch'],
        type: 'Plateforme',
        editor: 'Nintendo',
      );
      // Attend le chargement asynchrone initial de _loadFromLocal()
      await Future.delayed(Duration.zero);
    });

    tearDown(() {
      container.dispose();
    });

    test('L état initial des favoris est une liste vide', () {
      final state = container.read(favoritesControllerProvider);
      expect(state, isEmpty);
    });

    test('toggleFavorite ajoute un produit aux favoris', () async {
      final controller = container.read(favoritesControllerProvider.notifier);
      await controller.toggleFavorite(testGame);

      final state = container.read(favoritesControllerProvider);
      expect(state.length, equals(1));
      expect(state.first.id, equals(10));
      expect(controller.isFavorite(testGame), isTrue);
    });

    test('toggleFavorite retire un produit déjà présent dans les favoris', () async {
      final controller = container.read(favoritesControllerProvider.notifier);
      await controller.toggleFavorite(testGame);
      expect(container.read(favoritesControllerProvider).length, equals(1));

      await controller.toggleFavorite(testGame);
      expect(container.read(favoritesControllerProvider), isEmpty);
      expect(controller.isFavorite(testGame), isFalse);
    });

    test('clearFavorites réinitialise tous les favoris', () async {
      final controller = container.read(favoritesControllerProvider.notifier);
      await controller.toggleFavorite(testGame);
      expect(container.read(favoritesControllerProvider).length, equals(1));

      await controller.clearFavorites();
      expect(container.read(favoritesControllerProvider), isEmpty);
    });
  });
}
