import 'package:product_hunt_app/utils/app_keys.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppPreferences {
  static AppPreferences _appPreferences;
  AppPreferences._internal();
  factory AppPreferences() {
    _appPreferences = _appPreferences ?? AppPreferences._internal();

    return _appPreferences;
  }

  SharedPreferences _sharedPreferences;

  Future<void> init() async {
    _sharedPreferences =
        _sharedPreferences ?? await SharedPreferences.getInstance();
  }

  clearUserData() {
    SharedPreferences prefs = _sharedPreferences;
    prefs.clear();
  }

  saveTimeStamp(int dateandtime) {
    SharedPreferences pref = _sharedPreferences;
    pref.setInt(AppPreferenceKeys.timeStamp, dateandtime);
  }

  int get lastTimeStamp {
    SharedPreferences pref = _sharedPreferences;
    return pref.getInt(AppPreferenceKeys.timeStamp);
  }
}
