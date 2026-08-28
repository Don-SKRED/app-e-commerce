import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:app_e_commerce/features/order/application/order_service.dart';
import 'package:app_e_commerce/features/order/data/repositories/order_repository.dart';
import 'package:app_e_commerce/features/order/domain/models/order_model.dart';
import 'package:app_e_commerce/features/order/presentation/controllers/order_controller.dart';

class FakeOrderRepository extends OrderRepository {
  final List<Order> _orders = [];

  @override
  Future<List<Order>> readFile() async {
    return List.from(_orders);
  }

  @override
  Future<void> add(Order item) async {
    _orders.add(item);
  }
}

void main() {
  group('OrderController Tests', () {
    late ProviderContainer container;
    late FakeOrderRepository fakeRepo;

    setUp(() {
      fakeRepo = FakeOrderRepository();
      container = ProviderContainer(
        overrides: [
          orderRepositoryProvider.overrideWithValue(fakeRepo),
        ],
      );
    });

    tearDown(() {
      container.dispose();
    });

    test('Initial state should load orders from repository', () async {
      final state = await container.read(orderControllerProvider.future);
      expect(state, isEmpty);
    });

    test('addOrder should persist new order and update state', () async {
      final controller = container.read(orderControllerProvider.notifier);
      final newOrder = Order(
        id: 1,
        date: DateTime(2024, 1, 1),
        total: 99.99,
        orderItems: [],
      );

      await controller.addOrder(newOrder);

      final state = container.read(orderControllerProvider).asData?.value;
      expect(state, isNotNull);
      expect(state!.length, equals(1));
      expect(state.first.id, equals(1));
      expect(state.first.total, equals(99.99));
    });
  });
}
