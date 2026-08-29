import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:app_e_commerce/features/games/presentation/providers/quantity_provider.dart';

void main() {
  group('QuantityProvider Tests', () {
    test('Initial quantity should be 1', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      final quantity = container.read(quantityProvider);
      expect(quantity, 1);
    });

    test('increment() should increase quantity but not exceed stock', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      final notifier = container.read(quantityProvider.notifier);

      notifier.increment(3); // stock = 3
      expect(container.read(quantityProvider), 2);

      notifier.increment(3);
      expect(container.read(quantityProvider), 3);

      notifier.increment(3); // capped at 3
      expect(container.read(quantityProvider), 3);
    });

    test('decrement() should decrease quantity but not go below 1', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      final notifier = container.read(quantityProvider.notifier);

      notifier.increment(5); // 2
      notifier.increment(5); // 3

      notifier.decrement();
      expect(container.read(quantityProvider), 2);

      notifier.decrement();
      expect(container.read(quantityProvider), 1);

      notifier.decrement(); // minimum 1
      expect(container.read(quantityProvider), 1);
    });

    test('reset() should reset quantity to 1', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      final notifier = container.read(quantityProvider.notifier);

      notifier.increment(10);
      notifier.increment(10);
      expect(container.read(quantityProvider), 3);

      notifier.reset();
      expect(container.read(quantityProvider), 1);
    });
  });
}
