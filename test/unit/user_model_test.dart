import 'package:flutter_test/flutter_test.dart';
import 'package:app_e_commerce/shared/models/user_model.dart';

void main() {
  group('UserModel Tests', () {
    final sampleJson = {
      'id': 1,
      'username': 'Skred',
      'email': 'skred@gmail.com',
      'password': 'skred1234',
    };

    test('User.fromJson should correctly deserialize JSON', () {
      final user = User.fromJson(sampleJson);

      expect(user.id, equals(1));
      expect(user.username, equals('Skred'));
      expect(user.email, equals('skred@gmail.com'));
      expect(user.password, equals('skred1234'));
    });

    test('User.toJson should correctly serialize User model to JSON', () {
      final user = User(
        1,
        username: 'Skred',
        email: 'skred@gmail.com',
        password: 'skred1234',
      );

      final json = user.toJson();

      expect(json['id'], equals(1));
      expect(json['username'], equals('Skred'));
      expect(json['email'], equals('skred@gmail.com'));
      expect(json['password'], equals('skred1234'));
    });

    test(
      'generateFakeToken and extractIdFromToken should encode and decode user ID',
      () {
        final user = User(
          42,
          username: 'TestUser',
          email: 'test@example.com',
          password: 'password123',
        );

        final token = user.generateFakeToken();
        expect(token, isNotEmpty);

        final extractedId = User.extractIdFromToken(token);
        expect(extractedId, equals('42'));
      },
    );

    test('extractIdFromToken with invalid token should return null', () {
      final extractedId = User.extractIdFromToken('invalid_base64_token_xyz');
      expect(extractedId, isNull);
    });
  });
}
