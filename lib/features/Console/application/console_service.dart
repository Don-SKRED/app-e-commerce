import 'package:app_e_commerce/features/Console/data/repositories/console_data.dart';
import 'package:app_e_commerce/features/Console/domain/models/console_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Provider de la couche [application] pour [ConsoleDataRepository].
/// Déplacé ici depuis la couche [data] pour respecter la Clean Architecture :
/// les providers Riverpod appartiennent à la couche application ou présentation,
/// pas à la couche data.
final consoleDataRepositoryProvider = Provider<ConsoleDataRepository>((ref) {
  return ConsoleDataRepository();
});

/// Provider de chargement asynchrone de la liste des consoles.
/// Expose une [AsyncValue<List<Console>>] consommable directement dans les widgets
/// via `ref.watch(consolesListProvider)`.
final consolesListProvider = FutureProvider<List<Console>>((ref) async {
  return ref.read(consoleDataRepositoryProvider).readFile();
});
