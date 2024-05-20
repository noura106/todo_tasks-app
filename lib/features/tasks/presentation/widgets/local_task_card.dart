import 'package:QuickDo/core/contants/app_colors.dart';
import 'package:QuickDo/core/contants/app_theme.dart';
import 'package:QuickDo/core/utils/size_config.dart';
import 'package:QuickDo/core/widgets/custom_sheet.dart';
import 'package:QuickDo/features/tasks/data/models/task_model.dart';
import 'package:QuickDo/features/tasks/presentation/widgets/delete_task_sheet.dart';
import 'package:QuickDo/features/tasks/presentation/widgets/edit_task_sheet.dart';
import 'package:flutter/material.dart';

class LocalTaskCard extends StatelessWidget {
  const LocalTaskCard(this.task, {Key? key}) : super(key: key);
  final Task task;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
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
            color: _getBGClr(task.color),
          ),
          child: Row(
            children: [
              Expanded(
                  child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          ' ${task.title}',
                          style: AppTheme.headline2
                              .copyWith(color: AppColors.white),
                        ),
                        Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                CustomSheet.show(
                                    child: EditTaskSheet(
                                      taskId: task.id!,
                                      fromDataBase: true,
                                    ),
                                    title: 'Mark Task as Completed',
                                    context: context);
                              },
                              icon: Icon(
                                Icons.edit,
                                size: 15,
                              ),
                              color: AppColors.white,
                            ),
                            IconButton(
                              onPressed: () {
                                CustomSheet.show(
                                    child: DeleteTaskSheet(
                                   task: task,
                                    ),
                                    title: 'Delete Task',
                                    context: context);
                              },
                              icon: Icon(
                                Icons.delete,
                                size: 15,
                              ),
                              color: AppColors.white,
                            )
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.access_alarm_rounded,
                          color: Colors.grey[200],
                          size: 18,
                        ),
                        const SizedBox(
                          width: 12,
                        ),
                        Text(
                          '${task.startTime} _ ${task.endTime}',
                          style: AppTheme.bodyText1
                              .copyWith(color: AppColors.offWhite2),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    task.note == null
                        ? Container()
                        : Row(
                            children: [
                              Text(task.note.toString(),
                                  style: AppTheme.bodyText2
                                      .copyWith(color: AppColors.white)),
                            ],
                          ),
                  ],
                ),
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
                  task.isCompleted == 0 ? 'TODO' : 'Completed',
                  style: AppTheme.bodyText2.copyWith(color: AppColors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _getBGClr(int? color) {
    switch (color) {
      case 0:
        return AppColors.bluishClr;
      case 1:
        return AppColors.pinkClr;
      case 2:
        return AppColors.orangeClr;
      default:
        return AppColors.bluishClr;
    }
  }
}
