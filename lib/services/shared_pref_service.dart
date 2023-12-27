import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefService {
  static final SharedPrefService _instance = SharedPrefService._();

  factory SharedPrefService() {
    return _instance;
  }

  SharedPrefService._();

  static SharedPrefService get instance => _instance;

  Future<void> onInit() async {
    _sharedPref = await SharedPreferences.getInstance();
  }

  late SharedPreferences _sharedPref;

  static const String _USER_TOKEN_KEY = "USER_TOKEN_KEY";
  static const String _USER_REFRESH_TOKEN_KEY = "USER_REFRESH_TOKEN_KEY";

  String? get userToken {
    return _sharedPref.getString(_USER_TOKEN_KEY);
  }

  Future<bool> setUserToken({required String userToken}) {
    return _sharedPref.setString(_USER_TOKEN_KEY, userToken);
  }

  Future<bool> deleteUserToken() {
    return _sharedPref.remove(_USER_TOKEN_KEY);
  }

  String? get userRefreshToken {
    return _sharedPref.getString(_USER_REFRESH_TOKEN_KEY);
  }

  Future<bool> setUserRefreshToken({required String userRefreshToken}) {
    return _sharedPref.setString(_USER_REFRESH_TOKEN_KEY, userRefreshToken);
  }

  Future<bool> deleteUserRefreshToken() {
    return _sharedPref.remove(_USER_REFRESH_TOKEN_KEY);
  }
}
