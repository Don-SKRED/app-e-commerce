import 'package:app_e_commerce/features/order/application/order_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:app_e_commerce/features/order/domain/models/order_model.dart';

class OrderController extends AsyncNotifier<List<Order>> {
  @override
  Future<List<Order>> build() {
    return ref.read(orderServiceProvider).getOrders();
  }

  Future<void> addOrder(Order order) async {
    await ref.read(orderServiceProvider).addOrder(order);
    state = AsyncData(await ref.read(orderServiceProvider).getOrders());
  }
}

final orderControllerProvider =
    AsyncNotifierProvider<OrderController, List<Order>>(
      () => OrderController(),
    );
