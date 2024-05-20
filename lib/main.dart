import 'package:QuickDo/core/contants/app_colors.dart';
import 'package:QuickDo/core/contants/app_contants.dart';
import 'package:QuickDo/core/contants/app_theme.dart';
import 'package:QuickDo/core/storage/data_base_helper.dart';
import 'package:QuickDo/core/storage/storage_handler.dart';
import 'package:QuickDo/core/widgets/eazy_loading.dart';
import 'package:QuickDo/features/home/presentation/screens/home_screen.dart';
import 'package:QuickDo/features/intro/presentation/screens/main_intro.dart';
import 'package:QuickDo/features/splash/presentation/screens/splash_screen.dart';
import 'package:QuickDo/features/tasks/presentation/controllers/task_controller.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:provider/provider.dart';
import 'package:yaml/yaml.dart';

String? buildNumber;

Future<String> getAppVersion() async {
  final yamlString = await rootBundle.loadString('pubspec.yaml');
  final parsedYaml = loadYaml(yamlString);
  return parsedYaml['version'];
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await StorageHandler.init();
  await DBHelper.initDb();
  final String versionNumber = await getAppVersion();
  buildNumber = versionNumber.split("+")[1];
  StorageHandler.writeVersionNumber(buildNumber);
  StorageHandler.writeVersion(versionNumber.split("+")[0]);
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    //  systemNavigationBarColor: Colors.blue, // navigation bar color
    statusBarColor: AppColors.primaryBarColor, // status bar color
  ));

  runApp(
    EasyLocalization(
      supportedLocales: AppConstants.languages.values.toList(),
      path: 'assets/locales',
      fallbackLocale: const Locale('en'),
      startLocale: Locale(StorageHandler.getLanguage()),
      saveLocale: true,
      child: Phoenix(
          child: ChangeNotifierProvider(
              create: (BuildContext context) => TaskController()..getTasks(),
              child: MyApp())),
    ),
  );
}

class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    EasyLoadingClass.getStyleEasyLoading();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.appTheme,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: AppConstants.languages.values.toList(),
      builder: EasyLoading.init(),
      locale: context.locale,
      navigatorKey: Keys.navigatorKey,
      home: Splash(navigator: _getNextPage()),
    );
  }
}

_getNextPage() {
  if (StorageHandler().hasToken) {
    return HomeScreen();
  } else {
    return const MainIntro();
  }
}
