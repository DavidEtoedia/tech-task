import 'package:dio/dio.dart';

abstract class HttpService {
  String get baseUrl;

  Map<String, String> get headers;

  Future<Response> request(
    String path,
    RequestMethod method, {
    dynamic savePath,
    Map<String, dynamic>? queryParams,
    dynamic data,
    FormData? formData,
    CancelToken? cancelToken,
    Options? options,
  });
}

enum RequestMethod { post, get }
