import 'package:QuickDo/core/contants/app_assets.dart';
import 'package:QuickDo/core/contants/app_colors.dart';
import 'package:QuickDo/core/contants/app_theme.dart';
import 'package:QuickDo/core/rout_managment/navigation.dart';
import 'package:QuickDo/core/widgets/buttons/main_elevated_button.dart';
import 'package:QuickDo/core/widgets/images/custom_image.dart';
import 'package:QuickDo/features/auth/presentation/screens/login_screen.dart';
import 'package:flutter/material.dart';

class MainIntro extends StatelessWidget {
  const MainIntro({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: CustomImage.rectangle(
                isNetworkImage: false,
                image: AppAssets.introImage,
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.4,
              ),
            ),
            Text(
              'Task Management && To-Do List',
              style:
                  AppTheme.headline6.copyWith(color: AppColors.secondaryColor),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 10,
            ),
            MainElevatedButton(onPressed: ()=>Navigation.pushAndRemoveUntil(context, LoginScreen()), text: 'Get Started'),
          ],
        ),
      ),
    );
  }
}
