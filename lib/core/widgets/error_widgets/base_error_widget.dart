import 'package:QuickDo/core/contants/app_colors.dart';
import 'package:QuickDo/core/contants/app_theme.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class BaseErrorWidget extends StatelessWidget {
  final GestureTapCallback? onTap;
  final String? title;
  final String? subtitle;
  final Widget? icon;

  const BaseErrorWidget(
      {Key? key, this.onTap, this.title, this.subtitle, this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: InkWell(
          onTap: onTap,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(16),
                child: icon,
              ),
              Text(title ?? '-',
                  textAlign: TextAlign.center,
                  style: AppTheme.headline6
                      .copyWith(color: AppColors.primaryColor)),
              Text(
                subtitle ?? 'tap_to_retry'.tr(),
                style: AppTheme.button,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
