import 'package:get_storage/get_storage.dart';

class LocalStorage {
  final GetStorage _storage = GetStorage();

  final String _tokenKey = 'auth_token';
  final String _userIdKey = 'user_id';

  Future<void> saveToken(String token) async {
    await _storage.write(_tokenKey, token);
  }

  String? getToken() {
    return _storage.read(_tokenKey);
  }

  Future<void> removeToken() async {
    await _storage.remove(_tokenKey);
    await _storage.remove(_userIdKey);
  }
  Future<void> saveUserId(String id) async {
    await _storage.write(_userIdKey, id);
  }

  String? getUserId() => _storage.read(_userIdKey);
}