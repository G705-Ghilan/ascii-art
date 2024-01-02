import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  static late SharedPreferences pref;

  static Future getInstance() async {
    pref = await SharedPreferences.getInstance();
  }
}
