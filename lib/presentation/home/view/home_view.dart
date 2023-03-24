import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:islamic_app/app/utils/di.dart';
import 'package:islamic_app/presentation/home/cubit/home_cubit.dart';
import 'package:islamic_app/presentation/home/viewmodel/home_viewmodel.dart';
import 'package:islamic_app/presentation/resources/assets_manager.dart';
import 'package:islamic_app/presentation/resources/font_manager.dart';
import 'package:islamic_app/presentation/resources/strings_manager.dart';
import 'package:flutter_svg/svg.dart';
import 'package:islamic_app/presentation/resources/styles_manager.dart';
import 'package:islamic_app/presentation/resources/values.dart';

class HomeView extends StatelessWidget {
  final HomeViewModel _viewModel = instance<HomeViewModel>();

  HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => instance<HomeCubit>()..getQuranData()..getHadithData()..getAzkarData(),
      child: BlocConsumer<HomeCubit, HomeState>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = HomeCubit.get(context);
          int currentIndex = cubit.currentIndex;
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Theme.of(context).primaryColor,
              title: Text(
                _viewModel.titles[currentIndex],
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
                  size: AppSize.s24),
              // selectedFontSize: ,
              // unselectedFontSize: ,
              selectedLabelStyle: getSemiBoldStyle(),
              unselectedLabelStyle: getRegularStyle(fontSize: FontSize.s12),
              unselectedItemColor: Theme.of(context).unselectedWidgetColor,
              unselectedIconTheme: IconThemeData(
                color: Theme.of(context).unselectedWidgetColor,
              ),
              // ColorManager.darkGrey,
              showSelectedLabels: true,
              showUnselectedLabels: true,
              enableFeedback: true,
              currentIndex: currentIndex,
              onTap: (int index) {
                // currentIndex = index;
                cubit.changeBotNavIndex(index);
              },
              items: [
                BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    ImageAsset.quranIcon,
                    width: AppSize.s24,
                    height: AppSize.s24,
                    // theme: SvgTheme(
                    //     currentColor: Theme.of(context)
                    //         .bottomNavigationBarTheme
                    //         .selectedIconTheme!
                    //         .color!),
                    color: currentIndex == 0
                        ? Theme.of(context).secondaryHeaderColor
                        : Theme.of(context).unselectedWidgetColor,
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
                    color: currentIndex == 1
                        ? Theme.of(context).secondaryHeaderColor
                        : Theme.of(context).unselectedWidgetColor,
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
                    color: currentIndex == 2
                        ? Theme.of(context).secondaryHeaderColor
                        : Theme.of(context).unselectedWidgetColor,
                  ),
                  label: AppStrings.azkar.tr(),
                ),
                BottomNavigationBarItem(
                  icon: const Icon(Icons.settings_outlined),
                  label: AppStrings.settings.tr(),
                ),
              ],
            ),
            body: _viewModel.screens[currentIndex],
          );
        },
      ),
    );
  }
}
