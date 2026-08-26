import 'package:app_e_commerce/features/games/domain/model/game_model.dart';
import 'package:app_e_commerce/shared/utils/responsive.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SpecificGameScreen extends StatelessWidget {
  final Game? game;

  const SpecificGameScreen({super.key, this.game});

  @override
  Widget build(BuildContext context) {
    final displayTitle = game?.name ?? "Nom du jeu";
    final displayPlatforms = game != null ? game!.platform.join(", ") : "Non spécifiée";
    final displayPrice = game != null ? "${game!.price} €" : "0.00 €";
    final displayStock = game != null ? "${game!.stock}" : "0";
    final displayDescription = game?.description ?? "Aucune description disponible";
    final displayImage = game?.image;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Stack(
            children: [
              Padding(
                padding: EdgeInsets.all(context.padding),
                child: Center(
                  child: Container(
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
                              child: displayImage != null && displayImage.isNotEmpty
                                  ? CachedNetworkImage(
                                      imageUrl: displayImage,
                                      fit: BoxFit.cover,
                                      placeholder: (context, url) => const Center(
                                        child: CircularProgressIndicator(),
                                      ),
                                      errorWidget: (context, url, error) => const Icon(
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
                        Text(
                          "Plateformes : $displayPlatforms",
                          style: TextStyle(fontSize: context.bodyFontSize),
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
                              style: TextStyle(
                                fontSize: context.bodyFontSize,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: MediaQuery.sizeOf(context).width,
                          height: context.buttonHeight,
                          child: ElevatedButton(
                            onPressed: () {},
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
            ],
          ),
        ),
      ),
    );
  }
}
