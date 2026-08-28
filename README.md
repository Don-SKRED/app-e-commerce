# 🛍️ App E-Commerce - Flutter

Une application mobile & web E-Commerce moderne développée avec **Flutter**, suivant les meilleures pratiques d'architecture (**Feature-First / Clean Architecture**) et utilisant **Riverpod** pour la gestion d'état réactive.

---

## 📸 Aperçu & Captures d'écran

| Page de Connexion | Page d'Inscription | Page d'Accueil | Page Profil |
| :---: | :---: | :---: | :---: |
| ![Connexion](screenshots/page_de_connexion.png) | ![Inscription](screenshots/page_d_inscription.png) | ![Accueil](screenshots/page_home.png) | ![Profil](screenshots/page_profile.png) |

| Détails Jeu | Détails Console | Panier d'Achat | Historique Commandes |
| :---: | :---: | :---: | :---: |
| ![Détails Jeu](screenshots/page_info_jeux.png) | ![Détails Console](screenshots/page_info_console.png) | ![Panier](screenshots/page_panier.png) | ![Commandes](screenshots/page_commande.png) |

---

## ✨ Fonctionnalités

### 🔐 Authentification & Gestion des Utilisateurs
- **Connexion (`LoginScreen`)** : Validation en temps réel de l'email et du mot de passe avec gestion des erreurs et messages de confirmation (SnackBar).
- **Inscription (`SignupScreen`)** : Formulaire complet avec validation de correspondance des mots de passe.
- **Gestion de Session** : Suivi du statut utilisateur réactif via `authControllerProvider`.

### 🎮 Catalogue de Produits (Jeux & Consoles)
- **Modélisation Polymorphe** : Modèle de base `Product` étendu par les sous-classes métier `Game` et `Console`.
- **Pages de Détails** : `SpecificGameScreen` et `SpecificConsoleScreen` avec sélection dynamique de la quantité et ajout direct au panier.
- **Cartes Produit Responsive** : Composant `CardProduct` optimisé avec affichage des prix, images et cartes adaptatives.

### 🔍 Tri & Filtrage Avancés (`sort_services.dart` & `filter_services.dart`)
- **Recherche en Temps Réel** : Barre de recherche intuitive permettant de filtrer les produits par nom à la volée.
- **Tri Dynamique** : Menu déroulant (PopupMenu) permettant de trier la liste par :
  - Nom (croissant `A-Z` et décroissant `Z-A`)
  - Prix (croissant `min -> max` et décroissant `max -> min`)
- **Combinaison Filtre + Tri** : Application croisée et fluide du filtrage puis du tri avant le rendu de la grille.

### 🛒 Panier d'Achat & Passation de Commandes
- **Gestion du Panier (`shopping_cart`)** : Ajout d'articles, modification interactive des quantités, suppression et calcul dynamique du total.
- **Gestion des Commandes (`order`)** : Historique et suivi des commandes passées avec gestion des articles commandés (`OrderModel`, `OrderItemModel`).

### 👤 Profil & Personnalisation
- **Gestion du Profil (`ProfileScreen`)** : Affichage des informations de l'utilisateur connecté avec une interface totalement responsive.
- **Thème Sombre / Clair (`ThemeProvider`)** : Prise en charge dynamique du changement de thème de l'application.
- **Page À Propos (`AboutScreen`)** : Informations sur l'application et l'équipe.

### 📱 Design Responsive & Adaptatif
- **Grille Adaptative** : Calcul automatique et dynamique du nombre de colonnes selon le type d'appareil (2 colonnes sur Mobile, 3 sur Tablette, 5 sur Desktop).
- **Navigation Multiplateforme** : Barre de navigation réactive (`NavBarWidget`) s'adaptant à toutes les tailles d'écran.

---

## 🏗️ Architecture du Projet

Le projet suit une **architecture basée sur les fonctionnalités (Feature-First)** couplée aux principes de la **Clean Architecture** :

```text
lib/
├── exceptions/             # Exceptions globales de l'application
├── features/
│   ├── auth/               # Module d'authentification (Login, Signup, User)
│   ├── Console/            # Module des Consoles (Modèles, Repositories, Écrans)
│   ├── games/              # Module des Jeux vidéo (Modèles, Repositories, Écrans)
│   ├── order/              # Module de gestion des commandes et historique
│   ├── products/           # Module transverse des produits
│   │   ├── application/    # Services de tri (sort_services) et filtrage (filter_services)
│   │   ├── domain/         # Modèle abstrait Product
│   │   └── presentation/   # Widgets réutilisables (CardProduct)
│   ├── profile/            # Module de profil utilisateur & page À Propos
│   └── shopping_cart/      # Module du panier d'achat et contrôleurs Riverpod
├── routing/                # Configuration centralisée des routes (GoRouter)
├── shared/                 # Composants et services partagés
│   ├── constants/          # Constantes de l'application
│   ├── models/             # Modèles d'utilisateurs partagés
│   ├── screens/            # Écran d'accueil principal (Home)
│   ├── services/           # Repository générique JSON et ThemeProvider
│   ├── utils/              # Utilitaires de réactivité (responsive.dart)
│   └── widgets/            # Navbar et widgets partagés
└── main.dart               # Point d'entrée de l'application
```

---

## 🛠️ Technologies & Packages Utilisés

- **[Flutter](https://flutter.dev/)** - Framework UI multiplateforme
- **[Flutter Riverpod](https://riverpod.dev/)** (`^3.3.2`) - Gestion d'état et injection de dépendances
- **[GoRouter](https://pub.dev/packages/go_router)** (`^17.5.0`) - Routage déclaratif officiel
- **[Cached Network Image](https://pub.dev/packages/cached_network_image)** (`^3.4.1`) - Chargement et mise en cache des images
- **[HTTP](https://pub.dev/packages/http)** (`^1.6.0`) - Requêtes HTTP pour la communication API
- **[Path Provider](https://pub.dev/packages/path_provider)** (`^2.1.6`) - Accès au système de fichiers local pour la persistance JSON

---

## 🚀 Installation et Lancement

### Prérequis

Assurez-vous d'avoir installé sur votre machine :
- [Flutter SDK](https://docs.flutter.dev/get-started/install) (version `>= 3.10.8`)
- [Dart SDK](https://dart.dev/get-dart)
- Android Studio / VS Code avec le plugin Flutter

### Étapes d'installation

1. **Cloner le dépôt** :
   ```bash
   git clone https://github.com/Don-SKRED/app-e-commerce.git
   cd app_e_commerce
   ```

2. **Installer les dépendances** :
   ```bash
   flutter pub get
   ```

3. **Générer les fichiers de code (Riverpod generator)** :
   ```bash
   dart run build_runner build --delete-conflicting-outputs
   ```

4. **Lancer l'application** :
   ```bash
   flutter run
   ```

---

## 📝 Licence

Ce projet est sous licence libre.
