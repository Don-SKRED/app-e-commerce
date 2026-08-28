import 'package:app_e_commerce/features/Console/domain/models/console_model.dart';
import 'package:app_e_commerce/shared/services/repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ConsoleDataRepository extends Repository<Console> {
  @override
  String get assetPath => "assets/data/consoles.json";

  @override
  String get filename => "consoles.json";

  @override
  Console fromJson(Map<String, dynamic> json) {
    return Console.fromJson(json);
  }

  @override
  Map<String, dynamic> toJson(Console item) {
    return item.toJson();
  }
}

final consoleDataRepositoryProvider = Provider<ConsoleDataRepository>((ref) {
  return ConsoleDataRepository();
});
