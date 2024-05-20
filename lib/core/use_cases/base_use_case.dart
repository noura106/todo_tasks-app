

import 'package:QuickDo/core/newtwork/result.dart';

abstract class BaseUseCase<Type, Params > {
  Future<Result<Type>> call({required Params params});
}