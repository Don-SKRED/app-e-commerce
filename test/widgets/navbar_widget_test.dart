import 'package:app_e_commerce/features/favorites/application/favorites_service.dart';
import 'package:app_e_commerce/features/favorites/data/repositories/favorites_repository.dart';
import 'package:app_e_commerce/features/products/domain/product_model.dart';
import 'package:app_e_commerce/shared/widgets/navbar_widget.dart';
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
  group('NavigationBarWidget Tests', () {
    testWidgets('Renders all 5 navigation tabs', (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            favoritesRepositoryProvider.overrideWithValue(FakeFavoritesRepository()),
          ],
          child: const MaterialApp(
            home: NavigationBarWidget(),
          ),
        ),
      );

      expect(find.text('Accueil'), findsOneWidget);
      expect(find.text('Favoris'), findsOneWidget);
      expect(find.text('Panier'), findsOneWidget);
      expect(find.text('Commandes'), findsOneWidget);
      expect(find.text('Profil'), findsOneWidget);
    });
  });
}
