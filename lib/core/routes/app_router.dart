import 'package:flutter/material.dart';
import '../../features/home/presentation/screens/home_screen.dart';

class AppRouter {
  Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (_) => const HomeScreen(title: 'Flutter Demo Home Page'),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => const HomeScreen(title: 'Flutter Demo Home Page'),
        );
    }
  }
} 