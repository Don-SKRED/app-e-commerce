import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:app_e_commerce/features/games/application/quantity_service.dart';

void main() {
  group('QuantityService Unit Tests', () {
    test('Initial quantity should be 1', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      final quantity = container.read(quantityServiceProvider);
      expect(quantity, 1);
    });

    test('increment() should increase quantity without exceeding stock', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      final notifier = container.read(quantityServiceProvider.notifier);

      notifier.increment(3);
      expect(container.read(quantityServiceProvider), 2);

      notifier.increment(3);
      expect(container.read(quantityServiceProvider), 3);

      notifier.increment(3); // capped at stock
      expect(container.read(quantityServiceProvider), 3);
    });

    test('decrement() should decrease quantity without going below 1', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      final notifier = container.read(quantityServiceProvider.notifier);

      notifier.increment(5); // 2
      notifier.increment(5); // 3

      notifier.decrement();
      expect(container.read(quantityServiceProvider), 2);

      notifier.decrement();
      expect(container.read(quantityServiceProvider), 1);

      notifier.decrement(); // minimum 1
      expect(container.read(quantityServiceProvider), 1);
    });

    test('reset() should reset quantity to 1', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      final notifier = container.read(quantityServiceProvider.notifier);

      notifier.increment(10);
      notifier.increment(10);
      expect(container.read(quantityServiceProvider), 3);

      notifier.reset();
      expect(container.read(quantityServiceProvider), 1);
    });
  });
}
