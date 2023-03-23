import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:islamic_app/presentation/resources/assets_manager.dart';
import 'package:islamic_app/presentation/resources/font_manager.dart';
import 'package:islamic_app/presentation/resources/strings_manager.dart';
import 'package:flutter_svg/svg.dart';
import 'package:islamic_app/presentation/resources/values.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppStrings.quran.tr(),
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontFamily: FontConstants.meQuranFontFamily,
                // color: ColorManager.gold
              ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              ImageAsset.quranIcon,
              width: AppSize.s35,
              height: AppSize.s35,
              // theme: SvgTheme(
              //     currentColor: Theme.of(context)
              //         .bottomNavigationBarTheme
              //         .selectedIconTheme!
              //         .color!),
              color: Theme.of(context).secondaryHeaderColor,
            ),
            label: AppStrings.quran.tr(),
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              ImageAsset.hadithIcon,
              width: AppSize.s24,
              height: AppSize.s24,
              // theme: SvgTheme(
              //     currentColor: Theme.of(context)
              //         .bottomNavigationBarTheme
              //         .selectedIconTheme!
              //         .color!),
              color: Theme.of(context).secondaryHeaderColor,
            ),
            label: AppStrings.hadith.tr(),
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              ImageAsset.azkarIcon,
              width: AppSize.s24,
              height: AppSize.s24,
              // theme: SvgTheme(
              //     currentColor: Theme.of(context)
              //         .bottomNavigationBarTheme
              //         .selectedIconTheme!
              //         .color!),
              color: Theme.of(context).secondaryHeaderColor,
            ),
            label: AppStrings.azkar.tr(),
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.settings_outlined),
            label: AppStrings.settings.tr(),
          ),
        ],
      ),
      body: Center(
        child: Text(AppStrings.quran.tr()),
      ),
    );
  }
}
