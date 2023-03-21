import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:islamic_app/app/app.dart';
import 'package:islamic_app/presentation/resources/language_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  runApp(
    EasyLocalization(
      supportedLocales: const [arabicLocale, englishLocale],
      startLocale: arabicLocale,
      path: localisationPath,
      child: Phoenix(
        child: MyApp(),
      ),
    ),
  );
}
