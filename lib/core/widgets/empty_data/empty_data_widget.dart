

import 'package:QuickDo/core/contants/app_assets.dart';
import 'package:QuickDo/core/widgets/error_widgets/base_error_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../images/custom_image.dart';


class EmptyDataWidget extends StatelessWidget {
  final String? message;

  const EmptyDataWidget({Key? key, this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseErrorWidget(
        onTap: () {},
        title: message ?? 'result_not_found'.tr(),
        subtitle: ''.tr(),
        icon: CustomImage.rectangle(
          image: AppAssets.noData,
          isNetworkImage: false,
          svg: false,
        )
    );
  }
}
