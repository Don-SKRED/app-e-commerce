import 'package:app_e_commerce/features/Console/domain/models/console_model.dart';
import 'package:app_e_commerce/features/favorites/presentation/controllers/favorites_controller.dart';
import 'package:app_e_commerce/features/games/domain/model/game_model.dart';
import 'package:app_e_commerce/features/products/presentation/widgets/card_product.dart';
import 'package:app_e_commerce/shared/utils/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class FavoritesScreen extends ConsumerWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favorites = ref.watch(favoritesControllerProvider);

    final crossAxisCount = context.isDesktop
        ? 5
        : context.isTablet
            ? 3
            : 2;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Mes Favoris",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          if (favorites.isNotEmpty)
            IconButton(
              icon: const Icon(Icons.delete_outline),
              tooltip: "Effacer les favoris",
              onPressed: () {
                ref.read(favoritesControllerProvider.notifier).clearFavorites();
              },
            ),
        ],
      ),
      body: favorites.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.favorite_border,
                    size: 80,
                    color: Colors.grey.shade400,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    "Aucun favori enregistré :(",
                    style: TextStyle(
                      fontSize: context.textTitleSize,
                      color: Colors.grey,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            )
          : Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 1200),
                child: Padding(
                  padding: EdgeInsets.all(context.padding),
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: crossAxisCount,
                      crossAxisSpacing: context.spacing,
                      mainAxisSpacing: context.spacing,
                      childAspectRatio: 0.72,
                    ),
                    itemCount: favorites.length,
                    itemBuilder: (context, index) {
                      final product = favorites[index];
                      return CardProduct(
                        product: product,
                        onTap: () {
                          if (product is Game) {
                            context.push(
                              '/specificGame',
                              extra: product,
                            );
                          } else if (product is Console) {
                            context.push(
                              '/specificonsole',
                              extra: product,
                            );
                          }
                        },
                      );
                    },
                  ),
                ),
              ),
            ),
    );
  }
}
