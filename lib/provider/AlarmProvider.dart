import 'package:flutter/material.dart';

class AlarmProvider with ChangeNotifier {
  bool _alarmActive = false;
  bool get alarmActive => _alarmActive;

  void setActive() {
    _alarmActive = true;
    notifyListeners();
  }

  void setInactive() {
    _alarmActive = false;
    notifyListeners();
  }
}