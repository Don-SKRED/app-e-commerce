import 'package:app_e_commerce/features/products/domain/product_model.dart';

class Console extends Product {
  final String marque;
  final double storageCapacity;
  final bool joystick;

  Console(
    super.id, {
    required super.name,
    required super.description,
    required super.price,
    required super.image,
    required super.stock,
    required this.marque,
    required this.storageCapacity,
    required this.joystick,
  });

  factory Console.fromJson(Map<String, dynamic> json) {
    return Console(
      int.parse(json['id'].toString()),
      name: json['name'],
      description: json['description'],
      price: (json['price'] as num).toDouble(),
      image: json['image'],
      stock: json['stock'],
      marque: json['marque'],
      storageCapacity: (json['storageCapacity'] as num).toDouble(),
      joystick: json['joystick'],
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
      'marque': marque,
      'storageCapacity': storageCapacity,
      'joystick': joystick,
    };
  }
}

// CONSOLE (id_produit, marque, capacite_stockage, manettes_incluses)
// #id_produit → PRODUIT.id_produit
