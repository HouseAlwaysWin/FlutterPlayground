import 'package:flutter/material.dart';

class ThemeManager with ChangeNotifier {
  ThemeMode _mode;
  ThemeMode get mode => _mode;
  ThemeManager({ThemeMode mode = ThemeMode.light}) : _mode = mode;

  void toggleMode() {
    _mode = _mode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
}
