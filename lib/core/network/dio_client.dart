// HTTP-клиент для внешних API (LiveKit Egress и т.п.)
// AUTO-GENERATED STUB. Реализуйте логику позже.

import 'package:dio/dio.dart';

import '../config/constants.dart';
import '../config/env.dart';

/// Тонкая обёртка над Dio для запросов вне PocketBase.
class DioClient {
  DioClient._();

  static final DioClient instance = DioClient._();

  late final Dio _dio = Dio(
    BaseOptions(
      baseUrl: Env.liveKitUrl,
      connectTimeout: AppConstants.networkTimeout,
      receiveTimeout: AppConstants.networkTimeout,
    ),
  );

  Dio get dio => _dio;
}
