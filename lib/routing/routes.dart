import 'package:app_e_commerce/features/Console/presentation/screens/specific_console_screen.dart';
import 'package:app_e_commerce/features/auth/presentation/screens/login_screen.dart';
import 'package:app_e_commerce/features/auth/presentation/screens/signup_screen.dart';
import 'package:app_e_commerce/features/games/presentation/screens/specific_game_screen.dart';
import 'package:app_e_commerce/shared/screens/home.dart';
import 'package:go_router/go_router.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/Home',
  routes: [
    GoRoute(path: "/login", builder: (context, state) => const LoginScreen()),
    GoRoute(path: "/signup", builder: (context, state) => const SignupScreen()),
    GoRoute(
      path: "/specificonsole",
      builder: (context, state) => const SpecificConsoleScreen(),
    ),
    GoRoute(
      path: "/specificGame",
      builder: (context, state) => const SpecificGameScreen(),
    ),
    GoRoute(path: "/Home", builder: (context, state) => const Home()),
  ],
);
