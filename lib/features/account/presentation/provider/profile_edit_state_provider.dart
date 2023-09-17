import 'package:flutter/material.dart';

class ProfileEditStateProvider with ChangeNotifier {
  bool _isEdit = false;

  bool get isEdit => _isEdit;

  void setIsEdit(bool value) {
    _isEdit = value;
    notifyListeners();
  }
}
