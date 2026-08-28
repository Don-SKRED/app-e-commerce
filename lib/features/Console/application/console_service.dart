import 'package:app_e_commerce/features/Console/data/repositories/console_data.dart';
import 'package:app_e_commerce/features/Console/domain/models/console_model.dart';
import 'package:app_e_commerce/features/Console/domain/repositories/console_repository_interface.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Provider de l'interface [IConsoleRepository] dans la couche application.
final consoleDataRepositoryProvider = Provider<IConsoleRepository>((ref) {
  return ConsoleDataRepository();
});

/// Service applicatif pour les consoles.
class ConsoleService {
  final IConsoleRepository _repository;

  ConsoleService(this._repository);

  Future<List<Console>> getConsoles() => _repository.readFile();
  Future<Console?> getConsoleById(int id) => _repository.findById(id);
}

/// Provider du service applicatif des consoles.
final consoleServiceProvider = Provider<ConsoleService>((ref) {
  return ConsoleService(ref.read(consoleDataRepositoryProvider));
});

/// Provider asynchrone pour la liste des consoles.
final consolesListProvider = FutureProvider<List<Console>>((ref) async {
  return ref.read(consoleServiceProvider).getConsoles();
});
