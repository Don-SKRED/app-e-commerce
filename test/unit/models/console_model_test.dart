import 'package:flutter_test/flutter_test.dart';
import 'package:app_e_commerce/features/Console/domain/models/console_model.dart';

void main() {
  group('Console Model Tests', () {
    final sampleJson = {
      'id': 1,
      'name': 'PlayStation 5',
      'description': 'Console next-gen de Sony',
      'price': 499.99,
      'image': 'ps5.png',
      'stock': 10,
      'marque': 'Sony',
      'storageCapacity': 825.0,
      'joystick': true,
    };

    test('Console.fromJson should construct model correctly', () {
      final console = Console.fromJson(sampleJson);

      expect(console.id, 1);
      expect(console.name, 'PlayStation 5');
      expect(console.description, 'Console next-gen de Sony');
      expect(console.price, 499.99);
      expect(console.image, 'ps5.png');
      expect(console.stock, 10);
      expect(console.marque, 'Sony');
      expect(console.storageCapacity, 825.0);
      expect(console.joystick, true);
    });

    test('Console.toJson should serialize model correctly', () {
      final console = Console(
        1,
        name: 'PlayStation 5',
        description: 'Console next-gen de Sony',
        price: 499.99,
        image: 'ps5.png',
        stock: 10,
        marque: 'Sony',
        storageCapacity: 825.0,
        joystick: true,
      );

      final json = console.toJson();

      expect(json['id'], 1);
      expect(json['name'], 'PlayStation 5');
      expect(json['price'], 499.99);
      expect(json['marque'], 'Sony');
      expect(json['storageCapacity'], 825.0);
      expect(json['joystick'], true);
    });
  });
}
