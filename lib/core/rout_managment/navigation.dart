import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class Navigation {
  static Future popThenPush(BuildContext context, Widget page) async {
    Navigation.pop(context);
    return await Navigation.push(context, page);
  }

  static Future push(
      BuildContext context, Widget page) async {
    return await Navigator.of(context).push(
        PageTransition(
          type: PageTransitionType.leftToRight,
          duration: Durations.medium1,
          child: page,
          curve: Curves.ease,
          opaque: false,
          reverseDuration: Durations.short4,
        )
      // platformPageRoute(
      //   context: context,
      //   builder: (context) => page,
      // ),
    );
  }

  static bool canPop(BuildContext context, {dynamic value}) {
    return Navigator.canPop(context);
  }

  static pop(BuildContext context, {dynamic value}) {
    if (Navigator.canPop(context)) {
      Navigator.pop(context, value);
    }
  }

  static popAll(BuildContext context, {dynamic value}) {
    while (Navigator.canPop(context)) {
      Navigator.pop(context, value);
    }
  }

  static pushReplacement(BuildContext context, Widget page) {
    Navigator.pushReplacement(
        context,
        PageTransition(
          type: PageTransitionType.leftToRightWithFade,
          duration: Durations.short2,
          child: page,
          curve: Curves.ease,
          opaque: false,
          reverseDuration: Durations.short2,
        )
      // platformPageRoute(
      //   context: context,
      //   builder: (context) => page,
      // ),
    );
  }

  static pushAndRemoveUntil(BuildContext context, Widget page) async {
    return await Navigator.of(context).pushAndRemoveUntil(
        PageTransition(
          type: PageTransitionType.leftToRightWithFade,
          duration: Durations.short2,
          child: page,
          curve: Curves.ease,
          opaque: false,
          reverseDuration: Durations.short2,
        ),
            (Route<dynamic> route) => false);
  }
}
