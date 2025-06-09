import 'package:get_storage/get_storage.dart';

class LocalStorage {
  final GetStorage _storage = GetStorage();

  final String _tokenKey = 'auth_token';
  final String _userIdKey = 'user_id';
  final String _fcmToken = "fcmToken";
  final String _refreshTokenKey = 'refresh_token';
  final String _localeKey = 'selected_locale';

  Future<void> saveToken(String token) async {
    await _storage.write(_tokenKey, token);
    print("saveToken---->1${token}");
  }

  String? getToken() {
    final token = _storage.read(_tokenKey);
    print("Getting access token1: $token");
    return token;
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
    print("Saving refresh token: $token");
  }

  String? getRefreshToken() {
    final token = _storage.read(_refreshTokenKey);
    print("Getting refresh token: $token");
    return token;
  }

  /// Language

  // Store selected locale
  Future<void> saveLocale(String localeCode) async {
    await _storage.write(_localeKey, localeCode);
    print("Locale saved: $localeCode");
  }

  String? getSavedLocale() {
    final locale = _storage.read(_localeKey);
    print("Retrieved saved locale: $locale");
    return locale;
  }

  Future<void> removeToken() async {
    await _storage.remove(_tokenKey);
    await _storage.remove(_userIdKey);
    await _storage.remove(_refreshTokenKey);
    await _storage.remove(_tokenKey);
    await _storage.remove(_localeKey);
    //await _storage.remove(_fcmToken);
    print("All tokens removed from local storage.");
  }

  Future<void> saveUserId(String id) async {
    await _storage.write(_userIdKey, id);
  }

  String? getUserId() => _storage.read(_userIdKey);
}
