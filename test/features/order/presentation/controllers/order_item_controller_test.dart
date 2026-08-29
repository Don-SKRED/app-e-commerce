import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:app_e_commerce/features/order/presentation/controllers/order_item_controller.dart';
import 'package:app_e_commerce/features/order/domain/models/order_item_model.dart';
import 'package:app_e_commerce/features/games/domain/model/game_model.dart';
import 'package:app_e_commerce/features/Console/domain/models/console_model.dart';

void main() {
  // ── Données de test partagées ──────────────────────────────────────────────
  final game = Game(
    1,
    name: 'Spider-Man',
    description: 'Jeu PS5',
    price: 59.99,
    image: 'spiderman.jpg',
    stock: 10,
    platform: ['ps5'],
    type: 'Action',
    editor: 'Sony',
  );

  final console = Console(
    2,
    name: 'PlayStation 5',
    description: 'Console next-gen',
    price: 499.99,
    image: 'ps5.jpg',
    stock: 5,
    marque: 'Sony',
    storageCapacity: 825.0,
    joystick: true,
  );

  final itemGame = OrderItem(id: 10, quantity: 1, unitPrice: 59.99, product: game);
  final itemConsole = OrderItem(id: 11, quantity: 2, unitPrice: 499.99, product: console);

  // ── Tests ──────────────────────────────────────────────────────────────────
  group('OrderItemController — NotifierProvider Tests', () {
    test('État initial : liste vide', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      final state = container.read(orderItemControllerProvider);
      expect(state, isEmpty);
    });

    test('addOrderItem() ajoute un OrderItem au state', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      container.read(orderItemControllerProvider.notifier).addOrderItem(itemGame);

      final state = container.read(orderItemControllerProvider);
      expect(state.length, 1);
      expect(state.first.id, 10);
      expect(state.first.product.name, 'Spider-Man');
    });

    test('addOrderItem() plusieurs fois → tous les items sont présents', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      final notifier = container.read(orderItemControllerProvider.notifier);
      notifier.addOrderItem(itemGame);
      notifier.addOrderItem(itemConsole);

      final state = container.read(orderItemControllerProvider);
      expect(state.length, 2);
      expect(state[0].id, 10);
      expect(state[1].id, 11);
    });

    test('addOrderItem() conserve l\'ordre d\'insertion', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      final notifier = container.read(orderItemControllerProvider.notifier);
      notifier.addOrderItem(itemConsole);
      notifier.addOrderItem(itemGame);

      final state = container.read(orderItemControllerProvider);
      expect(state.first.id, 11); // console ajoutée en premier
      expect(state.last.id, 10);  // jeu ajouté en second
    });

    test('clear() vide la liste même si plusieurs items ont été ajoutés', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      final notifier = container.read(orderItemControllerProvider.notifier);
      notifier.addOrderItem(itemGame);
      notifier.addOrderItem(itemConsole);
      expect(container.read(orderItemControllerProvider).length, 2);

      notifier.clear();

      expect(container.read(orderItemControllerProvider), isEmpty);
    });

    test('clear() sur liste vide → reste vide sans erreur', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      // aucun item ajouté
      container.read(orderItemControllerProvider.notifier).clear();
      expect(container.read(orderItemControllerProvider), isEmpty);
    });

    test('addOrderItem() après clear() → item présent dans la nouvelle liste', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      final notifier = container.read(orderItemControllerProvider.notifier);
      notifier.addOrderItem(itemGame);
      notifier.clear();
      notifier.addOrderItem(itemConsole);

      final state = container.read(orderItemControllerProvider);
      expect(state.length, 1);
      expect(state.first.id, 11);
    });

    test('unitPrice et quantity sont correctement conservés dans le state', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      container.read(orderItemControllerProvider.notifier).addOrderItem(itemConsole);

      final item = container.read(orderItemControllerProvider).first;
      expect(item.quantity, 2);
      expect(item.unitPrice, 499.99);
    });
  });
}
