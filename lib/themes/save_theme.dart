import 'package:shared_preferences/shared_preferences.dart';

class SaveTheme {
  static const theme_status = "theme stat";
  setDarktheme(bool value) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setBool(theme_status, value);
  }

  Future<bool> gettheme() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getBool(theme_status) ?? false;
  }
}
