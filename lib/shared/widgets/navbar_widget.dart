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
  // late UserModel? userConnected;
  //listes des onglets tabs = onglet

  //widget de la barre de navigation
  int _id = 0;

  @override
  Widget build(BuildContext context) {
    final cart = ref.watch(shoppingCartControllerProvider);

    final tabs = [
      const Home(),
      const ShoppingCartScreen(),
      const OrderScreen(),
      const ProfileScreen(),
    ];

    List<BottomNavigationBarItem> items = [];
    items.add(
      const BottomNavigationBarItem(
        icon: Icon(Icons.home, size: 30),
        label: 'Accueil',
      ),
    );

    items.add(
      BottomNavigationBarItem(
        icon: Badge(
          isLabelVisible: cart.isNotEmpty,
          label: Text(cart.length.toString()),
          child: Icon(Icons.shopping_cart, size: 28),
        ),
        label: 'Panier',
      ),
    );

    items.add(
      const BottomNavigationBarItem(
        icon: Icon(Icons.list_alt_sharp, size: 30),
        label: 'Commandes',
      ),
    );
    items.add(
      const BottomNavigationBarItem(
        icon: Icon(Icons.person, size: 30),
        label: 'Profil',
      ),
    );

    return Scaffold(
      body: tabs[_id],
      bottomNavigationBar: BottomNavigationBar(
        // backgroundColor: Colors.grey ,
        elevation: 4,
        showSelectedLabels: true,
        items: items,
        currentIndex: _id,
        selectedItemColor: Color.fromARGB(255, 142, 59, 198),
        unselectedItemColor: const Color.fromARGB(255, 194, 191, 191),
        showUnselectedLabels: true,
        onTap: (int item) {
          setState(() => _id = item);
        },
      ),
    );
  }
}
