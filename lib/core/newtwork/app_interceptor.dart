import 'package:QuickDo/core/storage/storage_handler.dart';
import 'package:QuickDo/features/auth/data/repsitory/auth_repository.dart';
import 'package:QuickDo/features/auth/data/use_cases/refresh_token_use_case.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart' as git;
import 'package:get/get_core/src/get_main.dart';



class AuthorizationInterceptor extends InterceptorsWrapper {
  final AuthRepository authRepository;
  AuthorizationInterceptor(
      {super.onRequest,
        super.onResponse,
        super.onError,
        required this.authRepository});

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (options.uri.toString().contains("refresh")) {
      options.headers["Authorization"] =
      "Bearer  ${StorageHandler().token}";
    } else {
      options.headers["Authorization"] =
      "Bearer  ${StorageHandler().token}";
    }
    handler.next(options);
  }

  @override
  Future<void> onError(
      DioError err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode != 401 ||
        err.requestOptions.uri.toString().contains("login")) {
      return handler.reject(err);
    }
    final result = await authRepository.refreshToken(params: RefreshTokenParams(expiresInMins: 180));
    if(result.hasDataOnly){
      await StorageHandler().setToken(result.data!.token!);

    }

    RequestOptions options = err.requestOptions;

    try {
      handler.resolve(await _retry(options));
    } on DioError catch (error) {
      handler.reject(error);
    }
  }

  Future<Response<dynamic>> _retry(RequestOptions requestOptions) async {
    final options = Options(
      method: requestOptions.method,
      headers: requestOptions.headers,
    );
    return Get.find<Dio>().request<dynamic>(requestOptions.path,
        data: requestOptions.data,
        queryParameters: requestOptions.queryParameters,
        options: options);
  }
}
