import 'package:app_e_commerce/features/auth/data/repositories/auth_data_repository.dart';
import 'package:app_e_commerce/features/auth/domain/repositories/auth_repository_interface.dart';
import 'package:app_e_commerce/shared/models/user_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Service applicatif pour l'authentification (Couche Application).
/// Dépend exclusivement de l'interface abstraite [IAuthRepository] (DIP).
class AuthService {
  final IAuthRepository _repository;

  AuthService(this._repository);

  Future<User?> login(String email, String password) {
    return _repository.login(email, password);
  }

  Future<User?> signup(String username, String email, String password) async {
    await _repository.signup(username, email, password);
    return _repository.login(email, password);
  }
}

/// Provider de la couche [application] pour [IAuthRepository].
final authDataRepositoryProvider = Provider<IAuthRepository>((ref) {
  return AuthDataRepository();
});

/// Provider du service applicatif d'authentification.
final authServiceProvider = Provider<AuthService>((ref) {
  return AuthService(ref.read(authDataRepositoryProvider));
});
