import 'package:app_e_commerce/features/shopping_cart/presentation/controllers/shopping_cart_controller.dart';
import 'package:app_e_commerce/shared/utils/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ShoppingCartScreen extends ConsumerStatefulWidget {
  const ShoppingCartScreen({super.key});

  @override
  ConsumerState<ShoppingCartScreen> createState() => ShoppingCartScreenState();
}

class ShoppingCartScreenState extends ConsumerState<ShoppingCartScreen> {
  @override
  Widget build(BuildContext context) {
    final cart = ref.watch(shoppingCartControllerProvider);

    return Scaffold(
      // --- Bottom sheet : total + bouton commande ---
      bottomSheet: cart.isEmpty
          ? null
          : Container(
              height: context.bottomSheetHeight,
              padding: EdgeInsets.symmetric(
                horizontal: context.padding,
                vertical: 8,
              ),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 8,
                    offset: Offset(0, -2),
                  ),
                ],
              ),
              child: Center(
                child: SizedBox(
                  width: context.containerGameWidth,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Total",
                            style: TextStyle(
                              fontSize: context.bodyFontSize,
                              color: Colors.grey,
                            ),
                          ),
                          Text(
                            "${totalPrice(cart).toStringAsFixed(2)} €",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: context.textTitleSize,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: context.buttonHeight,
                        child: ElevatedButton.icon(
                          onPressed: () {
                            ref
                                .read(shoppingCartControllerProvider.notifier)
                                .clear();
                          },
                          icon: const Icon(Icons.shopping_bag_outlined),
                          label: const Text("Passer la commande"),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.purple,
                            foregroundColor: Colors.white,
                            padding: EdgeInsets.symmetric(
                              horizontal: context.padding,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

      // --- Body ---
      body: cart.isEmpty
          ? SafeArea(
              child: Center(
                child: Text(
                  "Votre panier est vide :(",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: context.textTitleSize,
                  ),
                ),
              ),
            )
          : SafeArea(
              child: Center(
                child: SizedBox(
                  // Centré et limité en largeur sur tablet/desktop
                  width: context.containerGameWidth,
                  child: ListView.builder(
                    padding: EdgeInsets.only(
                      top: context.spacing,
                      bottom: context.bottomSheetClearance,
                      left: context.padding,
                      right: context.padding,
                    ),
                    itemCount: cart.length,
                    itemBuilder: (context, index) {
                      final item = cart[index];
                      return Padding(
                        padding: EdgeInsets.only(
                          bottom: context.fieldSpacing * 2,
                        ),
                        child: Card(
                          elevation: 2,
                          child: ListTile(
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: context.padding,
                              vertical: context.fieldSpacing,
                            ),
                            leading: Icon(
                              Icons.sports_esports,
                              size: context.imageGameWidth * 0.15,
                              color: Colors.purple,
                            ),
                            title: Text(
                              item.product.name,
                              style: TextStyle(
                                fontSize: context.bodyFontSize,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            subtitle: Text(
                              "${item.product.price.toStringAsFixed(2)} € × ${item.quantity}",
                              style: TextStyle(
                                fontSize: context.bodyFontSize - 2,
                              ),
                            ),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  "${(item.product.price * item.quantity).toStringAsFixed(2)} €",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: context.bodyFontSize,
                                    color: Colors.purple,
                                  ),
                                ),
                                SizedBox(width: context.fieldSpacing),
                                IconButton(
                                  onPressed: () {
                                    ref
                                        .read(
                                          shoppingCartControllerProvider
                                              .notifier,
                                        )
                                        .remove(item);
                                  },
                                  icon: const Icon(
                                    Icons.cancel_outlined,
                                    color: Colors.redAccent,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
    );
  }
}
