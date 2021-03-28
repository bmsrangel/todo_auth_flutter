import 'package:shared_preferences/shared_preferences.dart';

import '../user_model.dart';

class LocalStorageService {
  SharedPreferences _prefs;

  final String _dataKey = 'userData';

  Future<void> storeUserData(UserModel userData) async {
    await _init();
    await _prefs.setString(_dataKey, userData.toJson());
  }

  Future<UserModel> getUserData() async {
    await _init();
    final String userMapData = _prefs.getString(_dataKey);
    if (userMapData == null) {
      return null;
    } else {
      return UserModel.fromJson(userMapData);
    }
  }

  Future<void> clearUserData() async {
    await _init();
    await _prefs.clear();
  }

  Future<void> _init() async {
    if (_prefs == null) {
      _prefs = await SharedPreferences.getInstance();
    }
  }
}
