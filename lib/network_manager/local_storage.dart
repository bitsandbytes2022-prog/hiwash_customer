import 'package:get_storage/get_storage.dart';

class LocalStorage {
  final GetStorage _storage = GetStorage();

  final String _tokenKey = 'auth_token';
  final String _userIdKey = 'user_id';
 final  String _fcmToken = "fcmToken";
  final String _refreshTokenKey = 'refresh_token';


  Future<void> saveToken(String token) async {
    await _storage.write(_tokenKey, token);
  }

  String? getToken() {
    return _storage.read(_tokenKey);
  }
  saveFCMToken({var token}) {
    _storage.write(_fcmToken, token);
  }

   String getFCMToken() {
    return _storage.read(_fcmToken) ?? '';
  }




  // Refresh Token
  Future<void> saveRefreshToken(String token) async {
    await _storage.write(_refreshTokenKey, token);
  }

  String? getRefreshToken() {
    return _storage.read(_refreshTokenKey);
  }


  Future<void> removeToken() async {
    await _storage.remove(_tokenKey);
    await _storage.remove(_userIdKey);
    await _storage.remove(_refreshTokenKey);
  }
  Future<void> saveUserId(String id) async {
    await _storage.write(_userIdKey, id);
  }

  String? getUserId() => _storage.read(_userIdKey);
}