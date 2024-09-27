import 'package:go_router/go_router.dart';
import 'package:yardex_user/features/auth/presentation/login_screen.dart';
import 'package:yardex_user/features/home/presentation/home_screen.dart';
import 'package:yardex_user/features/onboarding/presentation/onboarding_screen.dart';

final GoRouter router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const OnboardingScreen(),
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: '/home',
      builder: (context, state) => const HomeScreen(),
    ),
  ],
);
