import 'package:app_e_commerce/features/products/domain/product_model.dart';

class Game extends Product {
  final List<String> plateform;
  final String type;
  final String editor;

  Game(
    super.id, {
    required super.name,
    required super.description,
    required super.price,
    required super.image,
    required super.stock,
    required this.plateform,
    required this.type,
    required this.editor,
  });
}

// JEU (id_produit, plateforme, genre, editeur
