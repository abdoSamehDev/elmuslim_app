import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:islamic_app/presentation/home/screens/settings/viewmodel/settings_viewmodel.dart';
import 'package:islamic_app/presentation/home/view/home_view.dart';
import 'package:islamic_app/presentation/resources/strings_manager.dart';



class Routes {
  static const String homeRoute = "/";
  static const String settingsRoute = "/settings";
// static const String splashRoute = "/";
// static const String splashRoute = "/";
}

class RoutesGenerator {
  static Route<dynamic> getRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.homeRoute:
        return MaterialPageRoute(builder: (_) => const HomeView());
      case Routes.settingsRoute:
        return MaterialPageRoute(builder: (_) => const SettingsView());
      default:
        return unDefinedRoute();
    }
  }

  static Route<dynamic> unDefinedRoute() {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(
          title:  Text(
            AppStrings.noRouteFound.tr(),
          ),
        ),
        body:  Center(
          child: Text(
            AppStrings.noRouteFound.tr(),
          ),
        ),
      ),
    );
  }
}
