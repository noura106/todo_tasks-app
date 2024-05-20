import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

var customFooter = CustomFooter(
  builder: (BuildContext? context, LoadStatus? mode) {
    Widget body;
    if (mode == LoadStatus.idle) {
      body = Text("pull_up_load".tr());
    } else if (mode == LoadStatus.loading) {
      body = const CupertinoActivityIndicator();
    } else if (mode == LoadStatus.failed) {
      body = Text("Load_Failed!".tr());
    } else if (mode == LoadStatus.canLoading) {
      body = Text("release_to_load_more".tr());
    } else {
      body = Text("No_more_data".tr());
    }
    return SizedBox(
      height: 55.0,
      child: Center(child: body),
    );
  },
);
