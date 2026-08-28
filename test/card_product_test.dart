import 'package:app_e_commerce/features/games/domain/model/game_model.dart';
import 'package:app_e_commerce/features/products/presentation/widgets/card_product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('CardProduct affiche le nom, le prix et le bouton favori', (tester) async {
    final game = Game(
      1,
      name: 'Cyberpunk 2077',
      description: 'RPG futuriste',
      price: 29.99,
      image: '',
      stock: 4,
      platform: ['PC'],
      type: 'RPG',
      editor: 'CD Projekt',
    );

    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          home: Scaffold(
            body: CardProduct(
              product: game,
              onTap: () {},
            ),
          ),
        ),
      ),
    );

    expect(find.text('Cyberpunk 2077'), findsOneWidget);
    expect(find.text('29.99 €'), findsOneWidget);
    expect(find.byIcon(Icons.favorite_border), findsOneWidget);
  });
}
