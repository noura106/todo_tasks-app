import 'package:QuickDo/core/contants/app_assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ImagePlaceHolder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      AppAssets.personSvg,
      fit: BoxFit.cover,
    );
  }
}
