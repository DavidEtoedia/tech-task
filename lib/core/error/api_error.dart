import 'package:dio/dio.dart';
import 'package:flutter_tech_task_master/core/error/http_error_strings.dart';

class DioExceptions implements Exception {
  late String message;

  DioExceptions.fromDioError(DioException dioError) {
    switch (dioError.type) {
      case DioExceptionType.cancel:
        message = HttpErrorStrings.operationCancelled;
        break;
      case DioExceptionType.connectionError:
        message = HttpErrorStrings.connectionTimeoutActive;
        break;
      case DioExceptionType.receiveTimeout:
        message = HttpErrorStrings.receiveTimeout;
        break;
      case DioExceptionType.badResponse:
        message = _handleError(
          dioError.response?.statusCode,
          dioError.response?.data,
        );
        break;
      case DioExceptionType.sendTimeout:
        message = HttpErrorStrings.sendTimeout;
        break;
      case DioExceptionType.unknown:
        if (dioError.error.toString().contains("SocketException")) {
          message = HttpErrorStrings.genericRes;
          break;
        }
        message = HttpErrorStrings.uknown;
        break;
      default:
        message = "Something went wrong please try again later";
        break;
    }
  }
  String _handleError(int? statusCode, dynamic error) {
    switch (statusCode) {
      case 400:
        return "Bad request";
      case 401:
        return "Unauthorized";
      case 403:
        return "An Error occurred please check back";
      case 404:
        return error['error'];
      case 500:
        return "Internal server error";
      case 502:
        return "Bad gateway";
      case 504:
        return "Service unavaiilable. Please try again later";
      default:
        return "Oops something went wrong";
    }
  }

  @override
  String toString() => message;
}
