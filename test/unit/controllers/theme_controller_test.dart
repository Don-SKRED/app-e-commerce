import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:app_e_commerce/shared/services/theme_provider.dart';

void main() {
  group('ThemeController Unit Tests', () {
    test('Initial theme should be ThemeMode.system', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      final theme = container.read(themeControllerProvider);
      expect(theme, equals(ThemeMode.system));
    });

    test('setTheme should update theme mode', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      final notifier = container.read(themeControllerProvider.notifier);
      notifier.setTheme(ThemeMode.dark);

      expect(container.read(themeControllerProvider), equals(ThemeMode.dark));
    });

    test('toggle should alternate between light and dark', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      final notifier = container.read(themeControllerProvider.notifier);
      notifier.setTheme(ThemeMode.light);

      notifier.toggle();
      expect(container.read(themeControllerProvider), equals(ThemeMode.dark));

      notifier.toggle();
      expect(container.read(themeControllerProvider), equals(ThemeMode.light));
    });
  });
}
