import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  // Keys
  static const String keyToken = 'user_token';
  static const String keyEmployeeCode = 'employee_code';  // msht
  static const String keyEmployeeName = 'employee_name';  // username

  // Token
  static Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(keyToken, token);
  }

  static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(keyToken);
  }

  static Future<void> deleteToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(keyToken);
  }

  // Employee Code (msht)
  static Future<void> saveEmployeeCode(String code) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(keyEmployeeCode, code);
  }

  static Future<String?> getEmployeeCode() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(keyEmployeeCode);
  }

  // Employee Name
  static Future<void> saveEmployeeName(String name) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(keyEmployeeName, name);
  }

  static Future<String?> getEmployeeName() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(keyEmployeeName);
  }

  // Xóa toàn bộ khi logout
  static Future<void> clearAllUserData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(keyToken);
    await prefs.remove(keyEmployeeCode);
    await prefs.remove(keyEmployeeName);
  }

  // Kiểm tra đã đăng nhập chưa
  static Future<bool> isLoggedIn() async {
    final token = await getToken();
    return token != null && token.isNotEmpty;
  }
}