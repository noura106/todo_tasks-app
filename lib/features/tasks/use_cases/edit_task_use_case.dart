

import 'package:QuickDo/core/core_model/base_params.dart';
import 'package:QuickDo/core/newtwork/result.dart';
import 'package:QuickDo/core/use_cases/base_use_case.dart';
import 'package:QuickDo/features/tasks/data/models/to_do_model.dart';
import 'package:QuickDo/features/tasks/data/task_repo/task_repository.dart';

class EditTaskParams extends BaseParams {
  final String?name;
  final int taskId;
  final bool?isCompleted;
  EditTaskParams({ this.name, this.isCompleted,required this.taskId});
  toJson(){
    Map<String,dynamic> data={};
    if(name!=null) data.putIfAbsent('todo', () => name);
    if(isCompleted!=null) data.putIfAbsent('completed', () => isCompleted);
    return data;
  }

}

class EditTaskUseCase extends BaseUseCase<ToDoModel, EditTaskParams> {
  final TaskRepository repository;

  EditTaskUseCase(this.repository);

  @override
  Future<Result<ToDoModel>> call({required EditTaskParams params}) {
    return repository.updateTask(params: params);
  }
}
