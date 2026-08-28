import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:app_e_commerce/features/shopping_cart/presentation/controllers/shopping_cart_controller.dart';
import 'package:app_e_commerce/features/shopping_cart/domain/shopping_cart_model.dart';
import 'package:app_e_commerce/features/products/domain/product_model.dart';

class TestProduct extends Product {
  TestProduct(
    super.id, {
    required super.name,
    required super.description,
    required super.price,
    required super.image,
    required super.stock,
  });
}

void main() {
  group('ShoppingCartController Tests', () {
    late TestProduct product1;
    late TestProduct product2;

    setUp(() {
      product1 = TestProduct(
        1,
        name: 'PS5',
        description: 'Console',
        price: 499.99,
        image: 'ps5.png',
        stock: 10,
      );

      product2 = TestProduct(
        2,
        name: 'Spider-Man',
        description: 'Jeu',
        price: 59.99,
        image: 'spiderman.png',
        stock: 5,
      );
    });

    test('Initial state of ShoppingCartController should be empty list', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      final cartState = container.read(shoppingCartControllerProvider);
      expect(cartState, isEmpty);
    });

    test('add() should add a new item to cart when product is not present', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      final controller = container.read(shoppingCartControllerProvider.notifier);
      final item = ShoppingCartModel(userId: 1, product: product1, quantity: 1);

      controller.add(item);

      final state = container.read(shoppingCartControllerProvider);
      expect(state.length, 1);
      expect(state.first.product.id, 1);
      expect(state.first.quantity, 1);
    });

    test('add() should increment quantity when product already exists in cart', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      final controller = container.read(shoppingCartControllerProvider.notifier);
      final item1 = ShoppingCartModel(userId: 1, product: product1, quantity: 2);
      final item2 = ShoppingCartModel(userId: 1, product: product1, quantity: 3);

      controller.add(item1);
      controller.add(item2);

      final state = container.read(shoppingCartControllerProvider);
      expect(state.length, 1);
      expect(state.first.quantity, 5);
    });

    test('remove() should remove item with matching product id', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      final controller = container.read(shoppingCartControllerProvider.notifier);
      final item1 = ShoppingCartModel(userId: 1, product: product1, quantity: 1);
      final item2 = ShoppingCartModel(userId: 1, product: product2, quantity: 1);

      controller.add(item1);
      controller.add(item2);
      expect(container.read(shoppingCartControllerProvider).length, 2);

      controller.remove(item1);

      final state = container.read(shoppingCartControllerProvider);
      expect(state.length, 1);
      expect(state.first.product.id, 2);
    });

    test('clear() should empty the cart', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      final controller = container.read(shoppingCartControllerProvider.notifier);
      final item1 = ShoppingCartModel(userId: 1, product: product1, quantity: 1);

      controller.add(item1);
      expect(container.read(shoppingCartControllerProvider).length, 1);

      controller.clear();

      final state = container.read(shoppingCartControllerProvider);
      expect(state, isEmpty);
    });
  });
}
