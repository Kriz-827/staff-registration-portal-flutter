import 'package:flutter/material.dart';
import 'package:staff_reg_portal/themes/save_theme.dart';

class ThemeProvider extends ChangeNotifier {
  SaveTheme mytheme = SaveTheme();

  bool _themeData = false;

  bool get getthemedata => _themeData;

  set themedata(bool value) {
    _themeData = value;
    mytheme.setDarktheme(value);
    notifyListeners();
  }
}
