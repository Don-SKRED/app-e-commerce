import 'package:flutter_test/flutter_test.dart';
import 'package:app_e_commerce/features/games/domain/model/game_model.dart';
import 'package:app_e_commerce/features/shopping_cart/domain/shopping_cart_model.dart';

void main() {
  group('ShoppingCartModel Tests', () {
    final game = Game(
      1,
      name: 'Mario Odyssey',
      description: 'Plateforme',
      price: 49.99,
      image: 'mario.png',
      stock: 5,
      platform: ['Switch'],
      type: 'Aventure',
      editor: 'Nintendo',
    );

    test('ShoppingCartModel constructor and copyWith should work', () {
      final cartItem = ShoppingCartModel(
        userId: 1,
        product: game,
        quantity: 2,
      );

      expect(cartItem.userId, equals(1));
      expect(cartItem.product.name, equals('Mario Odyssey'));
      expect(cartItem.quantity, equals(2));

      final updated = cartItem.copyWith(quantity: 4);
      expect(updated.quantity, equals(4));
      expect(updated.userId, equals(1));
      expect(updated.product.id, equals(1));
    });
  });
}
