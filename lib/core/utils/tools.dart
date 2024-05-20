import 'package:QuickDo/core/contants/app_colors.dart';
import 'package:QuickDo/core/contants/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Tool{
  static void showToast(String message, BuildContext context) async {
    var x = ScaffoldMessenger.maybeOf(context);

    if (x != null) {
      x.showSnackBar(SnackBar(
        content: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
          child: Text(
            message,
            style: AppTheme.bodyText3.copyWith(
              color: AppColors.white,
            ),
          ),
        ),
        // width: MediaQuery.of(context).size.width*0.7,
        backgroundColor: AppColors.primaryLightBarColor,
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(32),
        elevation: 30,
        showCloseIcon: true,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
        dismissDirection: DismissDirection.startToEnd,
        duration: const Duration(seconds: 1),
        closeIconColor: Colors.white,
      ));
    } else {
      await Fluttertoast.showToast(
          textColor: AppColors.white,
          backgroundColor: AppColors.primaryBarColor,
          fontSize: 14,
          toastLength: Toast.LENGTH_LONG,
          msg: message,
          gravity: ToastGravity.CENTER
        // toastLength: Toast.LENGTH_LONG,
      );
    }
  }
}