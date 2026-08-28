import 'package:flutter_test/flutter_test.dart';
import 'package:app_e_commerce/features/auth/application/auth_service.dart';
import 'package:app_e_commerce/features/auth/data/repositories/auth_data_repository.dart';
import 'package:app_e_commerce/features/auth/exceptions/auth_exception.dart';
import 'package:app_e_commerce/shared/models/user_model.dart';

class FakeAuthDataRepository extends AuthDataRepository {
  final List<User> _users = [
    User(1, username: 'testuser', email: 'test@example.com', password: 'password123'),
  ];

  @override
  Future<User?> login(String email, String password) async {
    final match = _users.where((u) => u.email == email && u.password == password);
    if (match.isEmpty) {
      throw AuthException(message: 'Identifiants invalides');
    }
    return match.first;
  }

  @override
  Future<void> signup(String username, String email, String password) async {
    final alreadyExists = _users.any((u) => u.email == email);
    if (alreadyExists) {
      throw AuthException(message: 'Un compte existe déjà avec cet email');
    }
    _users.add(User(_users.length + 1, username: username, email: email, password: password));
  }
}

void main() {
  group('AuthService Tests', () {
    late FakeAuthDataRepository fakeRepo;
    late AuthService authService;

    setUp(() {
      fakeRepo = FakeAuthDataRepository();
      authService = AuthService(fakeRepo);
    });

    test('login with valid credentials should return user', () async {
      final user = await authService.login('test@example.com', 'password123');

      expect(user, isNotNull);
      expect(user!.username, equals('testuser'));
    });

    test('login with invalid credentials should throw AuthException', () async {
      expect(
        () => authService.login('wrong@example.com', 'wrongpassword'),
        throwsA(isA<AuthException>()),
      );
    });

    test('signup with new email should succeed and return user upon login', () async {
      final newUser = await authService.signup('newuser', 'new@example.com', 'newpass123');

      expect(newUser, isNotNull);
      expect(newUser!.username, equals('newuser'));
      expect(newUser.email, equals('new@example.com'));
    });

    test('signup with existing email should throw AuthException', () async {
      expect(
        () => authService.signup('other', 'test@example.com', 'pass123'),
        throwsA(isA<AuthException>()),
      );
    });
  });
}
