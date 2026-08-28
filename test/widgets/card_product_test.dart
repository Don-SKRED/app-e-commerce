import 'package:app_e_commerce/features/games/domain/model/game_model.dart';
import 'package:app_e_commerce/features/products/presentation/widgets/card_product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('CardProduct affiche le nom, le prix et le bouton favori',
      (WidgetTester tester) async {
    final game = Game(
      1,
      name: 'Cyberpunk 2077',
      description: 'RPG futuriste',
      price: 29.99,
      image: 'https://example.com/cp2077.jpg',
      stock: 7,
      platform: ['PC'],
      type: 'RPG',
      editor: 'CD Projekt Red',
    );

    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          home: Scaffold(
            body: SizedBox(
              width: 200,
              height: 300,
              child: CardProduct(
                product: game,
                onTap: () {},
              ),
            ),
          ),
        ),
      ),
    );

    expect(find.text('Cyberpunk 2077'), findsOneWidget);
    expect(find.text('29.99 €'), findsOneWidget);
    expect(find.byType(IconButton), findsOneWidget);
  });
}
