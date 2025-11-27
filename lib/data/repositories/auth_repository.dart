import 'package:flutter_application_learn/core/storage/preferences.dart';
import 'package:flutter_application_learn/core/storage/token_storage.dart';

import '../../core/network/api_service.dart';
import '../../core/network/api_response.dart';
import '../../core/constants/api_constants.dart';

class AuthRepository {
  final ApiService _apiService = ApiService(baseUrl: ApiConstants.baseUrl);

  Future<ApiResponse<Map<String, dynamic>>> login({
    required String msht,
  }) async {
    final response = await _apiService.post<Map<String, dynamic>>(
      ApiConstants.login,
      data: {'code': msht},
      fromJson: (data) => data as Map<String, dynamic>,
    );

    if (response.success && response.data != null) {
      final userData = response.data!['data'];
      
      // TOKEN LƯU VÀO SUCURE STORAGE
      await TokenStorage().saveToken(userData['token'] as String);
      // LƯU THÔNG TIN USER VÀO SHARED PREFERENCES
      await Preferences.saveEmployeeCode(userData['msht'] as String);
      await Preferences.saveEmployeeName(userData['username'] as String);
    }

    return response;
  }

  // Future<ApiResponse<void>> logout() async {
  //   //final response = await _apiService.post<void>(ApiConstants.logout);

  //   // XÓA THÔNG TIN USER KHI LOGOUT
  //   await Preferences.clearAllUserData();
  //   await TokenStorage().deleteTokens();

  //   return response;
  // }

  Future<void> logout() async {
    // XÓA THÔNG TIN USER KHI LOGOUT
    await Preferences.clearAllUserData();
    await TokenStorage().deleteTokens();
  }
}
