import 'package:app_e_commerce/features/games/data/repositories/game_data.dart';
import 'package:app_e_commerce/features/games/domain/model/game_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Provider de la couche [application] pour [GameDataRepository].
/// Déplacé ici depuis la couche [data] pour respecter la Clean Architecture :
/// les providers Riverpod appartiennent à la couche application ou présentation,
/// pas à la couche data.
final gameDataRepositoryProvider = Provider<GameDataRepository>((ref) {
  return GameDataRepository();
});

/// Provider de chargement asynchrone de la liste des jeux.
/// Expose une [AsyncValue<List<Game>>] consommable directement dans les widgets
/// via `ref.watch(gamesListProvider)`.
final gamesListProvider = FutureProvider<List<Game>>((ref) async {
  return ref.read(gameDataRepositoryProvider).readFile();
});
