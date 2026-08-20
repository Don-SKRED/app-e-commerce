import 'package:app_e_commerce/features/auth/presentation/screens/login_screen.dart';
import 'package:app_e_commerce/features/auth/presentation/screens/signup_screen.dart';
import 'package:go_router/go_router.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/login',
  routes: [
    GoRoute(path: "/login", builder: (context, state) => const LoginScreen()),
    GoRoute(path: "/signup", builder: (context, state) => const SignupScreen()),
  ],
);
