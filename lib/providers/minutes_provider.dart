import 'package:flutter/material.dart';

class MinutesProvider extends ChangeNotifier {
  int _minutes = 5;
  bool _goal = false;

  int get minutes => _minutes;
  bool get goal => _goal;

  void setMinutes(int newMinutes) {
    _minutes = newMinutes;
    notifyListeners();
  }

  void setGoal(bool newGoal) {
    _goal = newGoal;
    notifyListeners();
  }
}
