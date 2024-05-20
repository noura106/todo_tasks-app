import 'dart:convert';

import 'package:QuickDo/core/contants/app_eums.dart';
import 'package:QuickDo/core/errors/app_exceptions.dart';
import 'package:QuickDo/core/errors/base_error.dart';
import 'package:QuickDo/core/errors/error_handler.dart';
import 'package:QuickDo/core/errors/error_message_model.dart';
import 'package:QuickDo/core/newtwork/api_urls.dart';
import 'package:QuickDo/core/newtwork/app_header.dart';
import 'package:QuickDo/core/newtwork/app_interceptor.dart';
import 'package:QuickDo/core/newtwork/modal_factory.dart';
import 'package:QuickDo/features/auth/data/repsitory/auth_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class NetworkHelper {
  static var options = BaseOptions(
    baseUrl: ApiURLs.baseUrl,
    validateStatus: (status) => true,
  );
  static final Dio dio = Dio(options)..interceptors.add(AuthorizationInterceptor(authRepository: AuthRepository()));


  static Future<Either<BaseError, T>> sendObjectRequest<T>({
    required HttpMethods method,
    required String url,
    Map<String, dynamic>? data,
    Map<String, String>? headers,
    Map<String, dynamic>? queryParameters,
    CancelToken? cancelToken,
    required String strString,
  }) async {
    try {
      dio.options.headers = headers ?? AppHeaders.header;

      Response response;
      switch (method) {
        case HttpMethods.GET:
          response = await dio.get(
            url,
            queryParameters: queryParameters,
          );
          break;
        case HttpMethods.POST:
          response = await dio.post(
            url,
            data: data,
            queryParameters: queryParameters ?? {},
          );
          break;
        case HttpMethods.PUT:
          response = await dio.put(
            url,
            data: data,
            queryParameters: queryParameters,
          );
          break;
        case HttpMethods.DELETE:
          response = await dio.delete(
            url,
            data: data,
            queryParameters: queryParameters,
          );
          break;
      }
      dio.interceptors.add(PrettyDioLogger(
          request: true,
          requestHeader: true,
          requestBody: true,
          responseBody: true,
          responseHeader: false,
          error: true,
          compact: true,
          maxWidth: 90));
      // Get the decoded json
      if (response.data is Map<String, dynamic>) {
        print('response ${response.data}');
        print('deeeeeeeecoded data ${response.data}');
        return Right(ModelsFactory.getInstance()!
            .createModel<T>(response.data, strString));
      } else if (response.data is String) {
      }
      return response.data;
    }

    // Handling errors
    on DioError catch (e) {
      var error = handleError(e);
      if (error is Map<String, dynamic>) {
        throw ServerException(ErrorMessageModel.fromJson(error));
      } else if (error is String) {
        throw ServerException(ErrorMessageModel(
            statusMessage: error, success: false, status: 500));
      }

      throw NoInternetException();
    }
  }
}
