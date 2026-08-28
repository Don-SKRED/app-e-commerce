import 'package:app_e_commerce/features/order/domain/models/order_item_model.dart';

class Order {
  final int id;
  final DateTime date;
  final double total;
  final List<OrderItem> orderItems;

  Order({
    required this.id,
    required this.date,
    required this.total,
    required this.orderItems,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'],
      date: DateTime.parse(json['date']),
      total: (json['total'] as num).toDouble(),
      orderItems: (json['orderItems'] as List)
          .map((item) => OrderItem.fromJson(item as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'date': date.toIso8601String(),
      'total': total,
      'orderItems': orderItems.map((item) => item.toJson()).toList(),
    };
  }
}
