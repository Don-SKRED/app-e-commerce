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
}

// CONSOLE (id_produit, marque, capacite_stockage, manettes_incluses)
// #id_produit → PRODUIT.id_produit
