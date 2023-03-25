import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:islamic_app/presentation/home/cubit/home_cubit.dart';
import 'package:islamic_app/presentation/home/screens/quran/view/quran_screen.dart';
import 'package:islamic_app/presentation/resources/font_manager.dart';
import 'package:islamic_app/presentation/resources/strings_manager.dart';
import 'package:islamic_app/presentation/resources/styles_manager.dart';
import 'package:islamic_app/presentation/resources/values.dart';

class TestScreen extends StatelessWidget {
  const TestScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
  create: (context) => HomeCubit(),
  child: BlocConsumer<HomeCubit, HomeState>(
  listener: (context, state) {
  },
  builder: (context, state) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(
          "cubit.titles[cubit.currentIndex]",
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontFamily: FontConstants.meQuranFontFamily,
            // color: ColorManager.gold
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Theme.of(context).secondaryHeaderColor,
        // ColorManager.darkSecondary,
        selectedIconTheme: IconThemeData(
            color: Theme.of(context).secondaryHeaderColor,
            // ColorManager.darkSecondary,
            size: AppSize.s35),
        selectedLabelStyle: getSemiBoldStyle(fontSize: FontSize.s14),
        unselectedItemColor: Theme.of(context).unselectedWidgetColor,
        unselectedIconTheme: IconThemeData(
          color: Theme.of(context).unselectedWidgetColor,
        ),
        // ColorManager.darkGrey,
        showSelectedLabels: true,
        showUnselectedLabels: false,
        currentIndex: 0,
        // cubit.currentIndex,
        onTap: (index) {
          // cubit.currentIndex = index;
          // cubit.changeBotNavIndex(index);
        },
        // items: [
        //   BottomNavigationBarItem(
        //     icon: SvgPicture.asset(
        //       ImageAsset.quranIcon,
        //       width: AppSize.s35,
        //       height: AppSize.s35,
        //       // theme: SvgTheme(
        //       //     currentColor: Theme.of(context)
        //       //         .bottomNavigationBarTheme
        //       //         .selectedIconTheme!
        //       //         .color!),
        //       color: Theme.of(context).secondaryHeaderColor,
        //     ),
        //     label: AppStrings.quran.tr(),
        //   ),
        //   BottomNavigationBarItem(
        //     icon: SvgPicture.asset(
        //       ImageAsset.hadithIcon,
        //       width: AppSize.s24,
        //       height: AppSize.s24,
        //       // theme: SvgTheme(
        //       //     currentColor: Theme.of(context)
        //       //         .bottomNavigationBarTheme
        //       //         .selectedIconTheme!
        //       //         .color!),
        //       color: Theme.of(context).unselectedWidgetColor,
        //     ),
        //     label: AppStrings.hadith.tr(),
        //   ),
        //   BottomNavigationBarItem(
        //     icon: SvgPicture.asset(
        //       ImageAsset.azkarIcon,
        //       width: AppSize.s24,
        //       height: AppSize.s24,
        //       // theme: SvgTheme(
        //       //     currentColor: Theme.of(context)
        //       //         .bottomNavigationBarTheme
        //       //         .selectedIconTheme!
        //       //         .color!),
        //       color: Theme.of(context).unselectedWidgetColor,
        //     ),
        //     label: AppStrings.azkar.tr(),
        //   ),
        //   BottomNavigationBarItem(
        //     icon: const Icon(Icons.settings_outlined),
        //     label: AppStrings.settings.tr(),
        //   ),
        // ],
        items: [

          BottomNavigationBarItem(
            icon: const Icon(Icons.settings_outlined),
            label: AppStrings.settings.tr(),
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.settings_outlined),
            label: AppStrings.settings.tr(),
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.settings_outlined),
            label: AppStrings.settings.tr(),
          ),
        ],
      ),
      body:       const QuranScreen(),
      // cubit.screens[cubit.currentIndex],
    );
  },
),
);
  }
}

