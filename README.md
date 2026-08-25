# 🛍️ App E-Commerce - Flutter

Une application mobile E-Commerce moderne développée avec **Flutter**, suivant les meilleures pratiques d'architecture (**Feature-First / Clean Architecture**) et utilisant **Riverpod** pour la gestion d'état réactive.

---

## 📸 Aperçu & Captures d'écran

| Page de Connexion | Page d'Inscription |
| :---: | :---: |
| ![Page de Connexion](screenshots/page_de_connexion.png) | ![Page d'Inscription](screenshots/page_d_inscription.png) |

---

## ✨ Fonctionnalités

- **Authentification & Gestion des Utilisateurs** :
  - **Connexion (`LoginScreen`)** : Validation en temps réel de l'email et du mot de passe avec gestion des erreurs et messages de confirmation (SnackBar).
  - **Inscription (`SignupScreen`)** : Formulaire complet avec validation de correspondance des mots de passe.
- **Gestion d'État Réactive** : Intégration complète avec `flutter_riverpod` et `riverpod_generator` pour un état d'authentification robuste et asynchrone (`AsyncValue`).
- **Navigation Déclarative** : Routage fluide avec `go_router` (`/login`, `/signup`).
- **Design Adaptatif / Responsive** : Layout adapté aux différentes tailles d'écran via des utilitaires de dimensionnement réutilisables.
- **Persistance & Données Mockées** : Chargement et gestion des données d'utilisateurs à partir de fichiers JSON locaux (`assets/data/users.json`).
- **Gestion Propre des Exceptions** : Exceptions personnalisées (`UserAlreadyExistsException`, `InvalidCredentialsException`) gérées au niveau de la présentation.

---

## 🏗️ Architecture du Projet

Le projet suit une **architecture basée sur les fonctionnalités (Feature-First)** couplée aux principes de la **Clean Architecture** :

```text
lib/
├── exceptions/             # Exceptions globales de l'application
├── features/
│   └── auth/               # Module d'authentification
│       ├── application/    # Services d'application / Use cases
│       ├── data/           # Repositories & Sources de données (JSON / API)
│       │   └── repositories/
│       │       └── auth_data_repository.dart
│       ├── domain/         # Modèles métier et entités
│       │   └── models/
│       │       └── user_model.dart
│       ├── exceptions/     # Exceptions spécifiques au module Auth
│       └── presentation/   # Interface utilisateur & Contrôleurs d'état
│           ├── controllers/
│           │   └── auth_contoller.dart
│           ├── screens/
│           │   ├── login_screen.dart
│           │   └── signup_screen.dart
│           └── widget/
│               └── custom_textfield.dart
├── routing/                # Configuration des routes (GoRouter)
│   └── routes.dart
└── shared/                 # Utilitaires, constantes et services partagés
    ├── constants/
    ├── services/
    └── utils/
        └── responsive.dart
```

---

## 🛠️ Technologies & Packages Utilisés

- **[Flutter](https://flutter.dev/)** - Framework UI multiplateforme
- **[Flutter Riverpod](https://riverpod.dev/)** (`^3.3.2`) - Gestion d'état et injection de dépendances
- **[GoRouter](https://pub.dev/packages/go_router)** (`^17.5.0`) - Routage déclaratif officiel
- **[Cached Network Image](https://pub.dev/packages/cached_network_image)** (`^3.4.1`) - Chargement et mise en cache des images
- **[HTTP](https://pub.dev/packages/http)** (`^1.6.0`) - Requêtes HTTP pour la communication API
- **[Path Provider](https://pub.dev/packages/path_provider)** (`^2.1.6`) - Accès au système de fichiers local

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
