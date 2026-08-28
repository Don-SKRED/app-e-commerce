import 'package:app_e_commerce/features/auth/data/repositories/auth_data_repository.dart';
import 'package:app_e_commerce/shared/models/user_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Service applicatif pour l'authentification.
/// Sert de pont entre la couche [data] (AuthDataRepository)
/// et la couche [presentation] (AuthController).
/// Il centralise toute la logique métier liée à l'authentification.
class AuthService {
  final AuthDataRepository _repository;

  AuthService(this._repository);

  Future<User?> login(String email, String password) {
    return _repository.login(email, password);
  }

  Future<User?> signup(String username, String email, String password) async {
    await _repository.signup(username, email, password);
    return _repository.login(email, password);
  }
}

/// Provider de la couche [application] pour [AuthDataRepository].
/// C'est ici, dans la couche application, que le provider du repository
/// doit être exposé — et non dans la couche [data].
final authDataRepositoryProvider = Provider<AuthDataRepository>((ref) {
  return AuthDataRepository();
});

/// Provider du service applicatif d'authentification.
/// La présentation (controllers) doit utiliser ce provider,
/// et non pas [authDataRepositoryProvider] directement.
final authServiceProvider = Provider<AuthService>((ref) {
  return AuthService(ref.read(authDataRepositoryProvider));
});
