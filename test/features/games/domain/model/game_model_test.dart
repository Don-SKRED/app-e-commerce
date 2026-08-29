import 'package:flutter_test/flutter_test.dart';
import 'package:app_e_commerce/features/games/domain/model/game_model.dart';

void main() {
  group('Game Model Tests', () {
    final gameJson = {
      'id': 5,
      'name': 'Spider-Man: Miles Morales',
      'description': 'Jeu d\'action aventures sur PS5',
      'price': 59.99,
      'image': 'miles_morales.jpg',
      'stock': 20,
      'platform': ['ps5'],
      'type': 'Action',
      'editor': 'Sony Interactive Entertainment',
    };

    test('Game.fromJson should construct model correctly', () {
      final game = Game.fromJson(gameJson);

      expect(game.id, 5);
      expect(game.name, 'Spider-Man: Miles Morales');
      expect(game.price, 59.99);
      expect(game.platform, equals(['ps5']));
      expect(game.type, 'Action');
      expect(game.editor, 'Sony Interactive Entertainment');
    });

    test('Game.toJson should serialize model correctly', () {
      final game = Game.fromJson(gameJson);
      final jsonOutput = game.toJson();

      expect(jsonOutput['id'], 5);
      expect(jsonOutput['name'], 'Spider-Man: Miles Morales');
      expect(jsonOutput['platform'], equals(['ps5']));
      expect(jsonOutput['type'], 'Action');
    });
  });
}
