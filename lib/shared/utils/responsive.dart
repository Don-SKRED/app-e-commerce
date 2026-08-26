import 'package:flutter/material.dart';

class Responsive {
  static bool isMobile(BuildContext context) {
    return MediaQuery.sizeOf(context).width < 600;
  }

  static bool isTablet(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    return width >= 600 && width < 1200;
  }

  static bool isDesktop(BuildContext context) {
    return MediaQuery.sizeOf(context).width >= 1200;
  }

  static double size(BuildContext context) {
    return MediaQuery.sizeOf(context).width;
  }

  // --- Helpers adaptatifs ---

  /// Hauteur des boutons principaux
  static double buttonHeight(BuildContext context) {
    if (isDesktop(context)) return 58;
    if (isTablet(context)) return 54;
    return 48;
  }

  /// Taille de police pour les titres de page
  static double titleFontSize(BuildContext context) {
    if (isDesktop(context)) return 30;
    if (isTablet(context)) return 26;
    return 22;
  }

  /// Taille de police pour les labels et textes courants
  static double bodyFontSize(BuildContext context) {
    if (isDesktop(context)) return 18;
    if (isTablet(context)) return 16;
    return 14;
  }

  /// Espacement vertical entre les éléments principaux du Column
  static double spacing(BuildContext context) {
    if (isDesktop(context)) return 36;
    if (isTablet(context)) return 28;
    return 20;
  }

  /// Espacement horizontal entre les éléments principaux du row
  static double spacingRow(BuildContext context) {
    if (isDesktop(context)) return 66;
    if (isTablet(context)) return 58;
    return 50;
  }

  /// Espacement entre le label et le champ de saisie
  static double fieldSpacing(BuildContext context) {
    if (isDesktop(context)) return 8;
    if (isTablet(context)) return 7;
    return 5;
  }

  /// Padding horizontal/vertical de l'écran
  static double padding(BuildContext context) {
    if (isDesktop(context)) return 48;
    if (isTablet(context)) return 32;
    return 16;
  }

  /// Rayon de bordure des champs de saisie
  static double radius(BuildContext context) {
    if (isDesktop(context)) return 14;
    if (isTablet(context)) return 12;
    return 10;
  }

  /// Largeur du formulaire (centré sur tablet/desktop)
  static double formWidth(BuildContext context) {
    if (isDesktop(context)) return 600;
    if (isTablet(context)) return 520;
    return MediaQuery.sizeOf(context).width;
  }

  static double containerGameWidth(BuildContext context) {
    if (isDesktop(context)) return 800;
    if (isTablet(context)) return 600;
    return MediaQuery.sizeOf(context).width;
  }

  static double imageGameWidth(BuildContext context) {
    if (isDesktop(context)) return 350;
    if (isTablet(context)) return 300;
    return 250;
  }

  static double consoleImageSize(BuildContext context) {
    if (isDesktop(context)) return 300;
    if (isTablet(context)) return 250;
    return 200;
  }

  static double heightContainerConsole(BuildContext context) {
    if (isDesktop(context)) return 380;
    if (isTablet(context)) return 340;
    return 300;
  }

  static double textTitleSize(BuildContext context) {
    if (isDesktop(context)) return 25;
    if (isTablet(context)) return 22;
    return 19;
  }
}

extension ResponsiveExtension on BuildContext {
  bool get isMobile => Responsive.isMobile(this);
  bool get isTablet => Responsive.isTablet(this);
  bool get isDesktop => Responsive.isDesktop(this);
  double get screenWidth => MediaQuery.sizeOf(this).width;
  double get screenHeight => MediaQuery.sizeOf(this).height;

  // Raccourcis des helpers
  double get buttonHeight => Responsive.buttonHeight(this);
  double get titleFontSize => Responsive.titleFontSize(this);
  double get bodyFontSize => Responsive.bodyFontSize(this);
  double get spacing => Responsive.spacing(this);
  double get spacingRow => Responsive.spacingRow(this);
  double get fieldSpacing => Responsive.fieldSpacing(this);
  double get padding => Responsive.padding(this);
  double get radius => Responsive.radius(this);
  double get formWidth => Responsive.formWidth(this);
  double get imageGameWidth => Responsive.imageGameWidth(this);
  double get textTitleSize => Responsive.textTitleSize(this);
  double get containerGameWidth => Responsive.containerGameWidth(this);
  double get consoleImageSize => Responsive.consoleImageSize(this);
  double get heightContainerConsole => Responsive.heightContainerConsole(this);
}
