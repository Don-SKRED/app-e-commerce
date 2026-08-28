import 'package:app_e_commerce/features/favorites/application/favorites_service.dart';
import 'package:app_e_commerce/features/favorites/data/repositories/favorites_repository.dart';
import 'package:app_e_commerce/features/favorites/presentation/screens/favorites_screen.dart';
import 'package:app_e_commerce/features/products/domain/product_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

class FakeFavoritesRepository extends FavoritesRepository {
  @override
  Future<List<Product>> loadFavorites() async => [];

  @override
  Future<void> saveFavorites(List<Product> favorites) async {}
}

void main() {
  group('FavoritesScreen Widget Tests', () {
    testWidgets('Displays empty state message when favorites list is empty', (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            favoritesRepositoryProvider.overrideWithValue(FakeFavoritesRepository()),
          ],
          child: const MaterialApp(
            home: FavoritesScreen(),
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.text('Mes Favoris'), findsOneWidget);
      expect(find.text('Aucun favori enregistré :('), findsOneWidget);
    });
  });
}
