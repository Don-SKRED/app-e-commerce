import 'package:app_e_commerce/features/games/domain/model/game_model.dart';
import 'package:app_e_commerce/shared/services/repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GameDataRepository extends Repository<Game> {
  @override
  String get assetPath => "assets/data/games.json";

  @override
  String get filename => "games.json";

  @override
  Game fromJson(Map<String, dynamic> json) {
    return Game.fromJson(json);
  }

  @override
  Map<String, dynamic> toJson(Game item) {
    return item.toJson();
  }
}

final gameDataRepositoryProvider = Provider<GameDataRepository>((ref) {
  return GameDataRepository();
});
