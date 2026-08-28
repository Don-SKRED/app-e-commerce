import 'package:app_e_commerce/features/games/domain/model/game_model.dart';
import 'package:app_e_commerce/features/products/application/services/filter_services.dart';
import 'package:app_e_commerce/features/products/application/services/sort_services.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Sort & Filter Services Unit Tests', () {
    late List<Game> sampleGames;

    setUp(() {
      sampleGames = [
        Game(
          1,
          name: 'Zelda Tears of the Kingdom',
          description: 'Aventure épique',
          price: 69.99,
          image: 'https://example.com/zelda.jpg',
          stock: 10,
          platform: ['Switch'],
          type: 'Aventure',
          editor: 'Nintendo',
        ),
        Game(
          2,
          name: 'Elden Ring',
          description: 'Action RPG exigeant',
          price: 59.99,
          image: 'https://example.com/elden.jpg',
          stock: 5,
          platform: ['PS5', 'PC'],
          type: 'RPG',
          editor: 'FromSoftware',
        ),
        Game(
          3,
          name: 'Astro Bot',
          description: 'Plateforme 3D',
          price: 49.99,
          image: 'https://example.com/astro.jpg',
          stock: 8,
          platform: ['PS5'],
          type: 'Plateforme',
          editor: 'Sony',
        ),
      ];
    });

    test('sortByName trie la liste par ordre alphabétique croissant', () {
      sortByName(sampleGames);
      expect(sampleGames.first.name, equals('Astro Bot'));
      expect(sampleGames.last.name, equals('Zelda Tears of the Kingdom'));
    });

    test('sortByDesc trie la liste par ordre alphabétique décroissant', () {
      sortByDesc(sampleGames);
      expect(sampleGames.first.name, equals('Zelda Tears of the Kingdom'));
      expect(sampleGames.last.name, equals('Astro Bot'));
    });

    test('sortByPriceAsc trie la liste par prix croissant', () {
      sortByPriceAsc(sampleGames);
      expect(sampleGames.first.price, equals(49.99));
      expect(sampleGames.last.price, equals(69.99));
    });

    test('sortByPriceDesc trie la liste par prix décroissant', () {
      sortByPriceDesc(sampleGames);
      expect(sampleGames.first.price, equals(69.99));
      expect(sampleGames.last.price, equals(49.99));
    });

    test('filterBySearch filtre la liste par mot-clé', () {
      final results = filterBySearch(sampleGames, 'Elden');
      expect(results.length, equals(1));
      expect(results.first.name, equals('Elden Ring'));
    });

    test('filterBySearch renvoie la liste complète si la requête est vide', () {
      final results = filterBySearch(sampleGames, '  ');
      expect(results.length, equals(3));
    });
  });
}
