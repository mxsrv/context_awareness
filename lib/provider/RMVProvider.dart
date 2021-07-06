import 'package:flutter/material.dart';

class RMVProvider with ChangeNotifier {
  bool _rmvActive = false;
  bool get rmvActive => _rmvActive;

  void setActive() {
    _rmvActive = true;
    notifyListeners();
  }

  void setInactive() {
    _rmvActive = false;
    notifyListeners();
  }
}