import 'package:app_e_commerce/shared/models/user_model.dart';

/// Interface du contrat de persistance pour l'authentification (Couche Domaine).
/// Respecte le principe d'Inversion de Dépendance (DIP) de la Clean Architecture.
abstract class IAuthRepository {
  Future<User?> login(String email, String password);
  Future<void> signup(String username, String email, String password);
  Future<List<User>> readFile();
}
