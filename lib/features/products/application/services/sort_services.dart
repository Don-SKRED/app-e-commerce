import 'package:app_e_commerce/features/products/domain/product_model.dart';

void sortByName(List<Product> product) {
  product.sort((a, b) => a.name.compareTo(b.name));
}

void sortByDesc(List<Product> product) {
  product.sort((a, b) => b.name.compareTo(a.name));
}

void sortByPriceAsc(List<Product> product) {
  product.sort((a, b) => a.price.compareTo(b.price));
}

void sortByPriceDesc(List<Product> product) {
  product.sort((a, b) => b.price.compareTo(a.price));
}
