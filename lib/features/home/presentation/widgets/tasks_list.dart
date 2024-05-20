import 'dart:convert';

import 'package:QuickDo/core/contants/app_theme.dart';
import 'package:QuickDo/core/state_managment/pagination/widgets/PaginationList.dart';
import 'package:QuickDo/features/auth/data/models/login_model.dart';
import 'package:QuickDo/features/tasks/data/models/to_do_model.dart';
import 'package:QuickDo/features/tasks/data/task_repo/task_repository.dart';
import 'package:QuickDo/features/tasks/presentation/widgets/task_widget.dart';
import 'package:QuickDo/features/tasks/use_cases/get_my_tasks_use_case.dart';
import 'package:flutter/material.dart';

import '../../../../core/storage/storage_handler.dart';

class TasksList extends StatelessWidget {
  TasksList({super.key});

  final userdata =
      LoginModel.fromJson(json.decode(StorageHandler.getUserData()));

  @override
  Widget build(BuildContext context) {
    return PaginationList<ToDoModel>(
      titleWidget: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Text(
            'My Tasks',
            style: AppTheme.headline6.copyWith(fontSize: 22)
        ),
      ),
      paddingTextErrorWidget: 4,
      withPagination: true,
      repositoryCallBack: (model) async {
        return await GetMyTasksUseCase(TaskRepository()).call(
            params:
                GetMyTaskParams(userId: userdata.id!, getListRequest: model));
      },
      listBuilder: (list) {
        return ListView.builder(
          itemCount: list.length,
            padding: EdgeInsets.symmetric(vertical: 10),
            shrinkWrap: true,
            itemBuilder: (context, index) {
          return TaskWidget(toDoModel: list[index]);
        });
      },
    );
  }
}
