import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:app_e_commerce/features/auth/presentation/controllers/auth_contoller.dart';
import 'package:app_e_commerce/features/auth/data/repositories/auth_data_repository.dart';
import 'package:app_e_commerce/features/auth/exceptions/auth_exception.dart';
import 'package:app_e_commerce/shared/models/user_model.dart';

// ── Mock du repository ─────────────────────────────────────────────────────
// On surcharge uniquement les méthodes utiles, sans accès fichier.
class FakeAuthRepository extends AuthDataRepository {
  final List<User> _users;

  FakeAuthRepository(this._users);

  @override
  Future<List<User>> readFile() async => _users;

  @override
  Future<void> add(User item) async {
    _users.add(item);
  }

  @override
  Future<int> generateNewId() async =>
      _users.isEmpty ? 1 : _users.map((u) => u.id).reduce((a, b) => a > b ? a : b) + 1;
}

// ── Helper ─────────────────────────────────────────────────────────────────
ProviderContainer buildContainer({List<User> users = const []}) {
  final fakeRepo = FakeAuthRepository(List.of(users));
  return ProviderContainer(
    overrides: [
      authDataRepositoryProvider.overrideWithValue(fakeRepo),
    ],
  );
}

// ── Tests ──────────────────────────────────────────────────────────────────
void main() {
  group('AuthController — AsyncNotifierProvider Tests', () {
    // ── État initial ──────────────────────────────────────────────────────
    test('État initial : AsyncData(null) — aucun utilisateur connecté', () async {
      final container = buildContainer();
      addTearDown(container.dispose);

      final state = await container.read(authControllerProvider.future);
      expect(state, isNull);
    });

    // ── login() ───────────────────────────────────────────────────────────
    test('login() avec identifiants valides → state contient l\'utilisateur', () async {
      final users = [
        User(1, username: 'Skred', email: 'skred@gmail.com', password: 'skred1234'),
      ];
      final container = buildContainer(users: users);
      addTearDown(container.dispose);

      await container
          .read(authControllerProvider.notifier)
          .login('skred@gmail.com', 'skred1234');

      final state = container.read(authControllerProvider);
      expect(state.hasValue, isTrue);
      expect(state.value?.email, 'skred@gmail.com');
      expect(state.value?.username, 'Skred');
    });

    test('login() avec mauvais mot de passe → state en AsyncError', () async {
      final users = [
        User(1, username: 'Skred', email: 'skred@gmail.com', password: 'skred1234'),
      ];
      final container = buildContainer(users: users);
      addTearDown(container.dispose);

      await container
          .read(authControllerProvider.notifier)
          .login('skred@gmail.com', 'mauvaismdp');

      final state = container.read(authControllerProvider);
      expect(state.hasError, isTrue);
      expect(state.error, isA<AuthException>());
    });

    test('login() avec email inconnu → state en AsyncError', () async {
      final container = buildContainer(); // aucun utilisateur
      addTearDown(container.dispose);

      await container
          .read(authControllerProvider.notifier)
          .login('inconnu@test.com', 'mdp123');

      final state = container.read(authControllerProvider);
      expect(state.hasError, isTrue);
    });

    // ── logout() ──────────────────────────────────────────────────────────
    test('logout() réinitialise state à AsyncData(null)', () async {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      container.read(authControllerProvider.notifier).logout();

      final state = container.read(authControllerProvider);
      expect(state.value, isNull);
    });

    test('logout() après login() → state revient à null', () async {
      final users = [
        User(1, username: 'Skred', email: 'skred@gmail.com', password: 'skred1234'),
      ];
      final container = buildContainer(users: users);
      addTearDown(container.dispose);

      await container
          .read(authControllerProvider.notifier)
          .login('skred@gmail.com', 'skred1234');

      expect(container.read(authControllerProvider).value?.email, 'skred@gmail.com');

      container.read(authControllerProvider.notifier).logout();

      expect(container.read(authControllerProvider).value, isNull);
    });

    // ── signup() ──────────────────────────────────────────────────────────
    test('signup() puis login() → authentification réussie', () async {
      final container = buildContainer(); // base vide
      addTearDown(container.dispose);

      await container
          .read(authControllerProvider.notifier)
          .signup('NouvelUser', 'new@test.com', 'mdp456');

      await container
          .read(authControllerProvider.notifier)
          .login('new@test.com', 'mdp456');

      final state = container.read(authControllerProvider);
      expect(state.hasValue, isTrue);
      expect(state.value?.email, 'new@test.com');
      expect(state.value?.username, 'NouvelUser');
    });

    test('signup() avec email déjà existant → state en AsyncError', () async {
      final users = [
        User(1, username: 'Skred', email: 'skred@gmail.com', password: 'skred1234'),
      ];
      final container = buildContainer(users: users);
      addTearDown(container.dispose);

      await container
          .read(authControllerProvider.notifier)
          .signup('AutreUser', 'skred@gmail.com', 'autremdp');

      final state = container.read(authControllerProvider);
      expect(state.hasError, isTrue);
      expect(
        (state.error as AuthException).message,
        'Un compte existe déjà avec cet email',
      );
    });
  });
}
