import 'package:app_e_commerce/features/Console/domain/models/console_model.dart';

/// Interface du contrat d'accès aux données des consoles (Couche Domaine).
abstract class IConsoleRepository {
  Future<List<Console>> readFile();
  Future<Console?> findById(int id);
}
