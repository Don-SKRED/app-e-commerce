import 'package:app_e_commerce/features/games/domain/model/game_model.dart';

/// Interface du contrat d'accès aux données des jeux vidéo (Couche Domaine).
abstract class IGameRepository {
  Future<List<Game>> readFile();
  Future<Game?> findById(int id);
}
