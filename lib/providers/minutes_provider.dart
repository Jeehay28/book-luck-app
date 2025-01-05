import 'package:flutter/material.dart';

class MinutesProvider extends ChangeNotifier {
  int _minutes = 0;

  int get minutes => _minutes;

  void setMinutes(int newMinutes) {
    _minutes = newMinutes;
    notifyListeners();
  }
}
