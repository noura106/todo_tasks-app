import 'package:QuickDo/core/contants/app_theme.dart';
import 'package:QuickDo/core/utils/size_config.dart';
import 'package:QuickDo/core/widgets/animations/fade_animation.dart';
import 'package:QuickDo/features/tasks/presentation/controllers/task_controller.dart';
import 'package:QuickDo/features/tasks/presentation/widgets/local_task_card.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:get/get.dart';

class AddedTasks extends StatefulWidget {
  const AddedTasks({super.key});

  @override
  State<AddedTasks> createState() => _AddedTasksState();
}

class _AddedTasksState extends State<AddedTasks> {
  DateTime _selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return _getALLLocalTasks();
  }

  Future<void> _onRefresh() async {
    Provider.of<TaskController>(context,listen: false).getTasks();
  }

  _getALLLocalTasks() {
    return Obx(() {
      if (Provider.of<TaskController>(context,listen: false).taskList.isEmpty) {
        return Center(
          child: Text(
            'no tasks yet',
            style: AppTheme.headline5,
          ),
        );
      } else {
        return RefreshIndicator(
          onRefresh: _onRefresh,
          child: ListView.builder(
            scrollDirection: SizeConfig.orientation == Orientation.landscape
                ? Axis.horizontal
                : Axis.vertical,
            itemBuilder: (BuildContext context, int index) {
              var task = Provider.of<TaskController>(context).taskList[index];
              if (task.date == DateFormat.yMd().format(_selectedDate) ||
                  task.repeat == 'Daily' ||
                  (task.repeat == 'Weekly' &&
                      _selectedDate
                                  .difference(
                                      DateFormat.yMd().parse(task.date!))
                                  .inDays %
                              7 ==
                          0) ||
                  (task.repeat == 'Monthly' &&
                      _selectedDate.day ==
                          DateFormat.yMd().parse(task.date!).day)) {
                var hour = task.startTime.toString().split(':')[0];
                var minutes = task.startTime.toString().split(':')[1];

                debugPrint('My Time is +' + hour);
                debugPrint('My Minutes is' + minutes);
                DateTime date = DateFormat.jm().parse(task.startTime!);
                String myTime = DateFormat('HH:mm').format(date);
                return FadeAnimation(
                  delay: 1,
                  fadeDirection: FadeDirection.left,
                  child: LocalTaskCard(
                    task,
                  ),
                );
              } else
                return Container();
            },
            itemCount: Provider.of<TaskController>(context).taskList.length,
          ),
        );
      }
    });
  }
}
