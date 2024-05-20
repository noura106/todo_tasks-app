import 'package:QuickDo/core/contants/app_colors.dart';
import 'package:QuickDo/core/widgets/buttons/rounded_animation_btn.dart';
import 'package:flutter/material.dart';

class GeneralErrorWidget extends StatefulWidget {
  final VoidCallback? onTap;
  Widget? body;
  final error;
  final String? message;
  final String? buttonText;
  final double? paddingText;

  GeneralErrorWidget({Key? key, this.onTap, this.message, this.body, this.error, this.buttonText, this.paddingText})
      : super(key: key);

  @override
  _GeneralErrorWidgetState createState() => _GeneralErrorWidgetState();
}

class _GeneralErrorWidgetState extends State<GeneralErrorWidget> {

  @override
  Widget build(BuildContext context) {

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          widget.body ?? Container(),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.4,
            child: RoundedAnimatedButton(
              onPressed: widget.onTap,
              text: widget.buttonText ?? 'try again',
              color: AppColors.primaryBarColor,
              textStyle: const TextStyle(color: Colors.white),
            ),
          )
        ],
      ),
    );
  }
}
