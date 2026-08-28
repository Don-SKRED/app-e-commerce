import 'package:app_e_commerce/features/order/data/repositories/order_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:app_e_commerce/features/order/domain/models/order_model.dart';

class OrderController extends AsyncNotifier<List<Order>> {
  @override
  Future<List<Order>> build() {
    return ref.read(orderRepositoryProvider).readFile();
  }

  Future<void> addOrder(Order order) async {
    await ref.read(orderRepositoryProvider).add(order);
    state = AsyncData(await ref.read(orderRepositoryProvider).readFile());
  }
}

final orderControllerProvider =
    AsyncNotifierProvider<OrderController, List<Order>>(
      () => OrderController(),
    );
