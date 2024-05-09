import 'package:flutter/material.dart';
import 'package:play_ground/services/storage_manager.dart';

class ThemeManager with ChangeNotifier {
  ThemeMode _mode;
  ThemeMode get mode => _mode;
  ThemeManager({ThemeMode mode = ThemeMode.light}) : _mode = mode {
    StorageManager.readData('mode').then((value) {
      if (value != null) {
        _mode = ThemeMode.values
            .firstWhere((element) => element.toString() == value);
        notifyListeners();
      }
    });
  }

  void toggleMode() {
    _mode = _mode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    StorageManager.saveData('mode', _mode.toString());
    notifyListeners();
  }
}
