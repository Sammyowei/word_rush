import 'dart:async';

import 'package:flutter/material.dart';

class GameTimer extends ChangeNotifier {
  GameTimer();

  Timer? countDownTimer;

  Duration gameDuration = Duration(minutes: 5);

  bool isPaused = false;

  late Duration _previousDuration;

  String get TextMagnifier => _duration();

  //TODO: CountDown Timer Functions

  void startTimer() {
    countDownTimer =
        Timer.periodic(const Duration(seconds: 1), (_) => setCountDown());
  }

  void setCountDown() {
    const redceSecondsBy = 1;

    final seconds = gameDuration.inSeconds - redceSecondsBy;
    if (seconds < 0) {
      countDownTimer!.cancel();
      notifyListeners();
    } else {
      gameDuration = Duration(
        seconds: seconds,
      );
      notifyListeners();
    }
  }

  void resetTimer() {
    stopTimer();
    gameDuration = Duration(minutes: 5);
    notifyListeners();
  }

// TODO: Finish this code
  void pauseTimer() {
    if (!isPaused) {
      isPaused = true;
      _previousDuration = gameDuration;
      countDownTimer?.cancel();
      notifyListeners();
    }
  }

// TODO: Finish this code
  void resumeTimer() {
    if (isPaused) {
      isPaused = false;
      gameDuration = _previousDuration;
      startTimer();
      notifyListeners();
    }
  }

  void stopTimer() {
    countDownTimer!.cancel();
    notifyListeners();
  }

  String _strDigits(int n) => n.toString().padLeft(2, '0');
  String _duration() {
    final minutes = _strDigits(gameDuration.inMinutes.remainder(60));
    final seconds = _strDigits(gameDuration.inSeconds.remainder(60));

    return '$minutes:$seconds';
  }
}
