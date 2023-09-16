import 'package:flutter/material.dart';

class NavbarProvider extends ChangeNotifier {
  int _selectedIndex = 0;

  int get selectedIndex => _selectedIndex;

  void changeNavbar(int newIndex) {
    _selectedIndex = newIndex;
    notifyListeners();
  }
}
