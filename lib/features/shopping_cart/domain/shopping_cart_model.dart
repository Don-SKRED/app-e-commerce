import 'package:app_e_commerce/features/products/domain/product_model.dart';

enum ProductType { game, console }

class ShoppingCartModel<T extends Product> {
  final int userId;
  final T product;
  final int quantity;

  ShoppingCartModel({
    required this.userId,
    required this.product,
    required this.quantity,
  });

  // factory ShoppingCartModel.fromJson(Map<String, dynamic> json) {
  //   return ShoppingCartModel(
  //     userId: json['userId'],
  //     product: json['product'],
  //     quantity: json['quantity'],
  //     productType: json['productType'],
  //   );
  // }

  // Map<String, dynamic> toJson() {
  //   return {'userId': userId, 'product': product, 'quantity': quantity,};
  // }

  ShoppingCartModel copyWith({int? userId, T? product, int? quantity}) {
    return ShoppingCartModel(
      userId: userId ?? this.userId,
      product: product ?? this.product,
      quantity: quantity ?? this.quantity,
    );
  }
}
