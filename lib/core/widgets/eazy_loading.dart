import 'package:QuickDo/core/contants/app_colors.dart';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
class EasyLoadingClass{

  static  getStyleEasyLoading() {
    EasyLoading.instance
      ..displayDuration = const Duration(milliseconds: 2000)
      ..indicatorType = EasyLoadingIndicatorType.fadingCircle
      ..loadingStyle = EasyLoadingStyle.custom
      ..indicatorSize = 45.0
      ..radius = 10.0
      ..progressColor = AppColors.primaryColor
      ..backgroundColor = AppColors.white
      ..indicatorColor = AppColors.white
      ..textColor = AppColors.primaryColor
      ..maskColor = AppColors.primaryColor.withOpacity(0.5)
      ..userInteractions = true
      ..dismissOnTap = false
      ..indicatorWidget = Padding(
        padding: const EdgeInsets.all(8.0),
        child: CircularProgressIndicator(
          color: AppColors.primaryColor,
          strokeWidth: 2,
        ),
      )
      ..infoWidget = Icon(Icons.info_outline, color: AppColors.primaryColor,size: 25,)
      ..errorWidget = Icon(Icons.close, color: AppColors.primaryColor,size: 25)
      ..successWidget = Icon(Icons.done, color: AppColors.primaryColor,size: 25)
      ..customAnimation = CustomAnimation();

  }
}

class CustomAnimation extends EasyLoadingAnimation {
  CustomAnimation();

  @override
  Widget buildWidget(
      Widget child,
      AnimationController controller,
      AlignmentGeometry alignment,
      ) {
    return Opacity(
      opacity: controller.value,
      child: RotationTransition(
        turns: controller,
        child: child,
      ),
    );
  }
}