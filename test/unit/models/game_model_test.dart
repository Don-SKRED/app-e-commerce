import 'package:flutter_test/flutter_test.dart';
import 'package:app_e_commerce/features/games/domain/model/game_model.dart';

void main() {
  group('Game Model Tests', () {
    final sampleJson = {
      'id': 1,
      'name': 'The Legend of Zelda',
      'description': 'Aventure épique en Hyrule',
      'price': 59.99,
      'image': 'zelda.png',
      'stock': 15,
      'platform': ['Switch'],
      'type': 'Aventure',
      'editor': 'Nintendo',
    };

    test('Game.fromJson should construct model correctly', () {
      final game = Game.fromJson(sampleJson);

      expect(game.id, 1);
      expect(game.name, 'The Legend of Zelda');
      expect(game.description, 'Aventure épique en Hyrule');
      expect(game.price, 59.99);
      expect(game.image, 'zelda.png');
      expect(game.stock, 15);
      expect(game.platform, ['Switch']);
      expect(game.type, 'Aventure');
      expect(game.editor, 'Nintendo');
    });

    test('Game.toJson should serialize model correctly', () {
      final game = Game(
        1,
        name: 'The Legend of Zelda',
        description: 'Aventure épique en Hyrule',
        price: 59.99,
        image: 'zelda.png',
        stock: 15,
        platform: ['Switch'],
        type: 'Aventure',
        editor: 'Nintendo',
      );

      final json = game.toJson();

      expect(json['id'], 1);
      expect(json['name'], 'The Legend of Zelda');
      expect(json['price'], 59.99);
      expect(json['platform'], ['Switch']);
      expect(json['type'], 'Aventure');
      expect(json['editor'], 'Nintendo');
    });
  });
}
