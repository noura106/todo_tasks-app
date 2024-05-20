import 'package:QuickDo/core/contants/app_colors.dart';
import 'package:QuickDo/core/contants/app_theme.dart';
import 'package:QuickDo/core/widgets/buttons/main_elevated_button.dart';
import 'package:QuickDo/features/tasks/data/models/task_model.dart';
import 'package:QuickDo/features/tasks/presentation/controllers/task_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DeleteTaskSheet extends StatelessWidget {
  final Task task;

  DeleteTaskSheet({super.key, required this.task});

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
                'Do you want to delete this task?',
                style: AppTheme.bodyText2.copyWith(color: AppColors.black),
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
                MainElevatedButton(
                  onPressed: () {
                    Provider.of<TaskController>(context, listen: false)
                        .deleteTasks(task);
                  },
                  text: 'Delete',
                  defaultWidth: false,
                  isSmall: true,
                  widthRatio: 4,
                  textMargin: EdgeInsets.symmetric(horizontal: 10),
                  height: 35,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
