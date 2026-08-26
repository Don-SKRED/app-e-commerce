import 'package:app_e_commerce/features/products/domain/product_model.dart';
import 'package:app_e_commerce/shared/utils/responsive.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class CardProduct extends StatelessWidget {
  final Product product;
  // final String title;
  // final String subtitle;
  // final String price;
  // final String imageUrl;
  final VoidCallback onTap;

  const CardProduct({
    super.key,
    required this.product,
    // required this.title,
    // required this.subtitle,
    // required this.price,
    // required this.imageUrl,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    // final displayTitle = title ?? product?.name ?? "Batman Arkham Knight";
    // final displayPrice =
    //     price ?? (product != null ? "${product!.price} €" : "59.99 €");
    // final displayImage = imageUrl ?? product?.image;
    // final displaySubtitle = subtitle ?? "Jeu vidéo";

    // final hasValidImage = displayImage != null &&
    //     displayImage.isNotEmpty &&
    //     !displayImage.contains("TODO");

    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(context.radius),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(12),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(context.radius),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(context.radius),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Zone Image (Prend l'espace restant en haut de la grille)
              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.purple.shade50,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(context.radius),
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(context.radius),
                    ),
                    child:
                        //  hasValidImage
                        //     ? Image.network(
                        //         displayImage,
                        //         fit: BoxFit.cover,
                        //         errorBuilder: (context, error, stackTrace) =>
                        //             _buildPlaceholderIcon(),
                        //       )
                        //     : _buildPlaceholderIcon(),
                        CachedNetworkImage(
                          imageUrl: product.image,
                          fit: BoxFit.cover,
                          placeholder: (context, url) => Container(
                            color: Colors.red,
                            child: const Center(
                              child: SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          errorWidget: (context, url, error) =>
                              _buildPlaceholderIcon(),
                        ),
                  ),
                ),
              ),

              // Zone d'informations produit en bas
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      product.name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: context.bodyFontSize,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      product.stock.toString(),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: context.bodyFontSize - 2,
                        color: Colors.grey.shade600,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      product.price.toString(),
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: context.bodyFontSize,
                        color: Colors.purple,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPlaceholderIcon() {
    return Center(
      child: Icon(
        Icons.sports_esports,
        size: 48,
        color: Colors.purple.shade300,
      ),
    );
  }
}
