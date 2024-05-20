

import 'package:QuickDo/core/core_model/base_params.dart';
import 'package:QuickDo/core/newtwork/result.dart';
import 'package:QuickDo/core/state_managment/pagination/models/GetListRequest.dart';
import 'package:QuickDo/core/use_cases/base_use_case.dart';
import 'package:QuickDo/features/tasks/data/models/to_do_model.dart';
import 'package:QuickDo/features/tasks/data/task_repo/task_repository.dart';

class GetMyTaskParams extends BaseParams {
  final int userId;
  final GetListRequest getListRequest;
  GetMyTaskParams({required this.userId,required this.getListRequest});
  toJson(){
    Map<String,dynamic> data={};
    data.addAll(getListRequest.toJson());
  }

}

class GetMyTasksUseCase extends BaseUseCase<List<ToDoModel>, GetMyTaskParams> {
  final TaskRepository repository;

  GetMyTasksUseCase(this.repository);

  @override
  Future<Result<List<ToDoModel>>> call({required GetMyTaskParams params}) {
    return repository.getMyTask(params: params);
  }
}
