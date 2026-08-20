import 'dart:convert';

class User {
  final int _id;
  final String username;
  final String email;
  final String password;

  User(
    this._id, {
    required this.username,
    required this.email,
    required this.password,
  });

  int get id => _id;
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      json['id'],
      username: json['username'],
      email: json['email'],
      password: json['password'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': _id,
      'username': username,
      'email': email,
      'password': password,
    };
  }

  String generateFakeToken() {
    return base64Encode(
      utf8.encode('$id:$email:${DateTime.now().millisecondsSinceEpoch}'),
    );
  }

  // Décode le token pour en extraire l'id utilisateur
  static String? extractIdFromToken(String token) {
    try {
      final decoded = utf8.decode(base64Decode(token));
      final parts = decoded.split(':');
      return parts.isNotEmpty ? parts[0] : null;
    } catch (e) {
      return null;
    }
  }
}
