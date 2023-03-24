import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:islamic_app/presentation/base/base_view_model.dart';
import 'package:islamic_app/presentation/home/screens/azkar/view/azkar_screen.dart';
import 'package:islamic_app/presentation/home/screens/hadith/view/hadith_screen.dart';
import 'package:islamic_app/presentation/home/screens/quran/view/quran_screen.dart';
import 'package:islamic_app/presentation/home/screens/settings/view/settings_screen.dart';
import 'package:islamic_app/presentation/resources/strings_manager.dart';

class HomeViewModel extends BaseViewModel {

  HomeViewModel();

  int currentIndex = 0;

  List<Widget> screens = [
    const QuranScreen(),
    const HadithScreen(),
    const AzkarScreen(),
    const SettingsScreen(),
  ];

  List<String> titles = [
    AppStrings.quran.tr(),
    AppStrings.hadith.tr(),
    AppStrings.azkar.tr(),
    AppStrings.settings.tr(),
  ];

  // Future<List<QuranModel>> getQuranData(context) async {
  //   final cubit = HomeCubit.get(context);
  //   final List<QuranModel> data = await cubit.getQuranData();
  //   return data;
  // }
  //
  // Future<List<HadithModel>> getHadithData(context) async {
  //   final cubit = HomeCubit.get(context);
  //   final List<HadithModel> data = await cubit.getHadithData();
  //   return data;
  // }
  //
  // Future<List<AzkarModel>> getAzkarData(context) async {
  //   final cubit = HomeCubit.get(context);
  //   final List<AzkarModel> data = await cubit.getAzkarData();
  //   return data;
  // }
}