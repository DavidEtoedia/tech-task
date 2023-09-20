import 'package:curl_logger_dio_interceptor/curl_logger_dio_interceptor.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_tech_task_master/core/constants/app_url.dart';
import 'package:flutter_tech_task_master/core/error/api_error.dart';
import 'package:flutter_tech_task_master/core/service/http_service.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class NetworkService implements HttpService {
  late final Dio _dio;

  NetworkService._({
    Dio? dioOverride,
  }) {
    _dio = dioOverride ?? Dio(baseOptions);
    _dio.interceptors.addAll([
      if (kDebugMode) ...[
        PrettyDioLogger(
          requestHeader: true,
          requestBody: true,
          responseBody: true,
          responseHeader: false,
          compact: false,
        ),
        CurlLoggerDioInterceptor(),
      ]
    ]);
  }

  static final NetworkService _instance = NetworkService._();

  factory NetworkService() => _instance;

  BaseOptions get baseOptions => BaseOptions(
        connectTimeout: const Duration(milliseconds: 30000),
        receiveTimeout: const Duration(milliseconds: 30000),
        baseUrl: baseUrl,
        headers: headers,
      );

  @override
  String get baseUrl => AppUrl.baseUrl;

  @override
  Map<String, String> get headers => {
        'accept': 'application/json',
        'content-type': 'application/json',
      };

  @override
  Future<Response> request(String path, RequestMethod method,
      {dynamic savePath,
      Map<String, dynamic>? queryParams,
      dynamic data,
      FormData? formData,
      CancelToken? cancelToken,
      Options? options}) async {
    Response response;

    try {
      switch (method) {
        case RequestMethod.post:
          response = await _dio.post(
            path,
            queryParameters: queryParams,
            data: data,
            cancelToken: cancelToken,
          );
          break;
        case RequestMethod.get:
          response = await _dio.get(
            path,
            queryParameters: queryParams,
          );

          break;
      }
      return response;
    } on DioException catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      throw errorMessage;
    }
  }
}
