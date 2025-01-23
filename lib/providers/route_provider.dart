import 'package:flutter/material.dart';

class RouteProvider with ChangeNotifier {
  String _currentRoute = '/home'; // Initial route

  String get currentRoute => _currentRoute;

  void updateRoute(String newRoute) {
    if (_currentRoute != newRoute) {
      _currentRoute = newRoute;
      notifyListeners(); // Notify listeners about the change
    }
  }
}
