import 'package:app_e_commerce/features/Console/domain/models/console_model.dart';
import 'package:app_e_commerce/features/Console/presentation/screens/specific_console_screen.dart';
import 'package:app_e_commerce/features/auth/presentation/screens/login_screen.dart';
import 'package:app_e_commerce/features/auth/presentation/screens/signup_screen.dart';
import 'package:app_e_commerce/features/favorites/presentation/screens/favorites_screen.dart';
import 'package:app_e_commerce/features/games/domain/model/game_model.dart';
import 'package:app_e_commerce/features/games/presentation/screens/specific_game_screen.dart';
import 'package:app_e_commerce/features/profile/presentation/screens/about_screen.dart';
import 'package:app_e_commerce/shared/screens/home.dart';
import 'package:app_e_commerce/shared/widgets/navbar_widget.dart';
import 'package:go_router/go_router.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/login',
  routes: [
    GoRoute(path: "/login", builder: (context, state) => const LoginScreen()),
    GoRoute(path: "/signup", builder: (context, state) => const SignupScreen()),
    GoRoute(
      path: "/navbar",
      builder: (context, state) => const NavigationBarWidget(),
    ),
    GoRoute(
      path: "/specificonsole",
      builder: (context, state) {
        final console = state.extra as Console?;
        return SpecificConsoleScreen(console: console);
      },
    ),
    GoRoute(
      path: "/specificGame",
      builder: (context, state) {
        final game = state.extra as Game?;
        return SpecificGameScreen(game: game);
      },
    ),
    GoRoute(path: "/Home", builder: (context, state) => const Home()),
    GoRoute(path: "/favorites", builder: (context, state) => const FavoritesScreen()),
    GoRoute(path: "/about", builder: (context, state) => const AboutScreen()),
  ],
);

