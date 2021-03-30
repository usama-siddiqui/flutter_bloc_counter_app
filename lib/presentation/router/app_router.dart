import 'package:bloc_counter_app/presentation/screens/home_screen.dart';
import 'package:bloc_counter_app/presentation/screens/second_screen.dart';
import 'package:bloc_counter_app/presentation/screens/settings_screen.dart';
import 'package:bloc_counter_app/presentation/screens/third_screen.dart';
import 'package:flutter/material.dart';

class AppRouter {
  Route onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case "/":
        return MaterialPageRoute(
            builder: (_) =>
                HomeScreen(title: 'Home Screen', color: Colors.blueAccent));
        break;
      case "/second":
        return MaterialPageRoute(
            builder: (_) =>
                SecondScreen(title: 'Second Screen', color: Colors.redAccent));
        break;
      case "/third":
        return MaterialPageRoute(
            builder: (_) =>
                ThirdScreen(title: 'Third Screen', color: Colors.greenAccent));
        break;
      case '/settings':
        return MaterialPageRoute(
          builder: (_) => SettingsScreen(),
        );
      default:
        return null;
    }
  }
}
