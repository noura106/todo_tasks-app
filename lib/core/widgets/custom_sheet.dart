import 'package:QuickDo/core/contants/app_colors.dart';
import 'package:QuickDo/core/contants/app_theme.dart';
import 'package:flutter/material.dart';

class CustomSheet<T> extends StatelessWidget {
  const CustomSheet._(
      {Key? key,
        required this.child,
        this.title,
        this.context,
        this.onClose,
        this.closeButtonColor,
        this.headerStyle,
        this.isDismissible,
        this.topTitle})
      : super(key: key);

  final Widget child;
  final String? title;
  final Color? closeButtonColor;
  final TextStyle? headerStyle;
  final ValueChanged<BuildContext>? onClose;
  final bool? isDismissible;
  final double? topTitle;
  final BuildContext? context;

  static Future<T?> show<T>({
    BuildContext? context,
    required Widget child,
    String? title,
    bool addHeader = true,
    ValueChanged<BuildContext>? onClose,
    Color? closeButtonColor,
    TextStyle? headerStyle,
    double? topTitle,
    bool isDismissible = true,
  }) =>
      showModalBottomSheet<T>(elevation: 1,
        context: context!,
        enableDrag: true,
        isDismissible: isDismissible,
        isScrollControlled: true,
        barrierColor: Colors.transparent,
        //overlay color
        backgroundColor: AppColors.white,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20.0))),
        builder: (_) => CustomSheet._(
          context: context,
          title: title,
          onClose: onClose,
          closeButtonColor: closeButtonColor,
          headerStyle: headerStyle,
          child: child,
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 16,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 5,
                width: 80,
                decoration: BoxDecoration(
                    color: AppColors.black,
                    borderRadius: BorderRadius.circular(12)
                ),
              )
            ],
          ),
          if (title != null)
            Padding(
              padding: const EdgeInsets.only(top: 12, bottom: 12,right: 16,left: 16),
              child: Text(
                title!,
                style: AppTheme.headline2,
              ),
            ),
          Flexible(
            child: SingleChildScrollView(child: child),
          ),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }

  Widget? closeWidget() => null;
}
