import 'package:dio/dio.dart';

dynamic handleError(DioError e) {
  if (e.type == DioErrorType.connectTimeout) {
    return "Connection Time Out Try Again Later";
  } else if (e.type == DioErrorType.receiveTimeout) {
    return "Receive Time Out Try Again Later";
  } else if (e.type == DioErrorType.response) {
    return (e.response?.data is Map) ? e.response?.data : e.message;
  } else if (e.type == DioErrorType.sendTimeout) {
    return "Send Time Out Try Again Later";
  } else {
    return "Unknown Error";
  }
}
