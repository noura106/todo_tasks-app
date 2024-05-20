import 'package:QuickDo/core/contants/app_colors.dart';
import 'package:QuickDo/core/contants/app_dimentions.dart';
import 'package:QuickDo/core/contants/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MainElevatedButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String text;
  final Color? textColor;
  final Color? borderColor;
  final Color? buttonColor;
  final bool? isSmall;
  final bool? defaultWidth;
  final bool? withMargin;
  final bool? withHorizontalMargin;
  final double? height;
  final double? width;
  final double? radius;
  final EdgeInsetsGeometry? textMargin;
  final double? fontSize;
  final num? widthRatio;

  const MainElevatedButton(
      {Key? key,
        required this.onPressed,
        required this.text,
        this.textColor,
        this.radius,
        this.textMargin,
        this.widthRatio,
        this.defaultWidth=false,
        this.buttonColor,
        this.borderColor=Colors.transparent,
        this.withHorizontalMargin=true,
        this.withMargin = true,
        this.isSmall = false,
        this.height,
        this.fontSize,
        this.width})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap:onPressed ,
      child: Container(
          margin:
          EdgeInsets.symmetric(horizontal:withHorizontalMargin!? 16:0, vertical: withMargin! ? 8 : 0),
          width:defaultWidth!?null: isSmall!
              ? widthRatio==null?AppDimension.screenWidth(context) / 3:AppDimension.screenWidth(context)/widthRatio!
              : AppDimension.screenWidth(context),
          padding: defaultWidth!?const EdgeInsets.symmetric(horizontal: 6,vertical: 2):null,
          decoration:
          BoxDecoration(

              border: Border.all(color: borderColor!),
              borderRadius: BorderRadius.circular(radius??100.0),
              color: buttonColor,
              gradient:buttonColor == null?const LinearGradient(begin:Alignment.centerLeft ,end:Alignment.centerRight ,
                  colors: [AppColors.primaryMidBarColor, AppColors.primaryLightBarColor]):null)
          ,
          height: height ?? 45,
          child: Center(child: Container(margin: textMargin,child: Text(text, style: AppTheme.button.copyWith(color: textColor,fontSize:fontSize))))
      ),
    );
  }
}
