import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CountdownModel extends ChangeNotifier {
  late Timer _timer;
  int _secondsRemaining = 0;
  bool _isPaused = false;

  int get secondsRemaining => _secondsRemaining;
  bool get isPaused => _isPaused;

  void startTimer(int minutes) {
    _secondsRemaining = minutes * 60;
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (!_isPaused) {
        if (_secondsRemaining > 0) {
          _secondsRemaining--;
          notifyListeners();
        } else {
          _timer.cancel();
        }
      }
    });
  }

  void stopTimer() {
    _timer.cancel();
    _secondsRemaining = 0;
    notifyListeners();
  }

  void pauseTimer() {
    _isPaused = true;
    notifyListeners();
  }

  void resumeTimer() {
    _isPaused = false;
    notifyListeners();
  }

  void restartTimer(int minutes) {
    _isPaused = false;
    _secondsRemaining = minutes * 60;
    notifyListeners();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }
}
