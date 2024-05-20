import 'package:flutter/material.dart';
class Keys {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  static final scaffoldKey = GlobalKey<ScaffoldState>();
}
class AppConstants{
  static const Map<String, Locale> languages = {
    'ar': Locale('ar'),
    'en': Locale('en'),
  };
  static Locale defaultLocal=Locale("en");

}