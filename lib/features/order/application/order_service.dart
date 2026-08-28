import 'package:app_e_commerce/features/order/data/repositories/order_repository.dart';
import 'package:app_e_commerce/features/order/data/repositories/order_item_repository.dart';
import 'package:app_e_commerce/features/order/domain/models/order_model.dart';
import 'package:app_e_commerce/features/order/domain/repositories/order_repository_interface.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Provider de l'interface [IOrderRepository] dans la couche application.
final orderRepositoryProvider = Provider<IOrderRepository>(
  (ref) => OrderRepository(),
);

/// Provider du repository des items de commande.
final orderItemRepositoryProvider = Provider<OrderItemRepository>(
  (ref) => OrderItemRepository(),
);

/// Service applicatif pour les commandes (Couche Application).
/// Dépend de l'interface [IOrderRepository].
class OrderService {
  final IOrderRepository _repository;

  OrderService(this._repository);

  Future<List<Order>> getOrders() {
    return _repository.readFile();
  }

  Future<void> addOrder(Order order) {
    return _repository.add(order);
  }

  Future<int> generateOrderId() {
    return _repository.generateNewId();
  }
}

/// Provider du service applicatif de commandes.
final orderServiceProvider = Provider<OrderService>((ref) {
  return OrderService(ref.read(orderRepositoryProvider));
});
