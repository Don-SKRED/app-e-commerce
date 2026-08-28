# 🛍️ App E-Commerce - Flutter

[![Flutter CI/CD](https://github.com/Don-SKRED/app-e-commerce/actions/workflows/flutter_ci.yml/badge.svg)](https://github.com/Don-SKRED/app-e-commerce/actions)
[![Flutter Version](https://img.shields.io/badge/Flutter-3.x-02569B?logo=flutter)](https://flutter.dev)
[![Riverpod](https://img.shields.io/badge/State%20Management-Riverpod%203.x-blueviolet)](https://riverpod.dev)
[![License](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)

Une application mobile & web E-Commerce moderne développée avec **Flutter**, suivant scrupuleusement les principes de la **Clean Architecture** couplée à une organisation **Feature-First**. L'application exploite **Riverpod** pour une gestion d'état réactive, déclarative et asynchrone sans compromis.

---

## 📸 Aperçu & Galerie de Captures d'écran

| Page de Connexion | Page d'Inscription | Page d'Accueil | Page Profil |
| :---: | :---: | :---: | :---: |
| ![Connexion](screenshots/page_de_connexion.png) | ![Inscription](screenshots/page_d_inscription.png) | ![Accueil](screenshots/page_home.png) | ![Profil](screenshots/page_profile.png) |

| Détails Jeu | Détails Console | Panier d'Achat | Historique Commandes |
| :---: | :---: | :---: | :---: |
| ![Détails Jeu](screenshots/page_info_jeux.png) | ![Détails Console](screenshots/page_info_console.png) | ![Panier](screenshots/page_panier.png) | ![Commandes](screenshots/page_commande.png) |

---

## 🌟 Fonctionnalités Détaillées

### 🔐 1. Authentification & Gestion des Utilisateurs (`features/auth`)
- **Connexion Sécurisée (`LoginScreen`)** : Validation des champs en temps réel (Email, Mot de passe) avec interception des erreurs et affichage de SnackBars contextuelles.
- **Inscription (`SignupScreen`)** : Formulaire complet avec contrôle de conformité et validation de confirmation de mot de passe.
- **Gestion de Session Réactive** : Utilisation d'un `AsyncNotifier` (`authControllerProvider`) avec persistance du token JWT et transition fluide entre les états connecté / déconnecté.

### 🎮 2. Catalogue de Produits Polymorphe (`features/games`, `features/Console`, `features/products`)
- **Modélisation Objet** : Modèle de base abstrait `Product` étendu par les entités métiers `Game` (plateformes, éditeur, type) et `Console` (marque, capacité de stockage, manettes).
- **Pages de Détails** : `SpecificGameScreen` et `SpecificConsoleScreen` avec sélection de quantité interactive contrôlée par un service dédié (`quantityServiceProvider`) respectant le stock maximal.
- **Composant Réutilisable `CardProduct`** : Carte produit adaptative avec gestion des prix, badges visuels, images en cache et favori interactif en superposition.

### 🔍 3. Moteur de Recherche & Tri Réactif (`features/products/application`)
- **Recherche Instantanée** : Filtrage insensible à la casse sur l'ensemble du catalogue via `productSearchProvider`.
- **Système de Tri Dynamique** : Tri à la volée par :
  - Nom (Ordre alphabétique croissant `A-Z` et décroissant `Z-A`)
  - Prix (Croissant `min -> max` et Décroissant `max -> min`)
- **Providers Combinés** : `filteredSortedGamesProvider` et `filteredSortedConsolesProvider` fusionnent de manière réactive le flux de données asynchrone, la requête de recherche et l'option de tri.

### ❤️ 4. Système de Favoris & Persistance Résiliente (`features/favorites`)
- **Gestion Temps Réel** : Ajout et retrait instantanés avec mise à jour automatique des icônes de cœur dans toute l'application et sur le badge de la barre de navigation.
- **Persistance Locale JSON (`favorites.json`)** : Sauvegarde locale automatique via `FavoritesRepository`.
- **Rollback Transactionnel** : En cas d'erreur I/O lors de la sauvegarde sur disque, l'état mémoire est automatiquement restauré pour garantir une cohérence stricte avec le système de fichiers.

### 🛒 5. Panier d'Achat & Passation de Commandes (`features/shopping_cart`, `features/order`)
- **Panier Interactif** : Incrémentation, décrémentation, suppression d'articles et calcul automatique du total par un service applicatif pur (`calculateTotal`).
- **Historique des Commandes** : Enregistrement et consultation des commandes passées avec détail des articles, prix unitaires, totaux et horodatage formaté.

### 🌓 6. Thème Dynamique & Responsive Design
- **Thème Sombre / Clair** : `themeControllerProvider` permettant le basculement dynamique entre le mode clair, sombre et système.
- **Interface Multi-Écrans** : Calcul dynamique du layout (2 colonnes Mobile, 3 colonnes Tablette, 5 colonnes Desktop).

---

## 🏛️ Architecture du Projet : Clean Architecture & Feature-First

Le projet est structuré selon une séparation stricte des responsabilités en couches concentriques, garantissant l'indépendance de la logique métier vis-à-vis des frameworks et de l'UI.

```
                    ┌──────────────────────────────┐
                    │      PRESENTATION LAYER      │
                    │   (Widgets, Screens, Views)  │
                    └──────────────┬───────────────┘
                                   │ dépend de
                                   ▼
                    ┌──────────────────────────────┐
                    │      APPLICATION LAYER       │
                    │  (Services Métier, Providers)│
                    └──────────────┬───────────────┘
                                   │ dépend de
                                   ▼
                    ┌──────────────────────────────┐
                    │          DATA LAYER          │
                    │    (Repositories, JSON/IO)   │
                    └──────────────┬───────────────┘
                                   │ dépend de
                                   ▼
                    ┌──────────────────────────────┐
                    │         DOMAIN LAYER         │
                    │   (Modèles Purs & Entités)   │
                    └──────────────────────────────┘
```

### 📁 Rôle de Chaque Couche

| Couche | Rôle & Contenu | Ce qu'elle NE contient PAS |
| :--- | :--- | :--- |
| **`domain/`** | Modèles purs (`Product`, `Game`, `Console`, `Order`, `User`), structures de données. | Aucun widget Flutter, aucun provider Riverpod, aucun accès I/O. |
| **`data/`** | Repositories purs (`GameDataRepository`, `FavoritesRepository`, `AuthDataRepository`). Lecture/écriture JSON, gestion fichiers. | Pas de logique UI, pas de déclaration de Providers Riverpod. |
| **`application/`** | Services métier (`AuthService`, `FavoritesService`, `QuantityService`, `calculateTotal`), Providers Riverpod d'orchestration. | Aucun widget visuel, aucun élément de rendu UI. |
| **`presentation/`** | Screens (`Home`, `LoginScreen`, `FavoritesScreen`), Widgets (`CardProduct`), Contrôleurs d'état UI (`Notifier`, `AsyncNotifier`). | Pas d'accès direct au système de fichiers ni de requêtes I/O directes. |

### 📂 Arborescence Complète des Fichiers

```text
lib/
├── exceptions/                         # Exceptions métier typées
│   └── storage_exception.dart          # Exception dédiée au stockage local
├── features/
│   ├── auth/                           # Authentification & Utilisateur
│   │   ├── application/
│   │   │   └── auth_service.dart       # AuthService & authServiceProvider
│   │   ├── data/
│   │   │   └── repositories/
│   │   │       └── auth_data_repository.dart # Accès brut aux données users
│   │   ├── exceptions/
│   │   │   └── auth_exception.dart     # AuthException
│   │   └── presentation/
│   │       ├── controllers/
│   │       │   └── auth_contoller.dart # AuthController (AsyncNotifier)
│   │       ├── screens/                # LoginScreen & SignupScreen
│   │       └── widget/                 # CustomTextField
│   ├── Console/                        # Module Consoles
│   │   ├── application/
│   │   │   └── console_service.dart    # consoleDataRepositoryProvider & consolesListProvider
│   │   ├── data/repositories/
│   │   │   └── console_data.dart       # ConsoleDataRepository
│   │   ├── domain/models/
│   │   │   └── console_model.dart      # Modèle Console
│   │   └── presentation/screens/
│   │       └── specific_console_screen.dart
│   ├── favorites/                      # Module Favoris
│   │   ├── application/
│   │   │   └── favorites_service.dart  # FavoritesService & favoritesServiceProvider
│   │   ├── data/repositories/
│   │   │   └── favorites_repository.dart # Persistance locale JSON
│   │   └── presentation/
│   │       ├── controllers/
│   │       │   └── favorites_controller.dart # FavoritesController avec rollback
│   │       └── screens/
│   │           └── favorites_screen.dart
│   ├── games/                          # Module Jeux Vidéo
│   │   ├── application/
│   │   │   ├── game_service.dart       # gamesListProvider & repository provider
│   │   │   └── quantity_service.dart   # QuantityService (règles stock min/max)
│   │   ├── data/repositories/
│   │   │   └── game_data.dart          # GameDataRepository
│   │   ├── domain/model/
│   │   │   └── game_model.dart         # Modèle Game
│   │   └── presentation/screens/
│   │       └── specific_game_screen.dart
│   ├── order/                          # Module Commandes
│   │   ├── application/
│   │   │   └── order_service.dart      # OrderService & orderServiceProvider
│   │   ├── data/repositories/
│   │   │   ├── order_repository.dart
│   │   │   └── order_item_repository.dart
│   │   ├── domain/models/
│   │   │   ├── order_model.dart
│   │   │   └── order_item_model.dart
│   │   └── presentation/
│   │       ├── controllers/
│   │       │   ├── order_controller.dart
│   │       │   └── order_item_controller.dart
│   │       └── screens/
│   │           └── order_screen.dart
│   ├── products/                       # Module Transverse Produits
│   │   ├── application/
│   │   │   ├── product_providers.dart  # SearchProvider, SortProvider & Combined Providers
│   │   │   └── services/
│   │   │       ├── filter_services.dart # Algorithme de filtrage par nom
│   │   │       └── sort_services.dart   # Algorithmes de tri (Nom, Prix)
│   │   ├── domain/
│   │   │   └── product_model.dart      # Modèle abstrait Product
│   │   └── presentation/widgets/
│   │       └── card_product.dart       # Widget réutilisable CardProduct
│   ├── profile/                        # Module Profil & À Propos
│   │   └── presentation/screens/
│   │       ├── profile_screen.dart
│   │       └── about_screen.dart
│   └── shopping_cart/                  # Module Panier d'Achat
│       ├── application/
│       │   └── shopping_cart_service.dart # Logique métier (calculateTotal)
│       ├── domain/
│       │   └── shopping_cart_model.dart
│       └── presentation/
│           ├── controllers/
│           │   └── shopping_cart_controller.dart
│           └── screens/
│               └── shopping_cart_screen.dart
├── routing/
│   └── routes.dart                     # Configuration centralisée GoRouter
├── shared/
│   ├── constants/                      # Constantes de l'application
│   ├── models/                         # UserModel
│   ├── screens/                        # HomeScreen
│   ├── services/                       # Repository<T> générique et ThemeProvider
│   ├── utils/                          # Responsive et DateUtils
│   └── widgets/                        # NavigationBarWidget
└── main.dart                           # Point d'entrée de l'application
```

---

## ⚡ Inventaire Exhaustif des Providers Riverpod (18 Providers)

L'application utilise **18 providers distincts** assurant l'injection de dépendances, la gestion des états asynchrones et la réactivité :

| # | Nom du Provider | Type Riverpod | Couche | Rôle & Responsabilité |
| :---: | :--- | :--- | :--- | :--- |
| **1** | `authControllerProvider` | `AsyncNotifierProvider<AuthController, User?>` | Presentation | Gestion réactive de la session utilisateur, connexion, inscription et déconnexion. |
| **2** | `authServiceProvider` | `Provider<AuthService>` | Application | Service métier d'authentification orchestrant la logique métier et les règles de validation. |
| **3** | `authDataRepositoryProvider` | `Provider<AuthDataRepository>` | Application | Injection du repository d'accès aux données utilisateur. |
| **4** | `gamesListProvider` | `FutureProvider<List<Game>>` | Application | Chargement asynchrone réactif du catalogue des jeux vidéo. |
| **5** | `gameDataRepositoryProvider` | `Provider<GameDataRepository>` | Application | Injection du repository d'accès aux jeux. |
| **6** | `consolesListProvider` | `FutureProvider<List<Console>>` | Application | Chargement asynchrone réactif du catalogue des consoles. |
| **7** | `consoleDataRepositoryProvider` | `Provider<ConsoleDataRepository>` | Application | Injection du repository d'accès aux consoles. |
| **8** | `quantityServiceProvider` | `NotifierProvider.autoDispose<QuantityService, int>` | Application | Contrôleur éphémère gérant la quantité sélectionnée avec bornes minimales (1) et maximales (stock). |
| **9** | `productSearchProvider` | `NotifierProvider<ProductSearchController, String>` | Application | État réactif de la requête saisie dans la barre de recherche. |
| **10** | `productSortProvider` | `NotifierProvider<ProductSortController, String?>` | Application | État réactif de l'option de tri sélectionnée dans le menu déroulant. |
| **11** | `filteredSortedGamesProvider` | `Provider<AsyncValue<List<Game>>>` | Application | Provider calculé combinant le flux des jeux, la recherche en direct et le tri alphabétique/prix. |
| **12** | `filteredSortedConsolesProvider` | `Provider<AsyncValue<List<Console>>>` | Application | Provider calculé combinant le flux des consoles, la recherche en direct et le tri alphabétique/prix. |
| **13** | `favoritesControllerProvider` | `NotifierProvider<FavoritesController, List<Product>>` | Presentation | Gestion de la liste des favoris avec persistance locale et rollback automatique en cas d'erreur. |
| **14** | `favoritesServiceProvider` | `Provider<FavoritesService>` | Application | Service applicatif exposant les opérations de persistance des favoris. |
| **15** | `favoritesRepositoryProvider` | `Provider<FavoritesRepository>` | Application | Injection du repository de lecture/écriture du fichier `favorites.json`. |
| **16** | `shoppingCartControllerProvider` | `NotifierProvider<ShoppingCartController, List<ShoppingCartModel>>` | Presentation | Gestion réactive du panier d'achat (ajout, modification de quantité, suppression, vidage). |
| **17** | `orderControllerProvider` | `AsyncNotifierProvider<OrderController, List<Order>>` | Presentation | Gestion asynchrone de l'historique des commandes et passation de nouvelle commande. |
| **18** | `orderServiceProvider` | `Provider<OrderService>` | Application | Service applicatif orchestrant la lecture et la sauvegarde des commandes. |
| **19** | `orderRepositoryProvider` | `Provider<OrderRepository>` | Application | Injection du repository des commandes. |
| **20** | `orderItemRepositoryProvider` | `Provider<OrderItemRepository>` | Application | Injection du repository des éléments commandés. |
| **21** | `themeControllerProvider` | `NotifierProvider<ThemeController, ThemeMode>` | Application / Shared | Gestion globale du thème applicatif (Clair / Sombre / Système). |

---

## 🛡️ Gestion des Erreurs & États Asynchrones (`AsyncValue`)

### 1. Pattern Réactif `.when()`
Tous les écrans qui consomment des flux asynchrones utilisent explicitement le pattern `.when()` pour traiter rigoureusement les 3 états possibles :
```dart
final gamesAsync = ref.watch(filteredSortedGamesProvider);

return gamesAsync.when(
  data: (games) => GridView.builder(...),
  loading: () => const Center(child: CircularProgressIndicator()),
  error: (err, stack) => Center(child: Text("Erreur de chargement : $err")),
);
```

### 2. Sécurisation des Contrôleurs avec `AsyncValue.guard()`
Les mutations asynchrones sont encapsulées dans `AsyncValue.guard()`, ce qui capture automatiquement les exceptions et met à jour l'état sans interruption :
```dart
Future<void> login(String email, String password) async {
  state = const AsyncLoading();
  state = await AsyncValue.guard(() {
    return ref.read(authServiceProvider).login(email, password);
  });
}
```

### 3. Résilience & Rollback Transactionnel
Pour la persistance locale ([FavoritesController](file:///c:/dossier%20projects/flutter%20Projects/app_e_commerce/lib/features/favorites/presentation/controllers/favorites_controller.dart)), en cas d'erreur I/O sur le support de stockage, l'état mémoire est automatiquement annulé (`rollback`) afin de maintenir une cohérence parfaite entre l'UI et le disque :
```dart
Future<void> toggleFavorite(Product product) async {
  final previousState = state;
  // Modification optimiste de l'état
  state = exists ? state.where((item) => item.id != product.id).toList() : [...state, product];

  try {
    await _saveToLocal();
  } catch (e) {
    // Rollback automatique en cas d'erreur de sauvegarde
    state = previousState;
  }
}
```

### 4. Exceptions Typées
- `StorageException` : Identifie et journalise les erreurs de corruption JSON (`FormatException`) et d'écriture système (`FileSystemException`).
- `AuthException` : Messages clairs lors des échecs d'authentification ou des doublons de compte.

---

## 🧪 Suite Complète de Tests Automatisés (`test/`)

Le projet inclut une suite de tests unitaires et de widgets organisée selon la Clean Architecture :

```text
test/
├── unit/
│   ├── models/
│   │   ├── user_model_test.dart            # Désérialisation/Sérialisation User & token JWT
│   │   ├── game_model_test.dart            # Modèle polymorphe Game
│   │   ├── console_model_test.dart         # Modèle polymorphe Console
│   │   ├── order_model_test.dart           # Modèles Order & OrderItem
│   │   └── shopping_cart_model_test.dart   # Modèle ShoppingCart & copyWith
│   ├── application/
│   │   ├── auth_service_test.dart          # Validation login/signup et règles métier
│   │   ├── shopping_cart_service_test.dart # Calcul précis du total panier
│   │   ├── quantity_service_test.dart      # Incrémentation/Décrémentation/Bornes stock
│   │   └── sort_filter_service_test.dart   # Algorithmes de tri et filtrage recherche
│   ├── controllers/
│   │   ├── auth_controller_test.dart       # État réactif AuthController & logout
│   │   ├── favorites_controller_test.dart  # Ajout/Retrait/Rollback persistance
│   │   ├── shopping_cart_controller_test.dart # Ajout/Quantités/Suppression panier
│   │   ├── order_controller_test.dart      # Création et historique des commandes
│   │   └── theme_controller_test.dart      # Alternance des thèmes Clair / Sombre
│   └── exceptions/
│       ├── auth_exception_test.dart        # Messages et instanciation AuthException
│       └── storage_exception_test.dart     # Messages et causes StorageException
└── widgets/
    ├── card_product_test.dart              # Affichage produit, prix, bouton favori et tap
    ├── login_screen_test.dart              # Formulaire de connexion et validation
    ├── signup_screen_test.dart             # Formulaire d'inscription et validation
    ├── favorites_screen_test.dart          # Écran des favoris et état vide
    └── navbar_widget_test.dart             # Rendu des 5 onglets et badges temps réel
```

---

## 🚀 Intégration Continue (CI/CD GitHub Actions)

Le fichier `.github/workflows/flutter_ci.yml` automatise la validation de la qualité du code à chaque push et pull request :

1. **Installation de l'environnement** : SDK Flutter stable et JDK 17.
2. **Résolution des dépendances** : `flutter pub get`.
3. **Analyse Statique** : `flutter analyze` pour garantir 0 avertissement / 0 erreur de linter.
4. **Exécution des Tests** : `flutter test --coverage` pour valider l'intégralité de la suite de tests.

---

## 🛠️ Technologies & Packages Utilisés

- **[Flutter](https://flutter.dev/)** - Framework UI multiplateforme
- **[Flutter Riverpod](https://riverpod.dev/)** (`^3.3.2`) - Gestion d'état déclarative et réactive
- **[GoRouter](https://pub.dev/packages/go_router)** (`^17.5.0`) - Routage déclaratif officiel
- **[Cached Network Image](https://pub.dev/packages/cached_network_image)** (`^3.4.1`) - Chargement et mise en cache des images
- **[Path Provider](https://pub.dev/packages/path_provider)** (`^2.1.6`) - Accès au système de fichiers local pour la persistance JSON

---

## 💻 Installation et Lancement

### Prérequis
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

3. **Lancer l'analyse statique** :
   ```bash
   flutter analyze
   ```

4. **Lancer tous les tests automatisés** :
   ```bash
   flutter test
   ```

5. **Lancer l'application** :
   ```bash
   flutter run
   ```

---

## 📝 Licence

Ce projet est sous licence MIT.
