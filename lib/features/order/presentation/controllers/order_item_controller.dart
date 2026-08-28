import 'package:app_e_commerce/features/order/domain/models/order_item_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class OrderItemController extends Notifier<List<OrderItem>> {
  @override
  List<OrderItem> build() {
    return [];
  }

  void addOrderItem(OrderItem orderItem) {
    state = [...state, orderItem];
  }

  void clear() {
    state = [];
  }
}

final orderItemControllerProvider =
    NotifierProvider<OrderItemController, List<OrderItem>>(
      OrderItemController.new,
    );
