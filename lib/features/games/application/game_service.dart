import 'package:app_e_commerce/features/games/data/repositories/game_data.dart';
import 'package:app_e_commerce/features/games/domain/model/game_model.dart';
import 'package:app_e_commerce/features/games/domain/repositories/game_repository_interface.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Provider de l'interface [IGameRepository] dans la couche application.
final gameDataRepositoryProvider = Provider<IGameRepository>((ref) {
  return GameDataRepository();
});

/// Service applicatif pour les jeux vidéo.
class GameService {
  final IGameRepository _repository;

  GameService(this._repository);

  Future<List<Game>> getGames() => _repository.readFile();
  Future<Game?> getGameById(int id) => _repository.findById(id);
}

/// Provider du service applicatif des jeux.
final gameServiceProvider = Provider<GameService>((ref) {
  return GameService(ref.read(gameDataRepositoryProvider));
});

/// Provider asynchrone pour la liste des jeux.
final gamesListProvider = FutureProvider<List<Game>>((ref) async {
  return ref.read(gameServiceProvider).getGames();
});
