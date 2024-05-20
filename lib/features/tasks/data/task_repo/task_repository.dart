import 'package:QuickDo/core/contants/app_eums.dart';
import 'package:QuickDo/core/core_repository/core_repository.dart';
import 'package:QuickDo/core/newtwork/api_urls.dart';
import 'package:QuickDo/core/newtwork/remote_data_source.dart';
import 'package:QuickDo/core/newtwork/result.dart';
import 'package:QuickDo/features/tasks/data/models/to_do_model.dart';
import 'package:QuickDo/features/tasks/use_cases/delete_task_use_case.dart';
import 'package:QuickDo/features/tasks/use_cases/edit_task_use_case.dart';
import 'package:QuickDo/features/tasks/use_cases/get_all_tasks_use_case.dart';
import 'package:QuickDo/features/tasks/use_cases/get_my_tasks_use_case.dart';

class TaskRepository extends CoreRepository {
  Future<Result<List<ToDoModel>>> getMyTask(
      {required GetMyTaskParams params}) async {
    final result = await RemoteDataSource.request(
        withAuthentication: true,
        queryParameters: params.toJson(),
        url: ApiURLs.getMyTasks(params.userId),
        method: HttpMethods.GET,
        converter: (json) => ToDoResponse.fromJson(json),
        responseStr: 'myTasksResponse');
    return paginatedCall(result: result);
  }

  Future<Result<List<ToDoModel>>> getAllTasks(
      {required GetAllTasksParams params}) async {
    final result = await RemoteDataSource.request(
        withAuthentication: true,
        url: ApiURLs.getAllTasks,
        method: HttpMethods.GET,
        queryParameters: params.toJson(),
        converter: (json) => ToDoResponse.fromJson(json),
        responseStr: 'allTaskResponse');
    return paginatedCall(result: result);
  }

  Future<Result<ToDoModel>> deleteTask(
      {required DeleteTaskParams params}) async {
    final result = await RemoteDataSource.request(
        withAuthentication: true,
        url: ApiURLs.deleteTaskById(params.taskId),
        method: HttpMethods.DELETE,
        converter: (json) => DeleteToDoResponse.fromJson(json),
        responseStr: 'deleteTask');
    return call(result: result);
  }
  Future<Result<ToDoModel>> updateTask(
      {required EditTaskParams params}) async {
    final result = await RemoteDataSource.request(
        withAuthentication: true,
        url: ApiURLs.updateTask(params.taskId),
        method: HttpMethods.PUT,
        data: params.toJson(),
        converter: (json) => DeleteToDoResponse.fromJson(json),
        responseStr: 'UpdateTaskResponse');
    return call(result: result);
  }
}
