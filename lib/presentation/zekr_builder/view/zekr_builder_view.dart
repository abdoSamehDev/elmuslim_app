import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:islamic_app/app/utils/constants.dart';
import 'package:islamic_app/app/utils/di.dart';
import 'package:islamic_app/app/utils/functions.dart';
import 'package:islamic_app/domain/models/azkar/azkar_model.dart';
import 'package:islamic_app/presentation/common/components/components.dart';
import 'package:islamic_app/presentation/home/screens/azkar/cubit/azkar_cubit.dart';
import 'package:islamic_app/presentation/resources/assets_manager.dart';
import 'package:islamic_app/presentation/resources/color_manager.dart';
import 'package:islamic_app/presentation/resources/font_manager.dart';
import 'package:islamic_app/presentation/resources/language_manager.dart';
import 'package:islamic_app/presentation/resources/strings_manager.dart';
import 'package:islamic_app/presentation/resources/values.dart';

class ZekrBuilderView extends StatelessWidget {
  final List<AzkarModel> azkarList;
  final String category;
  final PageController _pageController = instance<PageController>();

  ZekrBuilderView({Key? key, required this.azkarList, required this.category})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
  create: (context) => AzkarCubit(),
  child: BlocConsumer<AzkarCubit, AzkarState>(
      listener: (context, state) {},
      builder: (context, state) {
        AzkarCubit cubit = AzkarCubit.get(context);

        final List<AzkarModel> azkarFromCategory = cubit.getAzkarFromCategory(
            azkarList: azkarList, category: category);
        //Get Current App Locale
        final currentLocale = context.locale;

        //Check if current app language is English
        bool isEnglish =
            currentLocale.languageCode == LanguageType.english.getValue();
        return Scaffold(
          appBar: AppBar(
            title: Text(
              azkarFromCategory[0].category,
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(color: ColorManager.gold),
            ),
          ),
          body: Padding(
            padding: EdgeInsets.all(AppPadding.p8.r),
            child: PageView.builder(
              reverse: isEnglish,
              controller: _pageController,
              itemCount: azkarFromCategory.length,
              itemBuilder: (BuildContext context, int index) {
                int count = cubit.count;
                return Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: AppPadding.p8.h),
                      child: Text(
                        "${(index + 1).toString().tr()} / ${azkarFromCategory.length.toString().tr()}",
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            fontFamily: FontConstants.uthmanTNFontFamily,
                            height: AppSize.s1.h,
                            color: Theme.of(context).unselectedWidgetColor),
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Text(
                            azkarFromCategory[index]
                                .zekr
                                .replaceAll("(", "")
                                .replaceAll(")", "")
                                .replaceAll(".", "")
                                .replaceAll("﴿", "")
                                .replaceAll("﴾", ""),
                            textAlign: TextAlign.center,
                            style:
                                Theme.of(context).textTheme.bodySmall?.copyWith(
                                      height: AppSize.s1_23.h,
                                      fontSize: calculateFontSize(
                                          azkarFromCategory[index]
                                              .zekr
                                              .replaceAll("(", "")
                                              .replaceAll(")", "")
                                              .replaceAll(".", "")
                                              .length),
                                    ),
                          ),
                          Text(
                            azkarFromCategory[index].reference.isNotEmpty
                                ? "${AppStrings.azkarReference.tr()}: ${azkarFromCategory[index].reference}"
                                : Constants.empty,
                            textAlign: TextAlign.center,
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall
                                ?.copyWith(
                                    height: AppSize.s1.h,
                                    color: Theme.of(context)
                                        .unselectedWidgetColor),
                          ),
                          SizedBox(
                            height: AppSize.s8.h,
                          ),
                          Text(
                            azkarFromCategory[index].description.isNotEmpty
                                ? "${AppStrings.azkarReward.tr()}: ${azkarFromCategory[index].description}"
                                : Constants.empty,
                            textAlign: TextAlign.center,
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall
                                ?.copyWith(
                                    height: AppSize.s1.h,
                                    color: Theme.of(context)
                                        .unselectedWidgetColor),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(AppPadding.p12.h),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          getSeparator(context),
                          Padding(
                            padding: EdgeInsets.only(bottom: AppPadding.p8.h),
                            child: Text(
                              "${count.toString().tr()} / ${azkarFromCategory[index].count.isEmpty ? 1.toString().tr() : azkarFromCategory[index].count.tr()}",
                              textAlign: TextAlign.center,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge
                                  ?.copyWith(
                                    height: AppSize.s1.h,
                                    fontFamily:
                                        FontConstants.uthmanTNFontFamily,
                                  ),
                            ),
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  Theme.of(context).secondaryHeaderColor,
                              enableFeedback: true,
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(AppSize.s8.r),
                              ),
                            ),
                            onPressed: () {
                              cubit.zekrCounter(
                                  int.parse(
                                      azkarFromCategory[index].count.isEmpty
                                          ? "1"
                                          : azkarFromCategory[index].count),
                                  _pageController,
                                  index);
                            },
                            child: SvgPicture.asset(
                              ImageAsset.azkarIcon,
                              width: AppSize.s50.h,
                              height: AppSize.s50.h,
                              color: ColorManager.gold,
                              // Theme.of(context).primaryColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        );
      },
    ),
);
  }
}
