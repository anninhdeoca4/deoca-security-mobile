// lib/services/dio_client.dart
import 'package:dio/dio.dart';

class DioClient {
  static final Dio _dio = Dio(BaseOptions(
    baseUrl: 'https://f9d909a2d0c7.ngrok-free.app', // ← API thật
    connectTimeout: const Duration(seconds: 10),
    receiveTimeout: const Duration(seconds: 10),
    headers: {
      'Content-Type': 'application/json',
    },
  ));

  static Dio get instance => _dio;
}