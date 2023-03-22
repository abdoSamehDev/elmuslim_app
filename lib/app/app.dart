import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:islamic_app/app/app_prefs.dart';
import 'package:islamic_app/app/di.dart';
import 'package:islamic_app/presentation/resources/routes_manager.dart';
import 'package:islamic_app/presentation/resources/theme.dart';

class MyApp extends StatefulWidget {
  // const MyApp({Key? key}) : super(key: key);

  //named constructor
  const MyApp._internal();

  //singleton
  static const MyApp _instance = MyApp._internal();

  //factory
  factory MyApp() => _instance;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  final AppPreferences _preferences = instance<AppPreferences>();


  @override
  void didChangeDependencies() {
    _preferences.getAppLocale().then((locale) => context.setLocale(locale));
    super.didChangeDependencies();


  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      darkTheme: getApplicationLDarkTheme(),
      theme: getApplicationLightTheme(),
      themeMode: ThemeMode.system,
      onGenerateRoute: RoutesGenerator.getRoute,
      initialRoute: Routes.homeRoute,
    );
  }
}
