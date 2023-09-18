import 'package:flutter/material.dart';

class RegisterPasswordVisibilityProvider with ChangeNotifier {
  bool _visibility = false;

  bool get visibility => _visibility;

  void setVisibility(bool visibility) {
    _visibility = visibility;
    notifyListeners();
  }
}
