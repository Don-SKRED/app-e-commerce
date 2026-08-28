import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Contrôleur Riverpod pour la gestion de la quantité sélectionnée
/// sur les pages de détails produit.
///
/// Déplacé depuis [presentation/providers/] vers la couche [application/]
/// car il contient une logique métier (bornes min/max sur le stock)
/// qui ne dépend pas de l'affichage UI.
class QuantityService extends Notifier<int> {
  @override
  int build() {
    return 1; // état initial : quantité minimale
  }

  /// Incrémente la quantité sans dépasser le [stock] disponible.
  void increment(int stock) {
    if (state < stock) state = state + 1;
  }

  /// Décrémente la quantité sans descendre en-dessous de 1.
  void decrement() {
    if (state > 1) state = state - 1;
  }

  /// Réinitialise la quantité à 1 (ex: changement de produit).
  void reset() {
    state = 1;
  }
}

/// Provider auto-disposable : chaque page de détail produit obtient
/// sa propre instance de [QuantityService], détruite à la fermeture.
final quantityServiceProvider =
    NotifierProvider.autoDispose<QuantityService, int>(
  QuantityService.new,
);
