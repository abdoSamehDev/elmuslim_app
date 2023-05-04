import 'package:easy_localization/easy_localization.dart';
import 'package:elmuslim_app/app/utils/functions.dart';
import 'package:elmuslim_app/presentation/common/components/components.dart';
import 'package:elmuslim_app/presentation/home/screens/adhkar/cubit/adhkar_cubit.dart';
import 'package:elmuslim_app/presentation/resources/assets_manager.dart';
import 'package:elmuslim_app/presentation/resources/color_manager.dart';
import 'package:elmuslim_app/presentation/resources/font_manager.dart';
import 'package:elmuslim_app/presentation/resources/values.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomDhikrView extends StatelessWidget {
  final String customDhikrText;
  final int noOfRepetitions;

  const CustomDhikrView(
      {required this.customDhikrText, required this.noOfRepetitions, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        AdhkarCubit.get(context).resetCounter();
        return true;
      },
      child: BlocConsumer<AdhkarCubit, AdhkarState>(
        listener: (BuildContext context, state) {},
        builder: (BuildContext context, Object? state) {
          AdhkarCubit cubit = AdhkarCubit.get(context);
          int count = cubit.count;
          return Scaffold(
            appBar: AppBar(),
            body: Padding(
              padding: EdgeInsets.all(AppPadding.p8.r),
              child: Column(
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          customDhikrText,
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                height: AppSize.s1_23.h,
                                fontSize: calculateFontSize(customDhikrText.length),
                              ),
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
                            "${count.toString().tr()} / ${noOfRepetitions.toString().tr()}",
                            textAlign: TextAlign.center,
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge
                                ?.copyWith(
                                  height: AppSize.s1.h,
                                  fontFamily: FontConstants.uthmanTNFontFamily,
                                ),
                          ),
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                Theme.of(context).secondaryHeaderColor,
                            enableFeedback: true,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(AppSize.s8.r),
                            ),
                          ),
                          onPressed: () {
                            cubit.customDhikrCounter(
                              noOfRepetitions,
                            );
                          },
                          child: SvgPicture.asset(
                            ImageAsset.adhkarIcon,
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
              ),
              // PageView.builder(
              //   reverse: isEnglish,
              //   controller: _pageController,
              //   itemCount: adhkarFromCategory.length,
              //   itemBuilder: (BuildContext context, int index) {
              //     int count = cubit.count;
              //     return Column(
              //       children: [
              //         Padding(
              //           padding:
              //           EdgeInsets.symmetric(vertical: AppPadding.p8.h),
              //           child: Text(
              //             "${(index + 1).toString().tr()} / ${adhkarFromCategory.length.toString().tr()}",
              //             style: Theme.of(context)
              //                 .textTheme
              //                 .bodySmall
              //                 ?.copyWith(
              //                 fontFamily: FontConstants.uthmanTNFontFamily,
              //                 height: AppSize.s1.h,
              //                 color:
              //                 Theme.of(context).unselectedWidgetColor),
              //           ),
              //         ),
              //         Expanded(
              //           child: Column(
              //             children: [
              //               Text(
              //                 adhkarFromCategory[index]
              //                     .dhikr
              //                     .replaceAll("(", "")
              //                     .replaceAll(")", "")
              //                     .replaceAll(".", "")
              //                     .replaceAll("﴿", "")
              //                     .replaceAll("﴾", ""),
              //                 textAlign: TextAlign.center,
              //                 style: Theme.of(context)
              //                     .textTheme
              //                     .bodySmall
              //                     ?.copyWith(
              //                   height: AppSize.s1_23.h,
              //                   fontSize: calculateFontSize(
              //                       adhkarFromCategory[index]
              //                           .dhikr
              //                           .replaceAll("(", "")
              //                           .replaceAll(")", "")
              //                           .replaceAll(".", "")
              //                           .length),
              //                 ),
              //               ),
              //               Text(
              //                 adhkarFromCategory[index].reference.isNotEmpty
              //                     ? "${AppStrings.adhkarReference.tr()}: ${adhkarFromCategory[index].reference}"
              //                     : Constants.empty,
              //                 textAlign: TextAlign.center,
              //                 style: Theme.of(context)
              //                     .textTheme
              //                     .bodySmall
              //                     ?.copyWith(
              //                     height: AppSize.s1.h,
              //                     color: Theme.of(context)
              //                         .unselectedWidgetColor),
              //               ),
              //               SizedBox(
              //                 height: AppSize.s8.h,
              //               ),
              //               Text(
              //                 adhkarFromCategory[index].description.isNotEmpty
              //                     ? "${AppStrings.adhkarReward.tr()}: ${adhkarFromCategory[index].description}"
              //                     : Constants.empty,
              //                 textAlign: TextAlign.center,
              //                 style: Theme.of(context)
              //                     .textTheme
              //                     .bodySmall
              //                     ?.copyWith(
              //                     height: AppSize.s1.h,
              //                     color: Theme.of(context)
              //                         .unselectedWidgetColor),
              //               ),
              //             ],
              //           ),
              //         ),
              //         Padding(
              //           padding: EdgeInsets.all(AppPadding.p12.h),
              //           child: Column(
              //             mainAxisAlignment: MainAxisAlignment.center,
              //             crossAxisAlignment: CrossAxisAlignment.center,
              //             children: [
              //               getSeparator(context),
              //               Padding(
              //                 padding: EdgeInsets.only(bottom: AppPadding.p8.h),
              //                 child: Text(
              //                   "${count.toString().tr()} / ${adhkarFromCategory[index].count.isEmpty ? 1.toString().tr() : adhkarFromCategory[index].count.tr()}",
              //                   textAlign: TextAlign.center,
              //                   style: Theme.of(context)
              //                       .textTheme
              //                       .bodyLarge
              //                       ?.copyWith(
              //                     height: AppSize.s1.h,
              //                     fontFamily:
              //                     FontConstants.uthmanTNFontFamily,
              //                   ),
              //                 ),
              //               ),
              //               ElevatedButton(
              //                 style: ElevatedButton.styleFrom(
              //                   backgroundColor:
              //                   Theme.of(context).secondaryHeaderColor,
              //                   enableFeedback: true,
              //                   shape: RoundedRectangleBorder(
              //                     borderRadius:
              //                     BorderRadius.circular(AppSize.s8.r),
              //                   ),
              //                 ),
              //                 onPressed: () {
              //                   cubit.dhikrCounter(
              //                       int.parse(
              //                           adhkarFromCategory[index].count.isEmpty
              //                               ? "1"
              //                               : adhkarFromCategory[index].count),
              //                       _pageController,
              //                       index);
              //                 },
              //                 child: SvgPicture.asset(
              //                   ImageAsset.adhkarIcon,
              //                   width: AppSize.s50.h,
              //                   height: AppSize.s50.h,
              //                   color: ColorManager.gold,
              //                   // Theme.of(context).primaryColor,
              //                 ),
              //               ),
              //             ],
              //           ),
              //         ),
              //       ],
              //     );
              //   },
              // ),
            ),
          );
        },
      ),
    );
  }
}
