import 'package:go_router/go_router.dart';
import '../features/calculator/calculator_screen.dart';
import '../features/about/about_screen.dart';

final appRouter = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const CalculatorScreen(),
    ),
    GoRoute(
      path: '/about',
      builder: (context, state) => const AboutScreen(),
    ),
  ],
);
