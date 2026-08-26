import 'package:app_e_commerce/features/Console/domain/models/console_model.dart';
import 'package:app_e_commerce/shared/utils/responsive.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SpecificConsoleScreen extends StatelessWidget {
  final Console? console;

  const SpecificConsoleScreen({super.key, this.console});

  @override
  Widget build(BuildContext context) {
    final displayTitle = console?.name ?? "Nom console";
    final displayMarque = console?.marque ?? "Marque";
    final displayStorage = console != null ? "${console!.storageCapacity.toInt()} Go" : "0 Go";
    final displayPrice = console != null ? "${console!.price} €" : "0.00 €";
    final displayStock = console != null ? "${console!.stock}" : "0";
    final displayDescription = console?.description ?? "Aucune description disponible";
    final displayImage = console?.image;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Stack(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: context.padding),
                child: Center(
                  child: Container(
                    width: context.containerGameWidth,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      spacing: context.spacing,
                      children: [
                        Container(
                          height: context.heightContainerConsole,
                          width: MediaQuery.sizeOf(context).width,
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Color.fromARGB(255, 233, 233, 233),
                                Color.fromARGB(255, 223, 218, 218),
                              ],
                            ),
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(200),
                              bottomRight: Radius.circular(200),
                            ),
                          ),
                          child: Center(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Container(
                                height: context.consoleImageSize,
                                width: context.consoleImageSize,
                                color: Colors.grey.shade300,
                                child: displayImage != null && displayImage.isNotEmpty
                                    ? CachedNetworkImage(
                                        imageUrl: displayImage,
                                        fit: BoxFit.cover,
                                        placeholder: (context, url) => const Center(
                                          child: CircularProgressIndicator(),
                                        ),
                                        errorWidget: (context, url, error) => const Icon(
                                          Icons.sports_esports,
                                          size: 50,
                                          color: Colors.grey,
                                        ),
                                      )
                                    : const Icon(
                                        Icons.sports_esports,
                                        size: 50,
                                        color: Colors.grey,
                                      ),
                              ),
                            ),
                          ),
                        ),
                        Center(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Text(
                                      displayTitle,
                                      style: TextStyle(
                                        fontSize: context.textTitleSize,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    "$displayMarque • $displayStorage",
                                    style: TextStyle(
                                      fontSize: context.bodyFontSize,
                                      color: Colors.grey.shade700,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 12),
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
                                    style: TextStyle(
                                      fontSize: context.bodyFontSize,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 16),
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
                              const SizedBox(height: 20),
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
