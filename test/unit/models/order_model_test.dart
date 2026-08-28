import 'package:flutter_test/flutter_test.dart';
import 'package:app_e_commerce/features/order/domain/models/order_model.dart';
import 'package:app_e_commerce/features/order/domain/models/order_item_model.dart';
import 'package:app_e_commerce/features/games/domain/model/game_model.dart';

void main() {
  group('Order & OrderItem Model Tests', () {
    final sampleGame = Game(
      1,
      name: 'FIFA 24',
      description: 'Jeu de foot',
      price: 69.99,
      image: 'fifa.png',
      stock: 20,
      platform: ['PS5', 'Xbox'],
      type: 'Sport',
      editor: 'EA',
    );

    test('OrderItem.toJson & fromJson should work correctly', () {
      final orderItem = OrderItem(
        id: 10,
        quantity: 2,
        unitPrice: 69.99,
        product: sampleGame,
      );

      final json = orderItem.toJson();
      expect(json['id'], 10);
      expect(json['quantity'], 2);
      expect(json['unitPrice'], 69.99);
      expect(json['product'], isNotNull);

      final reconstructed = OrderItem.fromJson(json);
      expect(reconstructed.id, 10);
      expect(reconstructed.quantity, 2);
      expect(reconstructed.unitPrice, 69.99);
      expect(reconstructed.product.name, 'FIFA 24');
    });

    test('Order.toJson & fromJson should handle orderItems list correctly', () {
      final orderItem = OrderItem(
        id: 10,
        quantity: 2,
        unitPrice: 69.99,
        product: sampleGame,
      );

      final date = DateTime(2024, 5, 10, 14, 30);
      final order = Order(
        id: 100,
        date: date,
        total: 139.98,
        orderItems: [orderItem],
      );

      final json = order.toJson();
      expect(json['id'], 100);
      expect(json['date'], date.toIso8601String());
      expect(json['total'], 139.98);
      expect(json['orderItems'], isList);

      final reconstructed = Order.fromJson(json);
      expect(reconstructed.id, 100);
      expect(reconstructed.date, date);
      expect(reconstructed.total, 139.98);
      expect(reconstructed.orderItems.length, 1);
      expect(reconstructed.orderItems.first.product.name, 'FIFA 24');
    });
  });
}
