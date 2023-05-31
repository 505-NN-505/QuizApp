import 'package:flutter/material.dart';
class ScoreController with ChangeNotifier {
  int _score = 0;

  int get score => _score;
  void increaseScore() {
    _score++;
    notifyListeners();
  }
  void resetScore() {
    _score = 0;
    notifyListeners();
  }
}