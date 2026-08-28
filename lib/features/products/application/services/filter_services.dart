import 'package:app_e_commerce/features/products/domain/product_model.dart';

List<Product> filterBySearch(List<Product> products, String query) {
  if (query.trim().isEmpty) {
    return products;
  }
  return products
      .where((product) =>
          product.name.toLowerCase().contains(query.trim().toLowerCase()))
      .toList();
}
