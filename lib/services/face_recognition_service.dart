import 'dart:nativewrappers/_internal/vm/lib/internal_patch.dart';

import 'package:dio/dio.dart';

class FaceRecognitionService {
  static Future<Map<String, dynamic>?> recognizeFace(String imagePath) async {
    try {
      final dio = Dio();

      // 🧩 Gửi form-data
      final formData = FormData.fromMap({
        'file': await MultipartFile.fromFile(imagePath, filename: 'face.jpg'),
      });

      final response = await dio.post(
        'https://8877e915d6fa.ngrok-free.app/recognize',
        data: formData,
        options: Options(
          headers: {'Content-Type': 'multipart/form-data'},
          receiveTimeout: const Duration(seconds: 20),
        ),
      );

      if (response.statusCode == 200) {
        return response.data;
      }
      return null;
    } on DioException catch (e) {
      printToConsole("❌ API error: ${e.response?.data ?? e.message}");
      return null;
    }
  }
}
