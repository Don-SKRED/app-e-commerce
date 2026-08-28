import 'package:app_e_commerce/features/Console/domain/models/console_model.dart';
import 'package:app_e_commerce/features/games/domain/model/game_model.dart';
import 'package:app_e_commerce/features/products/domain/product_model.dart';

class OrderItem {
  final int id;
  final int quantity;
  final double unitPrice;
  final Product product;

  OrderItem({
    required this.id,
    required this.quantity,
    required this.unitPrice,
    required this.product,
  });

  factory OrderItem.fromJson(Map<String, dynamic> json) {
    final productJson = json['product'] as Map<String, dynamic>;
    Product product;
    if (productJson.containsKey('marque') || productJson.containsKey('storageCapacity')) {
      product = Console.fromJson(productJson);
    } else {
      product = Game.fromJson(productJson);
    }

    return OrderItem(
      id: json['id'],
      quantity: json['quantity'],
      unitPrice: (json['unitPrice'] as num).toDouble(),
      product: product,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'quantity': quantity,
      'unitPrice': unitPrice,
      'product': (product as dynamic).toJson(),
    };
  }
}
