import 'package:app_e_commerce/features/auth/data/repositories/auth_data_repository.dart';
import 'package:app_e_commerce/shared/models/user_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// --- Déclaration manuelle du provider ---
final authControllerProvider = AsyncNotifierProvider<AuthController, User?>(
  AuthController.new,
);

// --- La classe, qui étend directement AsyncNotifier<User?> ---
class AuthController extends AsyncNotifier<User?> {
  @override
  Future<User?> build() async {
    // Pas de persistance de session pour l'instant : au démarrage,
    // l'utilisateur est toujours déconnecté.
    return null;
  }

  Future<void> login(String email, String password) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() {
      return ref.read(authDataRepositoryProvider).login(email, password);
    });
  }

  Future<void> signup(String username, String email, String password) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final repo = ref.read(authDataRepositoryProvider);
      await repo.signup(username, email, password);
      return repo.login(email, password);
    });
  }

  void logout() {
    state = const AsyncData(null);
  }
}
