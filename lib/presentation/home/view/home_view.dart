import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:islamic_app/app/utils/di.dart';
import 'package:islamic_app/presentation/home/cubit/home_cubit.dart';
// import 'package:islamic_app/presentation/home/viewmodel/home_viewmodel.dart';
import 'package:islamic_app/presentation/resources/assets_manager.dart';
import 'package:islamic_app/presentation/resources/font_manager.dart';
import 'package:islamic_app/presentation/resources/strings_manager.dart';
import 'package:flutter_svg/svg.dart';
import 'package:islamic_app/presentation/resources/values.dart';

class HomeView extends StatelessWidget {
  // final HomeViewModel _viewModel = instance<HomeViewModel>();
  final HomeCubit _cubit = instance<HomeCubit>();
  HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
  create: (context) => instance<HomeCubit>(),
  child: BlocBuilder<HomeCubit, HomeState>(
  builder: (context, state) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _cubit.titles[_cubit.currentIndex],
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontFamily: FontConstants.meQuranFontFamily,
                // color: ColorManager.gold
              ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        enableFeedback: true,
        onTap: (index){
          // _cubit.currentIndex = index;
          _cubit.changeBotNavIndex(index);
        },
        currentIndex: _cubit.currentIndex,
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
      body: _cubit.screens[_cubit.currentIndex],
    );
  },
),
);
  }
}
