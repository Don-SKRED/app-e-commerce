import 'package:flutter_test/flutter_test.dart';
import 'package:app_e_commerce/features/games/domain/model/game_model.dart';
import 'package:app_e_commerce/features/shopping_cart/application/shopping_cart_service.dart';
import 'package:app_e_commerce/features/shopping_cart/domain/shopping_cart_model.dart';

void main() {
  group('ShoppingCartService Tests', () {
    final game1 = Game(
      1,
      name: 'Game 1',
      description: 'Desc 1',
      price: 20.0,
      image: 'img1.png',
      stock: 5,
      platform: ['PS5'],
      type: 'Action',
      editor: 'Studio',
    );

    final game2 = Game(
      2,
      name: 'Game 2',
      description: 'Desc 2',
      price: 30.5,
      image: 'img2.png',
      stock: 10,
      platform: ['PC'],
      type: 'RPG',
      editor: 'Studio',
    );

    test('calculateTotal on empty list should return 0.0', () {
      expect(calculateTotal([]), equals(0.0));
    });

    test('calculateTotal should correctly sum price * quantity for all items', () {
      final items = [
        ShoppingCartModel(userId: 1, product: game1, quantity: 2), // 40.0
        ShoppingCartModel(userId: 1, product: game2, quantity: 3), // 91.5
      ];

      expect(calculateTotal(items), equals(131.5));
    });
  });
}
