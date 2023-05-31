import 'package:flutter/material.dart';
class ControlDifficulty with ChangeNotifier {
  int _diff = 1;

  int get difficulty => _diff;
  void setDifficulty(int arg_difficulty) {
    _diff = arg_difficulty;
    notifyListeners();
  }
}