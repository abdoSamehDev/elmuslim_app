import 'dart:ui' as ui;

import 'package:easy_localization/easy_localization.dart';
import 'package:elmuslim_app/app/error/failure.dart';
import 'package:elmuslim_app/app/utils/constants.dart';
import 'package:elmuslim_app/app/utils/extensions.dart';
import 'package:elmuslim_app/data/network/error_handler.dart';
import 'package:elmuslim_app/domain/models/prayer_timings/prayer_timings_model.dart';
import 'package:elmuslim_app/presentation/common/components/components.dart';
import 'package:elmuslim_app/presentation/home/screens/prayer_times/cubit/prayer_timings_cubit.dart';
import 'package:elmuslim_app/presentation/resources/color_manager.dart';
import 'package:elmuslim_app/presentation/resources/font_manager.dart';
import 'package:elmuslim_app/presentation/resources/language_manager.dart';
import 'package:elmuslim_app/presentation/resources/strings_manager.dart';
import 'package:elmuslim_app/presentation/resources/values.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class PrayerTimingsScreen extends StatelessWidget {
  const PrayerTimingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PrayerTimingsCubit, PrayerTimingsState>(
      listener: (BuildContext context, state) {},
      builder: (context, state) {
        PrayerTimingsCubit cubit = PrayerTimingsCubit.get(context);
        PrayerTimingsModel prayerTimingsModel = cubit.prayerTimingsModel;

        //Get Current App Locale
        final currentLocale = context.locale;

        //Check if current app language is English
        bool isEnglish =
            currentLocale.languageCode == LanguageType.english.getValue();

        if (prayerTimingsModel.code == 0) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                AppStrings.gettingLocation.tr(),
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              SizedBox(
                height: AppSize.s5.h,
              ),
              Center(
                child: SizedBox(
                    width: (MediaQuery.of(context).size.width * 0.55),
                    child: const LinearProgressIndicator(
                      color: ColorManager.gold,
                    )),
              ),
            ],
          );
        } else if (prayerTimingsModel.code == 200) {
          List<String> timings = [
            prayerTimingsModel.data!.timings!.fajr.convertTo12HourFormat(),
            prayerTimingsModel.data!.timings!.sunrise.convertTo12HourFormat(),
            prayerTimingsModel.data!.timings!.dhuhr.convertTo12HourFormat(),
            prayerTimingsModel.data!.timings!.asr.convertTo12HourFormat(),
            prayerTimingsModel.data!.timings!.maghrib.convertTo12HourFormat(),
            prayerTimingsModel.data!.timings!.isha.convertTo12HourFormat(),
          ];
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: AppSize.s5.h),
                child: Text(
                  isEnglish
                      ? prayerTimingsModel.data!.date!.gregorian!.weekday!.en
                      : prayerTimingsModel.data!.date!.hijri!.weekday!.ar,
                  style: Theme.of(context).textTheme.displayMedium,
                ),
              ),
              isEnglish
                  ? Text(
                      "${prayerTimingsModel.data!.date!.hijri!.day} ${prayerTimingsModel.data!.date!.hijri!.month!.en} ${prayerTimingsModel.data!.date!.hijri!.year}",
                      style: GoogleFonts.sourceSansPro(),
                      textAlign: TextAlign.start,
                      textDirection: ui.TextDirection.ltr,
                    )
                  : Text(
                      "${prayerTimingsModel.data!.date!.hijri!.day} ${prayerTimingsModel.data!.date!.hijri!.month!.ar} ${prayerTimingsModel.data!.date!.hijri!.year}",
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: AppSize.s5.h),
                child: Text(
                  prayerTimingsModel.data!.date!.gregorian!.date,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Theme.of(context).unselectedWidgetColor),
                ),
              ),
              Center(
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        for (var index = 0;
                            index < Constants.prayerNumbers;
                            index++)
                          _prayerIndexItem(
                              isEnglish: isEnglish,
                              context: context,
                              timings: timings,
                              prayerTimingsModel: prayerTimingsModel,
                              index: index)
                      ],
                    ),
                  ],
                ),
              ),
            ],
          );
        } else {
          int errorCode = prayerTimingsModel.code;
          ServerFailure failure = errorCode.getServerFailureFromCode();
          return Center(child: Text(failure.message));
        }

        // if (state is GetPrayerTimesLoadingState ||
        //     state is GetLocationLoadingState ||
        //     state is GetLocationSuccessState) {
        //   return const Center(
        //       child: CircularProgressIndicator(color: ColorManager.gold));
        // } else if (state is GetPrayerTimesSuccessState) {
        //   PrayerTimingsModel prayerTimingsModel = state.prayerTimingsModel;
        //   List<String> timings = [
        //     prayerTimingsModel.data!.timings!.fajr.convertTo12HourFormat(),
        //     prayerTimingsModel.data!.timings!.sunrise.convertTo12HourFormat(),
        //     prayerTimingsModel.data!.timings!.dhuhr.convertTo12HourFormat(),
        //     prayerTimingsModel.data!.timings!.asr.convertTo12HourFormat(),
        //     prayerTimingsModel.data!.timings!.maghrib.convertTo12HourFormat(),
        //     prayerTimingsModel.data!.timings!.isha.convertTo12HourFormat(),
        //   ];
        //
        //   return Column(
        //     mainAxisAlignment: MainAxisAlignment.center,
        //     children: [
        //       Padding(
        //         padding: EdgeInsets.symmetric(vertical: AppSize.s5.h),
        //         child: Text(
        //           isEnglish
        //               ? prayerTimingsModel.data!.date!.gregorian!.weekday!.en
        //               : prayerTimingsModel.data!.date!.hijri!.weekday!.ar,
        //           style: Theme.of(context).textTheme.displayMedium,
        //         ),
        //       ),
        //       isEnglish
        //           ? Text(
        //               "${prayerTimingsModel.data!.date!.hijri!.day} ${prayerTimingsModel.data!.date!.hijri!.month!.en} ${prayerTimingsModel.data!.date!.hijri!.year}",
        //               style: GoogleFonts.sourceSansPro(),
        //               textAlign: TextAlign.start,
        //               textDirection: ui.TextDirection.ltr,
        //             )
        //           : Text(
        //               "${prayerTimingsModel.data!.date!.hijri!.day} ${prayerTimingsModel.data!.date!.hijri!.month!.ar} ${prayerTimingsModel.data!.date!.hijri!.year}",
        //               style: Theme.of(context).textTheme.bodyLarge,
        //             ),
        //       Padding(
        //         padding: EdgeInsets.symmetric(vertical: AppSize.s5.h),
        //         child: Text(
        //           prayerTimingsModel.data!.date!.gregorian!.date,
        //           style: Theme.of(context).textTheme.bodySmall?.copyWith(
        //               color: Theme.of(context).unselectedWidgetColor),
        //         ),
        //       ),
        //       Center(
        //         child: Column(
        //           // mainAxisAlignment: MainAxisAlignment.center,
        //           children: [
        //             Column(
        //               children: [
        //                 for (var index = 0;
        //                     index < Constants.prayerNumbers;
        //                     index++)
        //                   _prayerIndexItem(
        //                       isEnglish: isEnglish,
        //                       context: context,
        //                       timings: timings,
        //                       prayerTimingsModel: prayerTimingsModel,
        //                       index: index)
        //               ],
        //             ),
        //           ],
        //         ),
        //       ),
        //     ],
        //   );
        // } else if (state is GetPrayerTimesErrorState) {
        //   return Center(child: Text(state.error));
        // } else {
        //   return Container();
        // }
      },
    );
  }

  Widget _prayerIndexItem({
    required PrayerTimingsModel prayerTimingsModel,
    required List<String> timings,
    required int index,
    required bool isEnglish,
    required BuildContext context,
  }) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  isEnglish
                      ? AppStrings.englishPrayerNames[index]
                      : AppStrings.arabicPrayerNames[index],
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontFamily: FontConstants.elMessiriFontFamily,
                      ),
                ),
                SizedBox(
                  height: AppSize.s5.h,
                ),
                Text(
                  isEnglish
                      ? AppStrings.arabicPrayerNames[index]
                      : AppStrings.englishPrayerNames[index],
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontFamily: FontConstants.elMessiriFontFamily,
                        color: Theme.of(context).unselectedWidgetColor,
                      ),
                ),
              ],
            ),
            SizedBox(
              width: AppSize.s35.w,
            ),
            Text(
              timings[index],
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(fontFamily: FontConstants.uthmanTNFontFamily),
            ),
          ],
        ),
        getSeparator(context),
      ],
    );
  }
}
