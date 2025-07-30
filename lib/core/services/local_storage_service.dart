import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  final SharedPreferences _prefs;

  LocalStorageService(this._prefs);

  Future<void> saveToken(String token) async {
    await _prefs.setString('token', token);
  }

  Future<String?> getToken() async {
    return _prefs.getString('token');
  }

  Future<void> clearToken() async {
    await _prefs.remove('token');
  }

  Future<void> clearUserData() async {
    await _prefs.remove('token');
  }
}
