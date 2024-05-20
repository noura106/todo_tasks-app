import 'package:QuickDo/core/contants/app_colors.dart';
import 'package:QuickDo/core/contants/app_theme.dart';
import 'package:QuickDo/core/rout_managment/navigation.dart';
import 'package:QuickDo/core/widgets/buttons/main_elevated_button.dart';
import 'package:QuickDo/features/tasks/presentation/screens/add_task_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class AddToDoBar extends StatelessWidget {
  const AddToDoBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                DateFormat.yMMMMd().format(DateTime.now()),
                style: AppTheme.headline6.copyWith(color: AppColors.secondaryColor),
              ),
              Text(
                'Today',
                style: AppTheme.headline5
                  ..copyWith(color: AppColors.black, fontSize: 30),
              ),
            ],
          ),
        ),
        MainElevatedButton(
          onPressed: () {
            Navigation.push(context, AddTaskScreen());
          },
          text: 'Add TO-DO',
          defaultWidth: false,
          isSmall: true,
          widthRatio: 4,
          textMargin: EdgeInsets.symmetric(horizontal: 10),
          height: 35,
        )
      ],
    );
  }
}
