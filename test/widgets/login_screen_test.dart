import 'package:app_e_commerce/features/auth/presentation/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('LoginScreen Widget Tests', () {
    testWidgets('Renders all form fields and login button', (tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: LoginScreen(),
          ),
        ),
      );

      expect(find.text('Connexion'), findsWidgets);
      expect(find.text('Email'), findsOneWidget);
      expect(find.text('Mot de passe'), findsOneWidget);
      expect(find.text('Se connecter'), findsOneWidget);
    });

    testWidgets('Shows validation errors when submitted with empty fields', (tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: LoginScreen(),
          ),
        ),
      );

      final buttonFinder = find.widgetWithText(ElevatedButton, 'Se connecter');
      await tester.tap(buttonFinder);
      await tester.pump();

      expect(find.text('Ce champ ne doit pas être vide'), findsWidgets);
    });
  });
}
