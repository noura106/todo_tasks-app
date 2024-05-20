import 'package:QuickDo/core/contants/app_colors.dart';
import 'package:QuickDo/core/contants/app_theme.dart';
import 'package:QuickDo/core/state_managment/create_model/cubits/create_model_cubit.dart';
import 'package:QuickDo/core/state_managment/create_model/widgets/CreateModel.dart';
import 'package:QuickDo/core/utils/size_config.dart';
import 'package:QuickDo/core/utils/tools.dart';
import 'package:QuickDo/core/widgets/custom_sheet.dart';
import 'package:QuickDo/features/tasks/data/models/to_do_model.dart';
import 'package:QuickDo/features/tasks/data/task_repo/task_repository.dart';
import 'package:QuickDo/features/tasks/presentation/widgets/edit_task_sheet.dart';
import 'package:QuickDo/features/tasks/use_cases/delete_task_use_case.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TaskWidget extends StatefulWidget {
  final ToDoModel toDoModel;

  TaskWidget({super.key, required this.toDoModel});

  @override
  State<TaskWidget> createState() => _TaskWidgetState();
}

class _TaskWidgetState extends State<TaskWidget> {
  late CreateModelCubit deleteTaskCubit;

  @override
  Widget build(BuildContext context) {
    return !(widget.toDoModel.isDeleted ?? false)
        ? Container(
            padding: EdgeInsets.symmetric(
              horizontal: getProportionateScreenWidth(
                  SizeConfig.orientation == Orientation.landscape ? 8 : 20),
            ),
            width: SizeConfig.orientation == Orientation.landscape
                ? SizeConfig.screenWidth / 2
                : SizeConfig.screenWidth,
            margin: EdgeInsets.only(bottom: getProportionateScreenHeight(12)),
            child: Container(
              padding: const EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: AppColors.offWhite2,
              ),
              child: Row(
                children: [
                  Expanded(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width:MediaQuery.of(context).size.width*0.7,
                        child: Text(
                          ' ${widget.toDoModel.name}',
                          style: AppTheme.headline3
                              .copyWith(color: AppColors.black),
                          textAlign: TextAlign.start,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      CreateModel<ToDoModel>(
                        onSuccess: (model) {
                          Tool.showToast(
                              'Task Has been deleted successfully', context);
                          setState(() {
                            widget.toDoModel.isDeleted = true;
                          });
                        },
                        onCubitCreated: (cubit) => deleteTaskCubit = cubit,
                        withValidation: true,
                        useCaseCallBack: (_) async {
                          return await DeleteTaskUseCase(TaskRepository()).call(
                              params: DeleteTaskParams(
                                  taskId: widget.toDoModel.id!));
                        },
                        child: InkWell(
                          onTap: () {
                            deleteTaskCubit.createModel(
                                requestData: DeleteTaskParams(
                                    taskId: widget.toDoModel.id!));
                          },
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.delete,
                                color: AppColors.red,
                                size: 18,
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                'delete Task',
                                style: AppTheme.bodyText1
                                    .copyWith(color: AppColors.red),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      InkWell(
                        onTap: () {
                          CustomSheet.show(
                              closeButtonColor: AppColors.black,
                              title: 'Edit Task',
                              context: context,
                              child: EditTaskSheet(
                                taskId: widget.toDoModel.id!,
                                isActive: widget.toDoModel.isCompleted,
                              ));
                        },
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.edit,
                              color: AppColors.textGreyDark,
                              size: 18,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              'edit task',
                              style: AppTheme.bodyText1
                                  .copyWith(color: AppColors.textGreyDark),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    height: 60,
                    width: 0.5,
                    color: Colors.grey[400],
                  ),
                  RotatedBox(
                    quarterTurns: 3,
                    child: Text(
                      !widget.toDoModel.isCompleted! ? 'TODO' : 'Completed',
                      style: AppTheme.bodyText1
                          .copyWith(color: AppColors.secondaryColor),
                    ),
                  ),
                ],
              ),
            ),
          )
        : SizedBox.shrink();
  }
}
