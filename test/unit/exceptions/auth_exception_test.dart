import 'package:flutter_test/flutter_test.dart';
import 'package:app_e_commerce/features/auth/exceptions/auth_exception.dart';

void main() {
  group('AuthException Tests', () {
    test('AuthException should have default message', () {
      final exception = AuthException();
      expect(exception.message, equals('Email ou mot de passe incorrect'));
      expect(exception.toString(), equals('Email ou mot de passe incorrect'));
    });

    test('AuthException should accept custom message', () {
      final exception = AuthException(message: 'Compte bloqué');
      expect(exception.message, equals('Compte bloqué'));
      expect(exception.toString(), equals('Compte bloqué'));
    });
  });
}
