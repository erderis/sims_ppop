import 'package:flutter/material.dart';

class TopUpFieldStateProvider with ChangeNotifier {
  bool _isFilled = false;

  bool get isFilled => _isFilled;

  void setIsFilled(bool value) {
    _isFilled = value;
    notifyListeners();
  }
}
