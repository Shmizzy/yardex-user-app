import 'package:go_router/go_router.dart';
import 'package:yardex_user/features/auth/presentation/login_screen.dart';
import 'package:yardex_user/features/home/presentation/home_screen.dart';

final GoRouter router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginScreen(),
    ),
  ],
);
