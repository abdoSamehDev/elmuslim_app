import 'package:easy_localization/easy_localization.dart';
import 'package:elmuslim_app/app/utils/di.dart';
import 'package:elmuslim_app/presentation/custom_adhkar/view/custom_adhkar_view.dart';
import 'package:elmuslim_app/presentation/custom_adhkar/view/custom_dhikr_view.dart';
import 'package:elmuslim_app/presentation/dhikr_builder/view/dhikr_builder_view.dart';
import 'package:elmuslim_app/presentation/hadith_builder/view/hadith_builder_view.dart';
import 'package:elmuslim_app/presentation/home/view/home_view.dart';
import 'package:elmuslim_app/presentation/resources/strings_manager.dart';
import 'package:elmuslim_app/presentation/surah_builder/view/surah_builder_view.dart';
import 'package:flutter/material.dart';

class Routes {
  static const String homeRoute = "/";
  // static const String testRoute = "/test";
  static const String quranRoute = "/quran";
  static const String hadithRoute = "/hadith";
  static const String adhkarRoute = "/adhkar";
  static const String customAdhkarRoute = "/customAdhkar";
  static const String customDhikrRoute = "/customDhikr";
}

class RoutesGenerator {
  static Route<dynamic> getRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.homeRoute:
        initQuranModule();
        initHadithModule();
        initAdhkarModule();
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
      case Routes.adhkarRoute:
        final args = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
            builder: (_) => DhikrBuilderView(
                adhkarList: args["adhkarList"], category: args["category"]));
      case Routes.customAdhkarRoute:
        initCustomAdhkarModule();
        return MaterialPageRoute(builder: (_) => CustomAdhkarView());
      case Routes.customDhikrRoute:
        final args = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
            builder: (_) => CustomDhikrView(
                  customDhikrText: args["customDhikrText"],
                  noOfRepetitions: args["noOfRepetitions"],
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
