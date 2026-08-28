import 'package:app_e_commerce/features/order/domain/models/order_model.dart';

/// Interface du contrat de persistance des commandes (Couche Domaine).
abstract class IOrderRepository {
  Future<List<Order>> readFile();
  Future<void> add(Order order);
  Future<int> generateNewId();
}
