
import 'package:QuickDo/core/contants/app_theme.dart';
import 'package:QuickDo/core/utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InputField extends StatelessWidget {
  const InputField({
    Key? key,
    required this.title,
    required this.hint,
    this.controller,
    this.widget,
  }) : super(key: key);
  final String title;
  final String hint;
  final TextEditingController? controller;
  final Widget? widget;

  @override
  Widget build(BuildContext context) {
    return Container(

      //margin: const EdgeInsets.only(top: 2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,style: AppTheme.headline2),
          Container(
            width: SizeConfig.screenWidth,
            height: 52,
            padding: const EdgeInsets.only(left: 14),
            margin: const EdgeInsets.only(top: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: Colors.grey,
              ),
              // color: primaryClr,
            ),
            child: Row(
              children: [
                Expanded(child: TextFormField(
                  cursorColor: Get.isDarkMode ?Colors.grey[100] :Colors.grey[700],
                  controller: controller,
                  readOnly: widget!=null ?true :false,
                  style: AppTheme.bodyText1,
                  autofocus: false,
                  decoration: InputDecoration(
                    hintText: hint,
                    hintStyle: AppTheme.bodyText1,
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: context.theme.backgroundColor,
                        width: 0,
                      ),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: context.theme.backgroundColor,
                        width: 0,
                      ),
                    ),
                  ),
                ),
                ),
                widget ?? Container(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
