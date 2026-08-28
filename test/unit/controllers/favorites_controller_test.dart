import 'package:app_e_commerce/exceptions/storage_exception.dart';
import 'package:app_e_commerce/features/favorites/application/favorites_service.dart';
import 'package:app_e_commerce/features/favorites/data/repositories/favorites_repository.dart';
import 'package:app_e_commerce/features/favorites/presentation/controllers/favorites_controller.dart';
import 'package:app_e_commerce/features/games/domain/model/game_model.dart';
import 'package:app_e_commerce/features/products/domain/product_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

class FakeFavoritesRepository extends FavoritesRepository {
  List<Product> storage = [];
  bool shouldThrowOnSave = false;

  @override
  Future<List<Product>> loadFavorites() async {
    return storage;
  }

  @override
  Future<void> saveFavorites(List<Product> favorites) async {
    if (shouldThrowOnSave) {
      throw const StorageException("Erreur d'écriture simulée");
    }
    storage = List.from(favorites);
  }
}

void main() {
  group('FavoritesController Tests', () {
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
        image: 'mario.jpg',
        stock: 12,
        platform: ['Switch'],
        type: 'Plateforme',
        editor: 'Nintendo',
      );
      await Future.delayed(Duration.zero);
    });

    tearDown(() {
      container.dispose();
    });

    test('Initial state of favorites is empty list', () {
      final state = container.read(favoritesControllerProvider);
      expect(state, isEmpty);
    });

    test('toggleFavorite adds product when not present', () async {
      final controller = container.read(favoritesControllerProvider.notifier);
      await controller.toggleFavorite(testGame);

      final state = container.read(favoritesControllerProvider);
      expect(state.length, equals(1));
      expect(state.first.id, equals(10));
      expect(controller.isFavorite(testGame), isTrue);
    });

    test('toggleFavorite removes product when already present', () async {
      final controller = container.read(favoritesControllerProvider.notifier);
      await controller.toggleFavorite(testGame);
      expect(container.read(favoritesControllerProvider).length, equals(1));

      await controller.toggleFavorite(testGame);
      expect(container.read(favoritesControllerProvider), isEmpty);
      expect(controller.isFavorite(testGame), isFalse);
    });

    test('clearFavorites resets all favorites', () async {
      final controller = container.read(favoritesControllerProvider.notifier);
      await controller.toggleFavorite(testGame);
      expect(container.read(favoritesControllerProvider).length, equals(1));

      await controller.clearFavorites();
      expect(container.read(favoritesControllerProvider), isEmpty);
    });

    test('toggleFavorite rolls back state when persistence fails', () async {
      final controller = container.read(favoritesControllerProvider.notifier);
      fakeRepo.shouldThrowOnSave = true;

      await controller.toggleFavorite(testGame);

      final state = container.read(favoritesControllerProvider);
      expect(state, isEmpty);
      expect(controller.isFavorite(testGame), isFalse);
    });
  });
}
