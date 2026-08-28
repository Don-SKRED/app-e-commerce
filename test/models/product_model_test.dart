import 'package:app_e_commerce/features/Console/domain/models/console_model.dart';
import 'package:app_e_commerce/features/games/domain/model/game_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Product Models Unit Tests', () {
    test('Game.fromJson et toJson instancient et sérialisent correctement', () {
      final json = {
        'id': '101',
        'name': 'God of War Ragnarok',
        'description': 'Aventure nordique',
        'price': 69.99,
        'image': 'https://example.com/gow.jpg',
        'stock': 15,
        'platform': ['PS5', 'PS4'],
        'type': 'Action',
        'editor': 'PlayStation Studios',
      };

      final game = Game.fromJson(json);
      expect(game.id, equals(101));
      expect(game.name, equals('God of War Ragnarok'));
      expect(game.price, equals(69.99));
      expect(game.platform, contains('PS5'));

      final serialized = game.toJson();
      expect(serialized['id'], equals(101));
      expect(serialized['name'], equals('God of War Ragnarok'));
    });

    test('Console.fromJson et toJson instancient et sérialisent correctement', () {
      final json = {
        'id': '201',
        'name': 'PlayStation 5 Pro',
        'description': 'Console Next-Gen',
        'price': 799.99,
        'image': 'https://example.com/ps5pro.jpg',
        'stock': 3,
        'marque': 'Sony',
        'storageCapacity': 2000,
        'joystick': true,
      };

      final console = Console.fromJson(json);
      expect(console.id, equals(201));
      expect(console.marque, equals('Sony'));
      expect(console.storageCapacity, equals(2000.0));
      expect(console.joystick, isTrue);

      final serialized = console.toJson();
      expect(serialized['id'], equals(201));
      expect(serialized['marque'], equals('Sony'));
    });
  });
}
