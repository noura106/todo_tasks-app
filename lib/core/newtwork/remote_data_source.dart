
import 'package:QuickDo/core/contants/app_eums.dart';
import 'package:QuickDo/core/core_model/base_model.dart';
import 'package:QuickDo/core/errors/base_error.dart';
import 'package:QuickDo/core/newtwork/api_response.dart';
import 'package:QuickDo/core/newtwork/modal_factory.dart';
import 'package:QuickDo/core/storage/storage_handler.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

import 'network_helper.dart';

abstract class RemoteDataSource {
  static Future<Either<BaseError, Data>> request<Data extends BaseModel, Response extends ApiResponse<Data>>({
    required String responseStr,
    required Response Function(Map<String, dynamic>) converter,
    required HttpMethods method,
    required String url,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? data,
    bool withAuthentication = false,
  }) async {
    ModelsFactory.getInstance()!.registerModel(responseStr, converter);
    final Map<String, String> headers = {};
    if (withAuthentication) {
      headers.putIfAbsent(
          "Authorization", () => 'Bearer ${StorageHandler().token}');
      print("////////////////////////TOKEN////////////////////////////");
      print({StorageHandler().token});
    }

    final response = await NetworkHelper.sendObjectRequest<Response>(
      method: method,
      url: url,
      headers: headers,
      queryParameters: queryParameters,
      data: data,
      strString: responseStr,
    );

    debugPrint('is right : ${response.isRight()}');
    if (response.isLeft()) {
      debugPrint('is left');
      return Left((response as Left<BaseError, Response>).value);
    } else {
      debugPrint(
          'response right ${(response as Right<BaseError, Response>).value}');
      final resValue = response.value;
      return Right((resValue.data));
    }
  }
}