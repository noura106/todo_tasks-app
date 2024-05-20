import 'package:QuickDo/core/contants/app_colors.dart';
import 'package:QuickDo/core/contants/app_theme.dart';
import 'package:QuickDo/core/state_managment/create_model/cubits/create_model_cubit.dart';
import 'package:QuickDo/core/state_managment/create_model/widgets/CreateModel.dart';
import 'package:QuickDo/core/utils/tools.dart';
import 'package:QuickDo/core/utils/validator.dart';
import 'package:QuickDo/core/widgets/buttons/main_elevated_button.dart';
import 'package:QuickDo/core/widgets/text_fields/custom_text_field.dart';
import 'package:QuickDo/features/tasks/data/models/to_do_model.dart';
import 'package:QuickDo/features/tasks/data/task_repo/task_repository.dart';
import 'package:QuickDo/features/tasks/presentation/controllers/task_controller.dart';
import 'package:QuickDo/features/tasks/use_cases/edit_task_use_case.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditTaskSheet extends StatefulWidget {
  final int taskId;
  bool ? isActive;
  bool fromDataBase;

  EditTaskSheet({super.key, required this.taskId, this.isActive,this.fromDataBase=false});

  @override
  State<EditTaskSheet> createState() => _EditTaskSheetState();
}

class _EditTaskSheetState extends State<EditTaskSheet> {
  late CreateModelCubit editTaskCubit;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'make a task completed',
                style: AppTheme.bodyText2.copyWith(color: AppColors.black),
              ),
              Transform.scale(
                scale: 0.9,
                child: Switch(
                  value: widget.isActive ?? false,
                  activeColor: AppColors.primaryColor,
                  thumbColor: MaterialStateProperty.all(AppColors.white),
                  activeTrackColor: AppColors.primaryColor,
                  inactiveThumbColor: AppColors.lightGrey,
                  inactiveTrackColor: AppColors.lightGrey,
                  onChanged: (value) {
                    setState(() {
                      widget.isActive = value;
                    });
                  },
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                MainElevatedButton(
                  onPressed: () => Navigator.of(context).pop(),
                  text: 'cancel',
                  defaultWidth: false,
                  isSmall: true,
                  widthRatio: 4,
                  buttonColor: AppColors.transparent,
                  borderColor: AppColors.grey,
                  textColor: AppColors.grey,
                  textMargin: EdgeInsets.symmetric(horizontal: 10),
                  height: 35,
                ),
                !widget.fromDataBase?CreateModel(
                  onSuccess: (_){
                    Navigator.of(context).pop();
                    Tool.showToast('your task has been updated successfully', context);
                  },
                  useCaseCallBack: (_) async {
                    return await EditTaskUseCase(TaskRepository()).call(
                        params: EditTaskParams(taskId: widget.taskId,
                            isCompleted: widget.isActive));
                  },
                  withValidation: true,
                  onCubitCreated: (cubit) => editTaskCubit = cubit,
                  child: MainElevatedButton(
                    onPressed: () {
                      editTaskCubit.createModel(requestData: EditTaskParams(taskId: widget.taskId,
                          isCompleted: widget.isActive));
                    },
                    text: 'Edit',
                    defaultWidth: false,
                    isSmall: true,
                    widthRatio: 4,
                    textMargin: EdgeInsets.symmetric(horizontal: 10),
                    height: 35,
                  ),
                ):MainElevatedButton(
                  onPressed: () {
                    Provider.of<TaskController>(context,listen: false).markUsCompleted(widget.taskId);
                  },
                  text: 'Edit',
                  defaultWidth: false,
                  isSmall: true,
                  widthRatio: 4,
                  textMargin: EdgeInsets.symmetric(horizontal: 10),
                  height: 35,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
