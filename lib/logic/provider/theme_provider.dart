import 'package:flutter/material.dart';

class DarkThemeProvider with ChangeNotifier {
  bool _darkTheme = true;

  bool get darkTheme => _darkTheme;

  darkThemessd(bool value) {
    _darkTheme = !_darkTheme;
    notifyListeners();
  }
}
