import 'package:app_e_commerce/features/shopping_cart/domain/shopping_cart_model.dart';

/// Calcule le prix total d'un panier.
///
/// Extraite depuis la couche [presentation] (shopping_cart_controller.dart)
/// vers la couche [application] car il s'agit de logique métier pure,
/// indépendante de tout rendu UI.
double calculateTotal(List<ShoppingCartModel> items) {
  return items.fold(
    0.0,
    (total, item) => total + item.product.price * item.quantity,
  );
}
