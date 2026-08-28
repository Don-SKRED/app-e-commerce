import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:app_e_commerce/features/auth/presentation/controllers/auth_contoller.dart';

void main() {
  group('AuthController Tests', () {
    test('Initial state of AuthController should be AsyncData(null)', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      final authState = container.read(authControllerProvider);
      expect(authState, const AsyncData(null));
    });

    test('logout() should reset state to AsyncData(null)', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      final controller = container.read(authControllerProvider.notifier);
      controller.logout();

      final authState = container.read(authControllerProvider);
      expect(authState, const AsyncData(null));
    });
  });
}
