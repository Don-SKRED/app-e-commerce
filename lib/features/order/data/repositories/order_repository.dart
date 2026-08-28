import 'package:app_e_commerce/features/order/domain/models/order_model.dart';
import 'package:app_e_commerce/shared/services/repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class OrderRepository extends Repository<Order> {
  @override
  Order fromJson(Map<String, dynamic> json) {
    return Order.fromJson(json);
  }

  @override
  Map<String, dynamic> toJson(Order entity) {
    return entity.toJson();
  }

  @override
  String get assetPath => 'assets/data/orders.json';

  @override
  String get filename => 'orders.json';
}

final orderRepositoryProvider = Provider<OrderRepository>(
  (ref) => OrderRepository(),
);
