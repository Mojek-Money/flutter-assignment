import 'package:go_router/go_router.dart';
import '../../features/home/presentation/screens/home_screen.dart';
import '../../features/graph/presentation/screens/graph_screen.dart';

/// Application routing configuration using GoRouter
/// Defines all available routes and their builders
final router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomeScreen(title: 'Mojek assignment'),
    ),
    GoRoute(
      path: '/graph',
      builder: (context, state) => const GraphScreen(),
      redirect: (context, state) {
        // Handle back navigation between home and graph screens
        if (state.uri.toString() == '/graph' && state.uri.toString() == '/') {
          return '/';
        }
        return null;
      },
    ),
  ],
); 