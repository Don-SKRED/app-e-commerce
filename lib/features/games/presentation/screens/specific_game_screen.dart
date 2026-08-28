import 'package:app_e_commerce/features/auth/presentation/controllers/auth_contoller.dart';
import 'package:app_e_commerce/features/favorites/presentation/controllers/favorites_controller.dart';
import 'package:app_e_commerce/features/games/domain/model/game_model.dart';
import 'package:app_e_commerce/features/games/application/quantity_service.dart';
import 'package:app_e_commerce/features/shopping_cart/domain/shopping_cart_model.dart';
import 'package:app_e_commerce/features/shopping_cart/presentation/controllers/shopping_cart_controller.dart';
import 'package:app_e_commerce/shared/utils/responsive.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class SpecificGameScreen extends ConsumerWidget {
  final Game? game;

  const SpecificGameScreen({super.key, this.game});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authControllerProvider).value;
    final quantity = ref.watch(quantityServiceProvider); // écoute les changements
    final isFavorite = game != null &&
        ref.watch(favoritesControllerProvider).any((item) => item.id == game!.id);

    final displayTitle = game?.name ?? "Nom du jeu";
    final displayPlatforms = game != null
        ? game!.platform.join(", ")
        : "Non spécifiée";
    final displayPrice = game != null ? "${game!.price} €" : "0.00 €";
    final displayStock = game != null ? "${game!.stock}" : "0";
    final displayDescription =
        game?.description ?? "Aucune description disponible";
    final displayImage = game?.image;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Stack(
            children: [
              Padding(
                padding: EdgeInsets.all(context.padding),
                child: Center(
                  child: SizedBox(
                    width: context.containerGameWidth,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      spacing: context.spacing,
                      children: [
                        Center(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(60),
                            child: Container(
                              height: context.imageGameWidth,
                              width: context.imageGameWidth,
                              color: Colors.grey.shade200,
                              child:
                                  displayImage != null &&
                                      displayImage.isNotEmpty
                                  ? CachedNetworkImage(
                                      imageUrl: displayImage,
                                      fit: BoxFit.cover,
                                      placeholder: (context, url) =>
                                          const Center(
                                            child: CircularProgressIndicator(),
                                          ),
                                      errorWidget: (context, url, error) =>
                                          const Icon(
                                            Icons.videogame_asset,
                                            size: 50,
                                            color: Colors.grey,
                                          ),
                                    )
                                  : const Icon(
                                      Icons.videogame_asset,
                                      size: 50,
                                      color: Colors.grey,
                                    ),
                            ),
                          ),
                        ),
                        Text(
                          displayTitle,
                          style: TextStyle(
                            fontSize: context.textTitleSize,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Plateformes : $displayPlatforms",
                              style: TextStyle(fontSize: context.bodyFontSize),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  color: Colors.indigo,
                                  width: 1,
                                ),
                              ),
                              child: Row(
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      ref
                                          .read(quantityServiceProvider.notifier)
                                          .decrement();
                                    },
                                    icon: Icon(Icons.remove),
                                  ),
                                  SizedBox(width: 20, child: Text("$quantity")),
                                  IconButton(
                                    onPressed: () {
                                      ref
                                          .read(quantityServiceProvider.notifier)
                                          .increment(int.parse(displayStock));
                                    },
                                    icon: Icon(Icons.add),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Prix : $displayPrice",
                              style: TextStyle(
                                fontSize: context.bodyFontSize,
                                fontWeight: FontWeight.bold,
                                color: Colors.green.shade700,
                              ),
                            ),
                            Text(
                              "Stock : $displayStock",
                              style: TextStyle(fontSize: context.bodyFontSize),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Description",
                              style: TextStyle(
                                fontSize: context.bodyFontSize,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              displayDescription,
                              style: TextStyle(fontSize: context.bodyFontSize),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: MediaQuery.sizeOf(context).width,
                          height: context.buttonHeight,
                          child: ElevatedButton(
                            onPressed: () {
                              ref
                                  .read(shoppingCartControllerProvider.notifier)
                                  .add(
                                    ShoppingCartModel(
                                      userId: user!.id,
                                      product: game!,
                                      quantity: quantity,
                                    ),
                                  );
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  backgroundColor: const Color.fromARGB(
                                    255,
                                    0,
                                    175,
                                    17,
                                  ),
                                  content: Text(
                                    "Produit ajoutée avec succès",
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.purple,
                              foregroundColor: Colors.white,
                            ),
                            child: const Text("Ajouter au panier"),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 8,
                left: 8,
                child: IconButton(
                  onPressed: () => context.pop(),
                  icon: const Icon(Icons.arrow_back, color: Colors.black),
                ),
              ),
              Positioned(
                top: 8,
                right: 8,
                child: IconButton(
                  onPressed: () {
                    if (game != null) {
                      ref
                          .read(favoritesControllerProvider.notifier)
                          .toggleFavorite(game!);
                    }
                  },
                  icon: Icon(
                    isFavorite ? Icons.favorite : Icons.favorite_border,
                    color: isFavorite ? Colors.red : Colors.black,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

