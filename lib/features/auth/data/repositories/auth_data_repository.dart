import 'package:app_e_commerce/features/auth/domain/models/user_model.dart';
import 'package:app_e_commerce/features/exceptions/auth_exception.dart';
import 'package:app_e_commerce/shared/services/repository.dart';

class AuthDataRepository extends Repository<User> {
  @override
  String get assetPath => "assets/data/users.json";

  @override
  String get filename => "users.json";

  @override
  fromJson(Map<String, dynamic> json) {
    return User.fromJson(json);
  }

  @override
  Map<String, dynamic> toJson(item) {
    return item.toJson();
  }

  Future login(String email, String password) async {
    List<User> listUser = await readFile();
    final userJson = listUser.firstWhere(
      (u) => u.email == email && u.password == password,
      orElse: () => throw AuthException(),
    );
    return userJson;
  }

  Future signup(String username, String email, String password) async {
    int newId = await generateNewId();
    User newUser = User(
      newId,
      username: username,
      email: email,
      password: password,
    );
    await add(newUser);
  }
}
