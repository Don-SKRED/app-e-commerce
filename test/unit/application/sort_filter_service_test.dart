import 'package:flutter_test/flutter_test.dart';
import 'package:app_e_commerce/features/games/domain/model/game_model.dart';
import 'package:app_e_commerce/features/products/application/services/filter_services.dart';
import 'package:app_e_commerce/features/products/application/services/sort_services.dart';

void main() {
  group('Sort & Filter Services Tests', () {
    late Game gameA;
    late Game gameB;
    late Game gameC;

    setUp(() {
      gameA = Game(
        1,
        name: 'Zelda',
        description: 'Aventure',
        price: 59.99,
        image: 'zelda.jpg',
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
        image: 'ac.jpg',
        stock: 8,
        platform: ['Switch'],
        type: 'Simulation',
        editor: 'Nintendo',
      );

      gameC = Game(
        3,
        name: 'Mario Kart',
        description: 'Course',
        price: 49.99,
        image: 'mk.jpg',
        stock: 15,
        platform: ['Switch'],
        type: 'Course',
        editor: 'Nintendo',
      );
    });

    test('sortByName sorts ascending alphabetically', () {
      final list = [gameA, gameB, gameC];
      sortByName(list);

      expect(list.map((e) => e.name).toList(), [
        'Animal Crossing',
        'Mario Kart',
        'Zelda',
      ]);
    });

    test('sortByDesc sorts descending alphabetically', () {
      final list = [gameA, gameB, gameC];
      sortByDesc(list);

      expect(list.map((e) => e.name).toList(), [
        'Zelda',
        'Mario Kart',
        'Animal Crossing',
      ]);
    });

    test('sortByPriceAsc sorts ascending by price', () {
      final list = [gameA, gameB, gameC];
      sortByPriceAsc(list);

      expect(list.map((e) => e.price).toList(), [
        45.00,
        49.99,
        59.99,
      ]);
    });

    test('sortByPriceDesc sorts descending by price', () {
      final list = [gameA, gameB, gameC];
      sortByPriceDesc(list);

      expect(list.map((e) => e.price).toList(), [
        59.99,
        49.99,
        45.00,
      ]);
    });

    test('filterBySearch filters by case-insensitive name', () {
      final list = [gameA, gameB, gameC];
      final result = filterBySearch(list, 'mario');

      expect(result.length, equals(1));
      expect(result.first.name, equals('Mario Kart'));
    });

    test('filterBySearch returns full list when query is empty', () {
      final list = [gameA, gameB, gameC];
      final result = filterBySearch(list, '');

      expect(result.length, equals(3));
    });
  });
}
