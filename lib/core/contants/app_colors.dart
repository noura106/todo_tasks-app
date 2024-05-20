import 'dart:math';

import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  static const Map<int, Color> primarySwatch = {
    50: Color(0xFFE4ECF4),
    100: Color(0xFFBBCEE3),
    150:Color(0xFF4297C8),
    200: Color(0xFF8DAED0),
    250: Color(0xFF2867AD),
    300: Color(0xFF5F8EBD),
    400: Color(0xFF3D75AF),
    500: Color(0xFF1b5da1),
    600: Color(0xFF185599),
    700: Color(0xFF144B8F),
    800: Color(0xFF104185),
    900: Color(0xFF083074),
    1000:Color(0xFF0E3692),
  };
  static const Map<int, Color> secondaryMaterial = {
    1: Color(0xFFFCF4F1),
    5: Color(0xFFFDF4EC),
    10: Color(0xFFFCF2E6),
    25: Color(0xFFFCEAC5),
    50: Color(0xFFFCD38A),
    100: Color(0xFFFCC954),
    200: Color(0xFFFFC947),
    300: Color(0xFFFFC947),
    400: Color(0xFFFFC947),
    500: Color(0xFFFFC947),
    600: Color(0xFFE0A818),
    700: Color(0xFFC48E0A),
    800: Color(0xFF9A6C00),
    900: Color(0xFF503904),
  };

  static const primaryBarColor = Color(0xFF244D80);
  static const homePageTest = Color(0xFFF4F2EE);
  static const homePageTest2 = Color(0xFFF0F2F5);
  static const primaryMidBarColor = Color(0xFF244D80);
  static const primaryLightBarColor = Color(0xFF567FB3);
  static const primaryLightColor = Color(0xFF567FB3);
  static const primaryIconsColor = Color(0xFF567FB3);



  static const primaryColor = Color(0xFF244D80);
  static const Color bluishClr = Color(0xFF4e5ae8);
  static const Color orangeClr = Color(0xCFFF8746);
  static  const Color pinkClr = Color(0xFFff4667);
  static const secondaryColor = Color(0xFFFB9A0B);
  static const lightBlueColor = Color(0xFF567FB3);
  static const blueColor = Color(0xFF1497E5);
  static const textBlue = Color(0xFF0A66C2);
  static const babyBlue = Color(0xFFF0F6FE);
  static const extraLightBlueColor = Color(0xFF138ED7);
  static const cyan = Color(0xFFC5E9FF);
  static const commentBackgroundColor = Color(0xFFF0F6FE);


  static const red = Color(0xFFCC1016);
  static const green = Color(0xFF42D744);
  static const darkGreen = Color(0xFF2F9A48);
  static const lightGreen = Color(0xFFE4FFDA);

  static const white = Colors.white;
  static const black = Colors.black;
  static const transparent = Colors.transparent;

  static const offWhite = Color(0xFFF5F5F5);
  static const grey = Color(0xFF737373);
  static const textFieldFillColor = Color(0xFFF6F6F6);
  static const lightGrey = Color(0xFF9D9D9D);
  static const extraLightGrey = Color(0xFFD9D9D9);
  static const textGreyLight = Color(0xFFB1B1B1);
  static const textGreyDark = Color(0xFF616871);
  static const offWhite2 = Color(0xFFFFF7F2);


  static Color getRandomColor() {
    return Color.fromRGBO(Random().nextInt(300), Random().nextInt(300),
        Random().nextInt(300), 0.5);
  }
}
