import 'package:finvu_test/features/home/home_screen.dart';
import 'package:go_router/go_router.dart';

/// Application routing configuration using GoRouter
/// Defines all available routes and their builders
final router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomeScreen(title: 'Finvu'),
    ),
  ],
);
