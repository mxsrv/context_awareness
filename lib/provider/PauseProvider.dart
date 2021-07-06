import 'dart:async';

import 'package:flutter/material.dart';

class PauseProvider with ChangeNotifier {
  Stopwatch _stopwatch = Stopwatch();
  bool _workTimerActive = false;
  bool get workTimerActive => _workTimerActive;
  int get workTime => _stopwatch.elapsedMilliseconds;

  void setActive() {
    _workTimerActive = true;
    notifyListeners();
  }

  void setInactive() {
    _stopwatch.reset();
    print("reset stopwatch");
    _workTimerActive = false;
    notifyListeners();
  }

  void startStopwatch() {
    if(!_stopwatch.isRunning){
      _stopwatch.start();
      print("started stopwatch");
    }
    // notifyListeners();
  }

  void resetStopwatch() {
    _stopwatch.reset();
    print("reset stopwatch");
    // notifyListeners();
  }
}