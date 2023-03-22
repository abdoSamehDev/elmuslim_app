import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:islamic_app/presentation/resources/assets_manager.dart';
import 'package:islamic_app/presentation/resources/strings_manager.dart';
import 'package:flutter_svg/svg.dart';
import 'package:islamic_app/presentation/resources/values.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items:  [
          BottomNavigationBarItem(icon: SvgPicture.asset(ImageAsset.quranIcon, width: AppSize.s35, height: AppSize.s35, theme: SvgTheme(
            currentColor: Theme.of(context).bottomNavigationBarTheme.selectedIconTheme!.color!
          ) , color: Theme.of(context).bottomNavigationBarTheme.selectedIconTheme!.color!), label: AppStrings.quran.tr(),),
          BottomNavigationBarItem(icon: const Icon(Icons.settings), label: AppStrings.settings.tr(),),
          BottomNavigationBarItem(icon: const Icon(Icons.person), label: AppStrings.profile.tr(),),
        ],
        onTap: (index){},
        // currentIndex: ,
      ),
      body: Center(
        child: Text(AppStrings.quran.tr()),
      ),
    );
  }
}
