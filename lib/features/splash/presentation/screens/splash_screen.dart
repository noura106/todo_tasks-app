import 'package:QuickDo/core/contants/app_assets.dart';
import 'package:QuickDo/core/contants/app_colors.dart';
import 'package:QuickDo/core/contants/app_theme.dart';
import 'package:QuickDo/core/storage/storage_handler.dart';
import 'package:easy_splash_screen/easy_splash_screen.dart';
import 'package:flutter/material.dart';

class Splash extends StatefulWidget {
  final dynamic navigator;

  const Splash({Key? key, this.navigator}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {


  @override
  Widget build(BuildContext context) {
    return EasySplashScreen(
      //backgroundImage: const AssetImage(AppAssets.appLogoURI),
      backgroundColor: AppColors.white,
      logoWidth: 100,title: Text('Quick Do Now',style: AppTheme.headline6,),
      logo: Image.asset(
        AppAssets.appLogo,
        alignment: Alignment.bottomCenter,
      ),
      showLoader: false,
      loaderColor: AppColors.primaryColor,
      loadingText: Text("V " + StorageHandler.getVersion(),
          style: AppTheme.headline5
              .copyWith(color: AppColors.primaryColor, fontWeight: FontWeight.w400)),
      futureNavigator: getFirstScreen(),
    );
  }

//   GetModelCubit? getModelCubit;
  Future<Widget> getFirstScreen() async {
    await Future.delayed(const Duration(seconds: 4));
    return widget.navigator;
  }
}
