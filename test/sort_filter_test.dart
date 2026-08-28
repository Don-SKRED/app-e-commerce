import 'package:app_e_commerce/features/games/domain/model/game_model.dart';
import 'package:app_e_commerce/features/products/application/services/filter_services.dart';
import 'package:app_e_commerce/features/products/application/services/sort_services.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Sort & Filter Services Unit Tests', () {
    late Game gameA;
    late Game gameB;
    late Game gameC;

    setUp(() {
      gameA = Game(
        1,
        name: 'Zelda Breath of the Wild',
        description: 'Action-Aventure',
        price: 59.99,
        image: 'https://example.com/zelda.jpg',
        stock: 5,
        platform: ['Switch'],
        type: 'Aventure',
        editor: 'Nintendo',
      );

      gameB = Game(
        2,
        name: 'Animal Crossing',
        description: 'Simulation',
        price: 45.00,
        image: 'https://example.com/ac.jpg',
        stock: 8,
        platform: ['Switch'],
        type: 'Simulation',
        editor: 'Nintendo',
      );

      gameC = Game(
        3,
        name: 'Mario Kart 8',
        description: 'Course',
        price: 49.99,
        image: 'https://example.com/mk8.jpg',
        stock: 15,
        platform: ['Switch'],
        type: 'Course',
        editor: 'Nintendo',
      );
    });

    test('sortByName trie la liste par ordre alphabétique croissant', () {
      final list = [gameA, gameB, gameC];
      sortByName(list);

      expect(list.map((e) => e.name).toList(), [
        'Animal Crossing',
        'Mario Kart 8',
        'Zelda Breath of the Wild',
      ]);
    });

    test('sortByDesc trie la liste par ordre alphabétique décroissant', () {
      final list = [gameA, gameB, gameC];
      sortByDesc(list);

      expect(list.map((e) => e.name).toList(), [
        'Zelda Breath of the Wild',
        'Mario Kart 8',
        'Animal Crossing',
      ]);
    });

    test('sortByPriceAsc trie la liste par prix croissant', () {
      final list = [gameA, gameB, gameC];
      sortByPriceAsc(list);

      expect(list.map((e) => e.price).toList(), [
        45.00,
        49.99,
        59.99,
      ]);
    });

    test('sortByPriceDesc trie la liste par prix décroissant', () {
      final list = [gameA, gameB, gameC];
      sortByPriceDesc(list);

      expect(list.map((e) => e.price).toList(), [
        59.99,
        49.99,
        45.00,
      ]);
    });

    test('filterBySearch filtre la liste par mot-clé', () {
      final list = [gameA, gameB, gameC];
      final filtered = filterBySearch(list, 'mario');

      expect(filtered.length, equals(1));
      expect(filtered.first.name, equals('Mario Kart 8'));
    });

    test('filterBySearch renvoie la liste complète si la requête est vide', () {
      final list = [gameA, gameB, gameC];
      final filtered = filterBySearch(list, '');

      expect(filtered.length, equals(3));
    });
  });
}
