import 'package:flutter_test/flutter_test.dart';
import 'package:app_e_commerce/features/Console/domain/models/console_model.dart';

void main() {
  group('Console Model Tests', () {
    final consoleJson = {
      'id': 1,
      'name': 'PlayStation 5',
      'description': 'Console next-gen Sony',
      'price': 549.99,
      'image': 'ps5.jpg',
      'stock': 15,
      'marque': 'Sony',
      'storageCapacity': 825.0,
      'joystick': true,
    };

    test('Console.fromJson should construct model correctly', () {
      final console = Console.fromJson(consoleJson);

      expect(console.id, 1);
      expect(console.name, 'PlayStation 5');
      expect(console.description, 'Console next-gen Sony');
      expect(console.price, 549.99);
      expect(console.image, 'ps5.jpg');
      expect(console.stock, 15);
      expect(console.marque, 'Sony');
      expect(console.storageCapacity, 825.0);
      expect(console.joystick, true);
    });

    test('Console.toJson should serialize model correctly', () {
      final console = Console.fromJson(consoleJson);
      final jsonOutput = console.toJson();

      expect(jsonOutput['id'], 1);
      expect(jsonOutput['name'], 'PlayStation 5');
      expect(jsonOutput['price'], 549.99);
      expect(jsonOutput['marque'], 'Sony');
      expect(jsonOutput['storageCapacity'], 825.0);
      expect(jsonOutput['joystick'], true);
    });
  });
}
