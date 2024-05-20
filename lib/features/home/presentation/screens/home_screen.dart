import 'dart:convert';

import 'package:QuickDo/core/contants/app_assets.dart';
import 'package:QuickDo/core/contants/app_colors.dart';
import 'package:QuickDo/core/contants/app_theme.dart';
import 'package:QuickDo/core/widgets/images/custom_image.dart';
import 'package:QuickDo/features/home/presentation/screens/home_content.dart';
import 'package:QuickDo/features/tasks/presentation/controllers/task_controller.dart';
import 'package:QuickDo/features/tasks/presentation/screens/added_tasks.dart';
import 'package:QuickDo/features/tasks/presentation/screens/all_tasks_screen.dart';
import 'package:QuickDo/features/home/presentation/widgets/add_task_bar.dart';
import 'package:QuickDo/features/home/presentation/widgets/date_picker_home.dart';
import 'package:QuickDo/features/home/presentation/widgets/home_header_widget.dart';
import 'package:QuickDo/features/home/presentation/widgets/tasks_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late int currentIndex;
  List<Widget> pages = [
    const HomeContent(),
    const AllTasksScreen(),
    AddedTasks(),
  ];

  @override
  void initState() {
    currentIndex = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      bottomNavigationBar: Container(
        margin: EdgeInsets.zero,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(color: AppColors.white, boxShadow: [
          BoxShadow(
              color: AppColors.lightGrey,
              offset: Offset(0, 5),
              blurRadius: 7,
              spreadRadius: 0.2)
        ]),
        child: BottomNavigationBar(
          elevation: 5,
          type: BottomNavigationBarType.fixed,
          backgroundColor: AppColors.white,
          showUnselectedLabels: true,
          selectedLabelStyle: AppTheme.headline4.copyWith(
              fontSize: 12,
              color: AppColors.primaryBarColor,
              fontWeight: FontWeight.w700),
          unselectedLabelStyle: AppTheme.headline4
              .copyWith(fontWeight: FontWeight.w300, fontSize: 10),
          unselectedItemColor: AppColors.primaryBarColor,
          selectedItemColor: AppColors.primaryBarColor,
          currentIndex: currentIndex,
          items: [
            _buildNavigationBarItem(
                iconUrl: AppAssets.home,
                activeIconUrl: AppAssets.home,
                label: 'home'),
            _buildNavigationBarItem(
                iconUrl: AppAssets.allTasks,
                activeIconUrl: AppAssets.allTasks,
                label: 'AllTasks'),
            _buildNavigationBarItem(
                iconUrl: AppAssets.addedTasks,
                activeIconUrl: AppAssets.addedTasks,
                label: 'Added Tasks'),
          ],
          onTap: (int index) {
            setState(() {
              currentIndex = index;
            });
          },
          iconSize: 30,
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            HomeHeaderWidget(currentIndex: currentIndex,),
            AddToDoBar(),
            AddDate(),
            Expanded(child: pages[currentIndex])
          ],
        ),
      ),
    );
  }

  _buildNavigationBarItem(
      {required String iconUrl,
      required String activeIconUrl,
      required String label}) {
    return BottomNavigationBarItem(
        backgroundColor: AppColors.white,
        icon: CustomImage.rectangle(
          image: iconUrl,
          svg: true,
          height: 20,
          width: 20,
          color: AppColors.grey,
        ),
        label: label,
        activeIcon: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: CustomImage.rectangle(
            width: 25,
            height: 25,
            image: activeIconUrl,
            svg: true,
            color: AppColors.primaryColor,
          ),
        ));
  }
}
