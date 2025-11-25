import 'package:flutter_application_learn/core/storage/preferences.dart';

import '../../core/network/api_service.dart';
import '../../core/network/api_response.dart';
import '../../core/constants/api_constants.dart';

class AuthRepository {
  final ApiService _apiService = ApiService(baseUrl: ApiConstants.baseUrl);

  Future<ApiResponse<Map<String, dynamic>>> login({
    required String code,
  }) async {
    final response = await _apiService.post<Map<String, dynamic>>(
      ApiConstants.login,
      data: {'code': code},
      fromJson: (data) => data as Map<String, dynamic>,
    );

    if (response.success && response.data != null) {
      final userData = response.data!['data'];

      // Lưu tất cả thông tin bằng SharedPreferences
      await Preferences.saveToken(userData['token'] as String);
      await Preferences.saveEmployeeCode(userData['msht'] as String);
      await Preferences.saveEmployeeName(userData['username'] as String);
    }

    return response;
  }

  Future<ApiResponse<void>> logout() async {
    final response = await _apiService.post<void>(ApiConstants.logout);

    // Dù có lỗi hay không, vẫn xóa dữ liệu local
    await Preferences.clearAllUserData();

    return response;
  }

  // Bonus: Hàm lấy thông tin user đã lưu (dùng ở các màn hình khác)
  static Future<Map<String, String?>> getCurrentUser() async {
    return {
      'token': await Preferences.getToken(),
      'code': await Preferences.getEmployeeCode(),
      'name': await Preferences.getEmployeeName(),
    };
  }
}