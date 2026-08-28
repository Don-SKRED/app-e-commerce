import 'package:app_e_commerce/features/Console/data/repositories/console_data.dart';
import 'package:app_e_commerce/features/auth/presentation/controllers/auth_contoller.dart';
import 'package:app_e_commerce/features/games/data/repositories/game_data.dart';
import 'package:app_e_commerce/features/products/application/services/filter_services.dart';
import 'package:app_e_commerce/features/products/application/services/sort_services.dart';
import 'package:app_e_commerce/features/products/domain/product_model.dart';
import 'package:app_e_commerce/shared/utils/responsive.dart';
import 'package:app_e_commerce/features/products/presentation/widgets/card_product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class Home extends ConsumerStatefulWidget {
  const Home({super.key});

  @override
  ConsumerState<Home> createState() => _HomeState();
}

class _HomeState extends ConsumerState<Home> {
  GameDataRepository gameDataRepository = GameDataRepository();
  ConsoleDataRepository consoleDataRepository = ConsoleDataRepository();
  final TextEditingController _searchController = TextEditingController();
  String searchQuery = "";

  List<String> sort = [
    "Tri par nom(croissante)",
    "Tri par nom(décroissante)",
    "Tri par prix(croissante)",
    "Tri par prix(décroissante)",
  ];
  String? selectedSort;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _applySort(List<Product> products) {
    if (selectedSort == null) return;
    switch (selectedSort) {
      case "Tri par nom(croissante)":
        sortByName(products);
        break;
      case "Tri par nom(décroissante)":
        sortByDesc(products);
        break;
      case "Tri par prix(croissante)":
        sortByPriceAsc(products);
        break;
      case "Tri par prix(décroissante)":
        sortByPriceDesc(products);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(authControllerProvider).asData?.value;
    final username = user?.username ?? "Invité";

    // Calcul dynamique du nombre de colonnes pour la grille
    final crossAxisCount = context.isDesktop
        ? 5
        : context.isTablet
        ? 3
        : 2;
    return Scaffold(
      appBar: AppBar(
        actions: [
          PopupMenuButton<String>(
            initialValue: selectedSort,
            onSelected: (value) {
              setState(() {
                selectedSort = value;
              });
            },
            itemBuilder: (context) {
              return sort.map((element) {
                return PopupMenuItem<String>(
                  value: element,
                  child: Text(element),
                );
              }).toList();
            },
          ),
        ],
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: DefaultTabController(
            length: 2,
            child: NestedScrollView(
              headerSliverBuilder: (context, innerBoxIsScrolled) {
                return [
                  // En-tête défilant
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: context.padding,
                        vertical: context.spacing,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Hello $username",
                            style: TextStyle(
                              fontSize: context.titleFontSize,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: context.spacing),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [
                                Card(
                                  color: Colors.orange,
                                  child: SizedBox(
                                    height: context.isDesktop ? 220 : 160,
                                    width: context.isDesktop ? 360 : 280,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Bienvenue",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: context.titleFontSize,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            "Explorer, Acheter et Apprécier",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: context.bodyFontSize,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            "#Pour les joueurs",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: context.bodyFontSize,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: context.spacing),
                          TextField(
                            controller: _searchController,
                            onChanged: (value) {
                              setState(() {
                                searchQuery = value;
                              });
                            },
                            decoration: InputDecoration(
                              hintText: "Rechercher un produit...",
                              prefixIcon: const Icon(Icons.search),
                              suffixIcon: searchQuery.isNotEmpty
                                  ? IconButton(
                                      icon: const Icon(Icons.clear),
                                      onPressed: () {
                                        setState(() {
                                          searchQuery = "";
                                          _searchController.clear();
                                        });
                                      },
                                    )
                                  : null,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 12,
                              ),
                            ),
                          ),
                          SizedBox(height: context.spacing),
                          Text(
                            "Catégories",
                            style: TextStyle(
                              fontSize: context.textTitleSize,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // TabBar Sticky
                  SliverAppBar(
                    pinned: true,
                    toolbarHeight: 0,
                    elevation: 0,
                    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                    bottom: const TabBar(
                      tabs: [
                        Tab(child: Center(child: Text('Jeux'))),
                        Tab(child: Center(child: Text('Console'))),
                      ],
                    ),
                  ),
                ];
              },
              // Contenu des onglets avec grille responsive
              body: Padding(
                padding: EdgeInsets.all(context.padding),
                child: TabBarView(
                  children: [
                    // Onglet 1 : Jeux
                    FutureBuilder(
                      future: gameDataRepository.readFile(),
                      builder: (context, asyncSnapshot) {
                        if (asyncSnapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        if (asyncSnapshot.hasError) {
                          return Center(
                            child: Text("Erreur : ${asyncSnapshot.error}"),
                          );
                        }
                        if (asyncSnapshot.hasData &&
                            asyncSnapshot.data!.isNotEmpty) {
                          var data = List<Product>.from(asyncSnapshot.data!);
                          data = filterBySearch(data, searchQuery);
                          _applySort(data);

                          if (data.isEmpty) {
                            return const Center(
                              child: Text("Aucun produit ne correspond à votre recherche"),
                            );
                          }

                          return GridView.builder(
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: crossAxisCount,
                                  crossAxisSpacing: context.spacing,
                                  mainAxisSpacing: context.spacing,
                                  childAspectRatio: 0.72,
                                ),
                            itemCount: data.length,
                            itemBuilder: (context, index) {
                              return CardProduct(
                                product: data[index],
                                onTap: () {
                                  context.push(
                                    '/specificGame',
                                    extra: data[index],
                                  );
                                },
                              );
                            },
                          );
                        } else {
                          return const Center(child: Text("Aucune donnée"));
                        }
                      },
                    ),
                    // Onglet 2 : Consoles
                    FutureBuilder(
                      future: consoleDataRepository.readFile(),
                      builder: (context, asyncSnapshot) {
                        if (asyncSnapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        if (asyncSnapshot.hasError) {
                          return Center(
                            child: Text("Erreur : ${asyncSnapshot.error}"),
                          );
                        }
                        if (asyncSnapshot.hasData &&
                            asyncSnapshot.data!.isNotEmpty) {
                          var data = List<Product>.from(asyncSnapshot.data!);
                          data = filterBySearch(data, searchQuery);
                          _applySort(data);

                          if (data.isEmpty) {
                            return const Center(
                              child: Text("Aucun produit ne correspond à votre recherche"),
                            );
                          }

                          return GridView.builder(
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: crossAxisCount,
                                  crossAxisSpacing: context.spacing,
                                  mainAxisSpacing: context.spacing,
                                  childAspectRatio: 0.72,
                                ),
                            itemCount: data.length,
                            itemBuilder: (context, index) {
                              return CardProduct(
                                product: data[index],
                                onTap: () {
                                  context.push(
                                    '/specificonsole',
                                    extra: data[index],
                                  );
                                },
                              );
                            },
                          );
                        } else {
                          return const Center(child: Text("Aucune donnée"));
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}


