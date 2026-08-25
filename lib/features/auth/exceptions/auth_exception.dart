class AuthException implements Exception {
  final String message;

  AuthException({this.message = "Identifiants invalides"});

  @override
  String toString() => message;
}
