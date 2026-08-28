import 'package:app_e_commerce/features/games/domain/model/game_model.dart';
import 'package:app_e_commerce/features/games/domain/repositories/game_repository_interface.dart';
import 'package:app_e_commerce/shared/services/repository.dart';

class GameDataRepository extends Repository<Game> implements IGameRepository {
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
