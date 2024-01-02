import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../shared/shared_prefernces.dart';

class Settingsprovider with ChangeNotifier {
  set themeIndex(int index) {
    Preferences.pref.setInt("theme-index", index);
    notifyListeners();
  }

  int get themeIndex => Preferences.pref.getInt("theme-index") ?? 1;

  ThemeMode get themeMode => ThemeMode.values[themeIndex];

  bool isMyTheme(int index) {
    return themeIndex == index;
  }


  static ChangeNotifierProvider<Settingsprovider> create() {
    return ChangeNotifierProvider(create: (context) => Settingsprovider());
  }
}
