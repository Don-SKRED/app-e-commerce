import 'package:app_e_commerce/features/order/domain/models/order_item_model.dart';
import 'package:app_e_commerce/features/order/domain/models/order_model.dart';
import 'package:app_e_commerce/features/order/presentation/controllers/order_controller.dart';
import 'package:app_e_commerce/shared/utils/date_utils.dart';
import 'package:app_e_commerce/shared/utils/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class OrderScreen extends ConsumerWidget {
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final orderAsync = ref.watch(orderControllerProvider);
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SizedBox(
            width: context.containerGameWidth,
            height: context.screenHeight,
            child: orderAsync.when(
              data: (orders) {
                if (orders.isEmpty) {
                  return Center(
                    child: Text(
                      "Aucune commande pour le moment",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: context.textTitleSize,
                      ),
                    ),
                  );
                }
                return ListView.builder(
                  itemCount: orders.length,
                  itemBuilder: (context, index) {
                    print("${orders[index].orderItems}");
                    return Card(
                      elevation: 2,
                      child: Padding(
                        padding: EdgeInsets.all(context.padding),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "Commande n°${orders[index].id}",
                                  style: TextStyle(
                                    fontSize: context.textTitleSize,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  "Date: ${formatDate(orders[index].date)}",
                                  style: TextStyle(
                                    fontSize: context.bodyFontSize - 2,
                                    color: Colors.grey.shade600,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: context.fieldSpacing * 2),
                            const Divider(),
                            ListView.separated(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: orders[index].orderItems.length,
                              itemBuilder: (context, indexItem) {
                                return CardCommand(
                                  orderItem:
                                      orders[index].orderItems[indexItem],
                                );
                              },
                              separatorBuilder:
                                  (contextSeparated, indexSeparated) {
                                    return const Divider();
                                  },
                            ),
                            const Divider(height: 20, color: Colors.grey),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: context.fieldSpacing,
                                vertical: context.fieldSpacing,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    "Total : ",
                                    style: TextStyle(
                                      fontSize: context.textTitleSize,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    "${orders[index].total.toStringAsFixed(2)} €",
                                    style: TextStyle(
                                      fontSize: context.textTitleSize,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.purple,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
              error: (error, stack) {
                return Center(
                  child: Text(
                    "Erreur lors du chargement des commandes",
                    style: TextStyle(color: Colors.red),
                  ),
                );
              },
              loading: () {
                return const Center(child: CircularProgressIndicator());
              },
            ),
          ),
        ),
      ),
    );
  }
}

class CardCommand extends StatelessWidget {
  final OrderItem orderItem;
  const CardCommand({super.key, required this.orderItem});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(
        horizontal: context.fieldSpacing,
        vertical: context.fieldSpacing / 2,
      ),
      leading: Icon(
        Icons.sports_esports,
        size: context.imageGameWidth * 0.15,
        color: Colors.purple,
      ),
      title: Text(
        orderItem.product.name,
        style: TextStyle(
          fontSize: context.bodyFontSize,
          fontWeight: FontWeight.w600,
        ),
      ),
      subtitle: Text(
        "${orderItem.product.price.toStringAsFixed(2)} × ${orderItem.quantity}",
        style: TextStyle(fontSize: context.bodyFontSize - 2),
      ),
      trailing: Text(
        "${(orderItem.product.price * orderItem.quantity).toStringAsFixed(2)} €",
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: context.bodyFontSize,
          color: Colors.purple,
        ),
      ),
    );
  }
}
