import 'package:QuickDo/core/contants/app_eums.dart';
import 'package:QuickDo/core/core_repository/core_repository.dart';
import 'package:QuickDo/core/newtwork/api_urls.dart';
import 'package:QuickDo/core/newtwork/remote_data_source.dart';
import 'package:QuickDo/core/newtwork/result.dart';
import 'package:QuickDo/features/auth/data/models/login_model.dart';
import 'package:QuickDo/features/auth/data/use_cases/login_use_case.dart';
import 'package:QuickDo/features/auth/data/use_cases/refresh_token_use_case.dart';


class AuthRepository extends CoreRepository {

  Future<Result<LoginModel>> login({required LogInParams params}) async {
    final result = await RemoteDataSource.request(
        withAuthentication: false,
        data: params.toJson(),
        url: ApiURLs.login,
        method: HttpMethods.POST,
        converter: (json) => LoginResponseModel.fromJson(json),
        responseStr: 'loginResponse');
    return call(result: result);
  }
  Future<Result<LoginModel>> refreshToken({required RefreshTokenParams params}) async {
    final result = await RemoteDataSource.request(
        withAuthentication: false,
        data: params.toJson(),
        url: ApiURLs.login,
        method: HttpMethods.POST,
        converter: (json) => LoginResponseModel.fromJson(json),
        responseStr: 'refreshTokenRes');
    return call(result: result);
  }
}