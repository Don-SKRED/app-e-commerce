import 'package:flutter_test/flutter_test.dart';
import 'package:app_e_commerce/features/order/domain/models/order_model.dart';
import 'package:app_e_commerce/features/order/domain/models/order_item_model.dart';
import 'package:app_e_commerce/features/games/domain/model/game_model.dart';

void main() {
  group('Order & OrderItem Model Tests', () {
    final game = Game(
      5,
      name: 'Spider-Man',
      description: 'Jeu PS5',
      price: 59.99,
      image: 'spiderman.jpg',
      stock: 10,
      platform: ['ps5'],
      type: 'Action',
      editor: 'Sony',
    );

    final orderItem = OrderItem(
      id: 1,
      quantity: 2,
      unitPrice: 59.99,
      product: game,
    );

    test('OrderItem.toJson & fromJson should work correctly', () {
      final json = orderItem.toJson();
      final deserialized = OrderItem.fromJson(json);

      expect(deserialized.id, 1);
      expect(deserialized.quantity, 2);
      expect(deserialized.unitPrice, 59.99);
      expect(deserialized.product.name, 'Spider-Man');
    });

    test('Order.toJson & fromJson should handle orderItems list correctly', () {
      final order = Order(
        id: 101,
        date: DateTime.parse('2026-08-28T10:00:00.000Z'),
        total: 119.98,
        orderItems: [orderItem],
      );

      final json = order.toJson();
      expect(json['orderItems'], isA<List>());
      expect((json['orderItems'] as List).length, 1);

      final deserializedOrder = Order.fromJson(json);

      expect(deserializedOrder.id, 101);
      expect(deserializedOrder.total, 119.98);
      expect(deserializedOrder.orderItems.length, 1);
      expect(deserializedOrder.orderItems.first.product.name, 'Spider-Man');
    });
  });
}
