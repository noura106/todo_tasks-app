

import 'package:QuickDo/core/core_model/base_params.dart';
import 'package:QuickDo/core/newtwork/result.dart';
import 'package:QuickDo/core/use_cases/base_use_case.dart';
import 'package:QuickDo/features/tasks/data/models/to_do_model.dart';
import 'package:QuickDo/features/tasks/data/task_repo/task_repository.dart';

class DeleteTaskParams extends BaseParams {
  final int taskId;
  DeleteTaskParams({required this.taskId});

}

class DeleteTaskUseCase extends BaseUseCase<ToDoModel, DeleteTaskParams> {
  final TaskRepository repository;

  DeleteTaskUseCase(this.repository);

  @override
  Future<Result<ToDoModel>> call({required DeleteTaskParams params}) {
    return repository.deleteTask(params: params);
  }
}
