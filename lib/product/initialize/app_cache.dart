import 'package:shared_preferences/shared_preferences.dart';

class AppCache {
  //final prefs = SharedPreferences.getInstance();
  AppCache._();
  static AppCache instance = AppCache._();

  Future<void> setUp() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  late SharedPreferences sharedPreferences;
}
