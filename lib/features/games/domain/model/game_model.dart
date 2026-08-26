import 'package:app_e_commerce/features/products/domain/product_model.dart';

class Game extends Product {
  final List<String> platform;
  final String type;
  final String editor;
  // final Date release;

  Game(
    super.id, {
    required super.name,
    required super.description,
    required super.price,
    required super.image,
    required super.stock,
    required this.platform,
    required this.type,
    required this.editor,
  });

  factory Game.fromJson(Map<String, dynamic> json) {
    return Game(
      int.parse(json['id'].toString()),
      name: json['name'],
      description: json['description'],
      price: (json['price'] as num).toDouble(),
      image: json['image'],
      stock: json['stock'],
      platform: List<String>.from(json['platform']),
      type: json['type'],
      editor: json['editor'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'price': price,
      'image': image,
      'stock': stock,
      'platform': platform,
      'type': type,
      'editor': editor,
    };
  }
}

// JEU (id_produit, plateforme, genre, editeur)
// #id_produit → PRODUIT.id_produit
