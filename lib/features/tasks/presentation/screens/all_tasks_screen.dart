import 'package:QuickDo/core/contants/app_colors.dart';
import 'package:QuickDo/core/contants/app_theme.dart';
import 'package:QuickDo/core/state_managment/pagination/widgets/PaginationList.dart';
import 'package:QuickDo/features/tasks/data/models/to_do_model.dart';
import 'package:QuickDo/features/tasks/data/task_repo/task_repository.dart';
import 'package:QuickDo/features/tasks/presentation/widgets/task_widget.dart';
import 'package:QuickDo/features/tasks/use_cases/get_all_tasks_use_case.dart';
import 'package:flutter/material.dart';

class AllTasksScreen extends StatelessWidget {
  const AllTasksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PaginationList<ToDoModel>(
      titleWidget: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Text(
          'All Tasks',
          style: AppTheme.headline6.copyWith(fontSize: 22)
        ),
      ),
      paddingTextErrorWidget: 4,
      withPagination: true,
      repositoryCallBack: (model) async {
        return await GetAllTasksUseCase(TaskRepository())
            .call(params: GetAllTasksParams(model));
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
