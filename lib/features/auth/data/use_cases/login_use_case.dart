

import 'package:QuickDo/core/core_model/base_params.dart';
import 'package:QuickDo/core/newtwork/result.dart';
import 'package:QuickDo/core/use_cases/base_use_case.dart';
import 'package:QuickDo/features/auth/data/models/login_model.dart';
import 'package:QuickDo/features/auth/data/repsitory/auth_repository.dart';

class LogInParams extends BaseParams {
  LogInParams({
    this.expiresInMins,
    this.username,
    this.password,
  });

  final int? expiresInMins;
  final String? username;
  final String? password;

  toJson() {
    Map<String, dynamic> queryParams = {};
    if (expiresInMins != null) {
      queryParams.putIfAbsent("rememberClient", () => expiresInMins);
    }
    queryParams.putIfAbsent("username", () => username);
    queryParams.putIfAbsent("password", () => password);
    return queryParams;
  }
}

class LoginUseCase extends BaseUseCase<LoginModel, LogInParams> {
  final AuthRepository repository;

  LoginUseCase(this.repository);

  @override
  Future<Result<LoginModel>> call({required LogInParams params}) {
    return repository.login(params: params);
  }
}
