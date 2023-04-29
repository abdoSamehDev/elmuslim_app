import 'package:easy_localization/easy_localization.dart';
import 'package:elmuslim_app/presentation/hadith_builder/view/hadith_builder_view.dart';
import 'package:elmuslim_app/presentation/surah_builder/view/surah_builder_view.dart';
import 'package:elmuslim_app/presentation/test_screen.dart';
import 'package:elmuslim_app/presentation/zekr_builder/view/zekr_builder_view.dart';
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
      case Routes.quranRoute:
        final args = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
            builder: (_) => SurahBuilderView(
                quranList: args["quranList"], pageNo: args["pageNo"]));
      case Routes.hadithRoute:
        final args = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
            builder: (_) =>
                HadithBuilderView(hadithModel: args["hadithModel"]));
      case Routes.azkarRoute:
        final args = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
            builder: (_) => ZekrBuilderView(
                azkarList: args["azkarList"], category: args["category"]));
      case Routes.testRoute:
        final args = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(

            builder: (_) => TestScreen(
                quranList: args["quranList"], pageNo: args["pageNo"]
            ));
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
