import 'package:shared_preferences/shared_preferences.dart';
import 'package:simsppob/core/error/exception.dart';
import 'package:simsppob/utils/helper/encript_data.dart';

abstract class LoginLocal {
  Future<void> cacheLogin(String token);
  Future<String> getLastLogin();
  Future<void> deleteLastLogin();
}

const cachedLoginData = 'CACHED_LOGIN_DATA';

class LoginLocalImpl implements LoginLocal {
  final SharedPreferences sharedPreferences;

  LoginLocalImpl(this.sharedPreferences);
  @override
  Future<void> cacheLogin(String token) async {
    await sharedPreferences.setString(cachedLoginData, encryptData(token));
  }

  @override
  Future<String> getLastLogin() {
    final jsonString = sharedPreferences.getString(cachedLoginData);
    if (jsonString != null) {
      return Future.value(decryptData(jsonString));
    } else {
      throw CacheException();
    }
  }

  @override
  Future<void> deleteLastLogin() async {
    await sharedPreferences.remove(cachedLoginData);
  }
}
