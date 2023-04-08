import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:elmuslim_app/app/utils/di.dart';
import 'package:elmuslim_app/presentation/home/view/home_view.dart';
import 'package:elmuslim_app/presentation/resources/strings_manager.dart';

class Routes {
  static const String homeRoute = "/";
  static const String testRoute = "/test";
  static const String quranRoute = "/quran";
  static const String hadithRoute = "/hadith";
  static const String azkarRoute = "/azkar";
}

class RoutesGenerator {
  static Route<dynamic> getRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.homeRoute:
        initQuranModule();
        initHadithModule();
        initAzkarModule();
        return MaterialPageRoute(builder: (_) => HomeView());
      default:
        return unDefinedRoute();
    }
  }

  static Route<dynamic> unDefinedRoute() {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(
          title: Text(
            AppStrings.noRouteFound.tr(),
          ),
        ),
        body: Center(
          child: Text(
            AppStrings.noRouteFound.tr(),
          ),
        ),
      ),
    );
  }
}
