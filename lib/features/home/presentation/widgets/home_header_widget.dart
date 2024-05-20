import 'dart:convert';

import 'package:QuickDo/core/contants/app_colors.dart';
import 'package:QuickDo/core/contants/app_theme.dart';
import 'package:QuickDo/core/storage/storage_handler.dart';
import 'package:QuickDo/core/utils/size_config.dart';
import 'package:QuickDo/core/widgets/images/custom_image.dart';
import 'package:QuickDo/features/auth/data/models/login_model.dart';
import 'package:QuickDo/features/tasks/presentation/controllers/task_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeHeaderWidget extends StatelessWidget {
  final int currentIndex;
  HomeHeaderWidget({super.key,required this.currentIndex});

  final userdata =
      LoginModel.fromJson(json.decode(StorageHandler.getUserData()));

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                width: 75,
                height: 75,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border:
                        Border.all(color: AppColors.primaryColor, width: 2)),
                child: CustomImage.circular(
                  radius: 75,
                  fit: BoxFit.cover,
                  image: userdata.image,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Hello',
                      style: AppTheme.headline5.copyWith(fontSize: 20),
                    ),
                    Text(
                      '${userdata.firstName} ${userdata.lastName}',
                      style: AppTheme.headline5,
                    ),
                  ],
                ),
              )
            ],
          ),
        currentIndex==2?  IconButton(
            onPressed: () {
              Provider.of<TaskController>(context,listen: false).deleteAllTasks();
            },
            icon: Icon(
              color: AppColors.primaryColor,
              Icons.cleaning_services_outlined,
              size: 24,
            ),
          ):SizedBox.shrink(),
        ],
      ),
    );
  }
}
