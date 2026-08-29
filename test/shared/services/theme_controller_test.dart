import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:app_e_commerce/shared/services/theme_provider.dart';

void main() {
  group('ThemeController — NotifierProvider Tests', () {
    test('État initial : ThemeMode.system', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      final state = container.read(themeControllerProvider);
      expect(state, ThemeMode.system);
    });

    test('setTheme(dark) → state passe à ThemeMode.dark', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      container.read(themeControllerProvider.notifier).setTheme(ThemeMode.dark);

      expect(container.read(themeControllerProvider), ThemeMode.dark);
    });

    test('setTheme(light) → state passe à ThemeMode.light', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      container
          .read(themeControllerProvider.notifier)
          .setTheme(ThemeMode.light);

      expect(container.read(themeControllerProvider), ThemeMode.light);
    });

    test('toggle() depuis system → passe à dark', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      // system ≠ dark → toggle() applique le cas "else" → dark
      container.read(themeControllerProvider.notifier).toggle();
      expect(container.read(themeControllerProvider), ThemeMode.dark);
    });

    test('toggle() depuis dark → passe à light', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      final notifier = container.read(themeControllerProvider.notifier);
      notifier.setTheme(ThemeMode.dark);

      notifier.toggle();
      expect(container.read(themeControllerProvider), ThemeMode.light);
    });

    test('toggle() depuis light → passe à dark', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      final notifier = container.read(themeControllerProvider.notifier);
      notifier.setTheme(ThemeMode.light);

      notifier.toggle();
      expect(container.read(themeControllerProvider), ThemeMode.dark);
    });

    test('toggle() deux fois → revient à l\'état dark de départ', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      final notifier = container.read(themeControllerProvider.notifier);
      notifier.setTheme(ThemeMode.dark);

      notifier.toggle(); // dark → light
      notifier.toggle(); // light → dark
      expect(container.read(themeControllerProvider), ThemeMode.dark);
    });

    test('chaque container a son propre état isolé', () {
      final containerA = ProviderContainer();
      final containerB = ProviderContainer();
      addTearDown(containerA.dispose);
      addTearDown(containerB.dispose);

      containerA.read(themeControllerProvider.notifier).setTheme(ThemeMode.dark);
      // containerB n'est pas modifié
      expect(containerA.read(themeControllerProvider), ThemeMode.dark);
      expect(containerB.read(themeControllerProvider), ThemeMode.system);
    });
  });
}
