import 'package:app_e_commerce/features/order/data/repositories/order_repository.dart';
import 'package:app_e_commerce/features/order/data/repositories/order_item_repository.dart';
import 'package:app_e_commerce/features/order/domain/models/order_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Provider de la couche [application] pour [OrderRepository].
/// Déplacé depuis la couche [data] pour respecter la séparation des couches.
final orderRepositoryProvider = Provider<OrderRepository>(
  (ref) => OrderRepository(),
);

/// Provider de la couche [application] pour [OrderItemRepository].
/// Déplacé depuis la couche [data] pour respecter la séparation des couches.
final orderItemRepositoryProvider = Provider<OrderItemRepository>(
  (ref) => OrderItemRepository(),
);

/// Service applicatif pour la gestion des commandes.
/// Sert de pont entre la couche [data] (OrderRepository)
/// et la couche [presentation] (OrderController).
/// Le controller ne doit jamais appeler le repository directement.
class OrderService {
  final OrderRepository _repository;

  OrderService(this._repository);

  /// Charge toutes les commandes depuis le fichier local.
  Future<List<Order>> getOrders() {
    return _repository.readFile();
  }

  /// Persiste une nouvelle commande.
  Future<void> addOrder(Order order) {
    return _repository.add(order);
  }
}

/// Provider du service applicatif de gestion des commandes.
/// La présentation doit utiliser ce provider au lieu de [orderRepositoryProvider].
final orderServiceProvider = Provider<OrderService>((ref) {
  return OrderService(ref.read(orderRepositoryProvider));
});
