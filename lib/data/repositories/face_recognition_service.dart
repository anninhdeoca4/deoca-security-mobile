// services/face_recognition_service.dart
import 'package:dio/dio.dart';
import 'package:deoca_security_mobie/core/constants/api_constants.dart';
import 'package:deoca_security_mobie/core/storage/preferences.dart';

class FaceRecognitionService {

  static Future<Map<String, dynamic>?> recognizeFace({
    required String imagePath,
    required double longitude,
    required double latitude,
  }) async {
    try {
      // LẤY CODE TỪ data storage
      final code = await Preferences.getEmployeeCode();

      if (code!.isEmpty) {
        return null;
      }

      final dio = Dio();
      final formData = FormData.fromMap({
        'photo': await MultipartFile.fromFile(imagePath, filename: 'face.jpg'),
        'code': code,
        'longitude': longitude.toStringAsFixed(8),
        'latitude': latitude.toStringAsFixed(8),
      });

      final response = await dio.post("${ApiConstants.baseUrl}/CheckIn/checkin",
        data: formData,
        options: Options(
          headers: {'Content-Type': 'multipart/form-data'},
          receiveTimeout: const Duration(seconds: 25),
          sendTimeout: const Duration(seconds: 15),
          validateStatus: (status) {
            return true; // nhận tất cả status, không throw error
          },
        ),
      );
      return response.data;
    } on DioException catch (e) {
      print("API Error: $e");
      return null;
    } catch (e) {
      print("Unexpected error: $e");
      return null;
    }
  }
}
