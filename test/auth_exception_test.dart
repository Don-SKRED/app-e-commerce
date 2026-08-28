import 'package:flutter_test/flutter_test.dart';
import 'package:app_e_commerce/features/auth/exceptions/auth_exception.dart';

void main() {
  group('AuthException Tests', () {
    test('AuthException should have default message', () {
      final exception = AuthException();
      expect(exception.message, equals('Identifiants invalides'));
      expect(exception.toString(), equals('Identifiants invalides'));
    });

    test('AuthException should accept custom message', () {
      final exception = AuthException(message: 'Un compte existe déjà avec cet email');
      expect(exception.message, equals('Un compte existe déjà avec cet email'));
      expect(exception.toString(), equals('Un compte existe déjà avec cet email'));
    });
  });
}
