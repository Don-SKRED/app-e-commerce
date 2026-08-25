import 'package:app_e_commerce/shared/utils/responsive.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    // Calcul dynamique du nombre de colonnes pour la grille
    final crossAxisCount = context.isDesktop
        ? 5
        : context.isTablet
            ? 3
            : 2;

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
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
                            "Hello Ruddy",
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
                                  ),
                                ),
                                Card(
                                  color: Colors.amber,
                                  child: SizedBox(
                                    height: context.isDesktop ? 220 : 160,
                                    width: context.isDesktop ? 360 : 280,
                                  ),
                                ),
                              ],
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
                    backgroundColor: Theme.of(
                      context,
                    ).scaffoldBackgroundColor,
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
                    GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: crossAxisCount,
                        crossAxisSpacing: context.spacing,
                        mainAxisSpacing: context.spacing,
                        childAspectRatio: 0.85,
                      ),
                      itemCount: 6,
                      itemBuilder: (context, index) {
                        return const Card(
                          color: Colors.purple,
                          child: Center(
                            child: Text(
                              "Jeu",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                    // Onglet 2 : Consoles
                    GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: crossAxisCount,
                        crossAxisSpacing: context.spacing,
                        mainAxisSpacing: context.spacing,
                        childAspectRatio: 0.85,
                      ),
                      itemCount: 6,
                      itemBuilder: (context, index) {
                        return const Card(
                          color: Colors.deepOrange,
                          child: Center(
                            child: Text(
                              "Console",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        );
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

