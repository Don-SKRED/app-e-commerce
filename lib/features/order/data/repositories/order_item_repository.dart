import 'package:app_e_commerce/features/order/domain/models/order_item_model.dart';
import 'package:app_e_commerce/shared/services/repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class OrderItemRepository extends Repository<OrderItem> {
  @override
  OrderItem fromJson(Map<String, dynamic> json) {
    return OrderItem.fromJson(json);
  }

  @override
  Map<String, dynamic> toJson(OrderItem entity) {
    return entity.toJson();
  }

  @override
  String get assetPath => 'assets/data/order_items.json';

  @override
  String get filename => 'order_items.json';
}

final orderItemRepositoryProvider = Provider<OrderItemRepository>(
  (ref) => OrderItemRepository(),
);
