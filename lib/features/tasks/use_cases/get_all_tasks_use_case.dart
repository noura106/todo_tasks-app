

import 'package:QuickDo/core/core_model/base_params.dart';
import 'package:QuickDo/core/newtwork/result.dart';
import 'package:QuickDo/core/state_managment/pagination/models/GetListRequest.dart';
import 'package:QuickDo/core/use_cases/base_use_case.dart';
import 'package:QuickDo/features/tasks/data/models/to_do_model.dart';
import 'package:QuickDo/features/tasks/data/task_repo/task_repository.dart';

class GetAllTasksParams extends BaseParams {
  final GetListRequest getListRequest;
  GetAllTasksParams(this.getListRequest);
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data.addAll(getListRequest.toJson());
    return data;
  }

}

class GetAllTasksUseCase extends BaseUseCase<List<ToDoModel>, GetAllTasksParams> {
  final TaskRepository repository;

  GetAllTasksUseCase(this.repository);

  @override
  Future<Result<List<ToDoModel>>> call({required GetAllTasksParams params}) {
    return repository.getAllTasks(params: params);
  }
}
