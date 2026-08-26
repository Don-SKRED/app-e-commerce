import 'package:app_e_commerce/features/products/domain/product_model.dart';

class ProductItem<T extends Product> {
  int quantity;
  T product;

  ProductItem({required this.quantity, required this.product});

  factory ProductItem.fromJson(Map<String, dynamic> json) {
    return ProductItem(quantity: json['quantity'], product: json['product']);
  }
}
