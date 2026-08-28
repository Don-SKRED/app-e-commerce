import 'package:app_e_commerce/features/favorites/presentation/controllers/favorites_controller.dart';
import 'package:app_e_commerce/features/favorites/presentation/screens/favorites_screen.dart';
import 'package:app_e_commerce/features/order/presentation/screens/order_screen.dart';
import 'package:app_e_commerce/features/profile/presentation/screens/profile_screen.dart';
import 'package:app_e_commerce/features/shopping_cart/presentation/controllers/shopping_cart_controller.dart';
import 'package:app_e_commerce/features/shopping_cart/presentation/screens/shopping_cart_screen.dart';
import 'package:app_e_commerce/shared/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NavigationBarWidget extends ConsumerStatefulWidget {
  const NavigationBarWidget({super.key});

  @override
  ConsumerState<NavigationBarWidget> createState() =>
      _NavigationBarWidgetState();
}

class _NavigationBarWidgetState extends ConsumerState<NavigationBarWidget> {
  int _id = 0;

  @override
  Widget build(BuildContext context) {
    final cart = ref.watch(shoppingCartControllerProvider);
    final favorites = ref.watch(favoritesControllerProvider);

    final tabs = [
      const Home(),
      const FavoritesScreen(),
      const ShoppingCartScreen(),
      const OrderScreen(),
      const ProfileScreen(),
    ];

    List<BottomNavigationBarItem> items = [];
    items.add(
      const BottomNavigationBarItem(
        icon: Icon(Icons.home, size: 28),
        label: 'Accueil',
      ),
    );

    items.add(
      BottomNavigationBarItem(
        icon: Badge(
          isLabelVisible: favorites.isNotEmpty,
          label: Text(favorites.length.toString()),
          child: const Icon(Icons.favorite, size: 26),
        ),
        label: 'Favoris',
      ),
    );

    items.add(
      BottomNavigationBarItem(
        icon: Badge(
          isLabelVisible: cart.isNotEmpty,
          label: Text(cart.length.toString()),
          child: const Icon(Icons.shopping_cart, size: 26),
        ),
        label: 'Panier',
      ),
    );

    items.add(
      const BottomNavigationBarItem(
        icon: Icon(Icons.list_alt_sharp, size: 28),
        label: 'Commandes',
      ),
    );

    items.add(
      const BottomNavigationBarItem(
        icon: Icon(Icons.person, size: 28),
        label: 'Profil',
      ),
    );

    return Scaffold(
      body: tabs[_id],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        elevation: 4,
        showSelectedLabels: true,
        items: items,
        currentIndex: _id,
        selectedItemColor: const Color.fromARGB(255, 142, 59, 198),
        unselectedItemColor: const Color.fromARGB(255, 194, 191, 191),
        showUnselectedLabels: true,
        onTap: (int item) {
          setState(() => _id = item);
        },
      ),
    );
  }
}

