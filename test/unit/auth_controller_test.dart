import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:app_e_commerce/features/auth/presentation/controllers/auth_contoller.dart';

void main() {
  group('AuthController Tests', () {
    test('Initial state of AuthController should be AsyncData(null)', () async {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      final state = await container.read(authControllerProvider.future);
      expect(state, isNull);
    });

    test('logout() should reset state to AsyncData(null)', () async {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      final controller = container.read(authControllerProvider.notifier);
      controller.logout();

      final state = container.read(authControllerProvider);
      expect(state.value, isNull);
    });
  });
}
