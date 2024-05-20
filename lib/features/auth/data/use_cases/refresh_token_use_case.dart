import 'package:QuickDo/core/core_model/base_params.dart';
import 'package:QuickDo/core/newtwork/result.dart';
import 'package:QuickDo/core/use_cases/base_use_case.dart';
import 'package:QuickDo/features/auth/data/models/login_model.dart';
import 'package:QuickDo/features/auth/data/repsitory/auth_repository.dart';

class RefreshTokenParams extends BaseParams {
  RefreshTokenParams({
    this.expiresInMins,

  });

  final int? expiresInMins;


  toJson() {
    Map<String, dynamic> queryParams = {};
    if (expiresInMins != null) {
      queryParams.putIfAbsent("rememberClient", () => expiresInMins);
    }
    return queryParams;
  }
}

class RefreshTokenUseCase extends BaseUseCase<LoginModel, RefreshTokenParams> {
  final AuthRepository repository;

  RefreshTokenUseCase(this.repository);

  @override
  Future<Result<LoginModel>> call({required RefreshTokenParams params}) {
    return repository.refreshToken(params: params);
  }
}
