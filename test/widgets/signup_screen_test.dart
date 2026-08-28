import 'package:app_e_commerce/features/auth/presentation/screens/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('SignupScreen Widget Tests', () {
    testWidgets('Renders all input fields and signup button', (tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: SignupScreen(),
          ),
        ),
      );

      expect(find.text('Inscription'), findsWidgets);
      expect(find.text("Nom d'utilisateur"), findsOneWidget);
      expect(find.text('Email'), findsOneWidget);
      expect(find.text('Mot de passe'), findsOneWidget);
      expect(find.text('Confirme le mot de passe'), findsOneWidget);
      expect(find.widgetWithText(ElevatedButton, "S'inscrire"), findsOneWidget);
    });

    testWidgets('Validates empty fields on submit', (tester) async {
      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: SignupScreen(),
          ),
        ),
      );

      final submitBtn = find.widgetWithText(ElevatedButton, "S'inscrire");
      await tester.tap(submitBtn);
      await tester.pump();

      expect(find.text('Ce champ ne doit pas être vide'), findsWidgets);
    });
  });
}
