import 'package:app_e_commerce/features/shopping_cart/domain/shopping_cart_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ShoppingCartController extends Notifier<List<ShoppingCartModel>> {
  @override
  List<ShoppingCartModel> build() {
    return [];
  }

  void add(ShoppingCartModel cart) {
    final existingIndex = state.indexWhere(
      (item) => item.product.id == cart.product.id,
    );

    if (existingIndex != -1) {
      final updated = state[existingIndex].copyWith(
        quantity: state[existingIndex].quantity + cart.quantity,
      );
      state = [
        for (int i = 0; i < state.length; i++)
          if (i == existingIndex) updated else state[i],
      ];
    } else {
      state = [...state, cart];
    }
  }

  void remove(ShoppingCartModel cart) {
    state = state.where((item) => item.product.id != cart.product.id).toList();
  }

  void clear() {
    state = [];
  }
}

double totalPrice(List<ShoppingCartModel> cart) {
  double total = 0;
  for (var item in cart) {
    total += item.product.price * item.quantity;
  }
  return total;
}

final shoppingCartControllerProvider =
    NotifierProvider<ShoppingCartController, List<ShoppingCartModel>>(
      ShoppingCartController.new,
    );
