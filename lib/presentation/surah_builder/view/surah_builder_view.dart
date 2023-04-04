import 'dart:ui' as ui;
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islamic_app/app/utils/functions.dart';
import 'package:islamic_app/domain/models/quran/quran_model.dart';
import 'package:islamic_app/presentation/common/components/components.dart';
import 'package:islamic_app/presentation/home/screens/quran/cubit/quran_cubit.dart';
import 'package:islamic_app/presentation/resources/font_manager.dart';
import 'package:islamic_app/presentation/resources/language_manager.dart';
import 'package:islamic_app/presentation/resources/strings_manager.dart';
import 'package:islamic_app/presentation/resources/values.dart';

class SurahBuilderView extends StatelessWidget {
  final List<QuranModel> quranList;
  final int pageNo;

  const SurahBuilderView(
      {Key? key, required this.quranList, required this.pageNo})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<QuranCubit, QuranState>(
      listener: (context, state) {},
      builder: (context, state) {
        QuranCubit cubit = QuranCubit.get(context);
        final PageController pageController =
            PageController(initialPage: pageNo - 1);

        //Get Current App Locale
        final currentLocale = context.locale;

        //Check if current app language is English
        bool isEnglish =
            currentLocale.languageCode == LanguageType.english.getValue();

        return Scaffold(
          body: SafeArea(
            child: Padding(
              padding: EdgeInsets.all(AppPadding.p8.r),
              child: PageView.builder(
                scrollDirection: Axis.horizontal,
                reverse: isEnglish,
                controller: pageController,
                itemCount: 604,
                itemBuilder: (BuildContext context, int index) {
                  var quranPageNumber = index + 1;
                  final List<QuranModel> pageSurahsList = cubit.getPageSurahs(
                      quran: quranList, pageNo: quranPageNumber);
                  final List<String> pageSurahsNamesList =
                      List.of(pageSurahsList.map((surah) => surah.name));

                  final String surahNameOnScreen = pageSurahsNamesList.first;
                  final List<AyahModel> ayahs = cubit.getAyahsFromPageNo(
                      quranList: quranList, pageNo: quranPageNumber);
                  return Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "${AppStrings.juz.tr()}: ${ayahs.first.juz.toString().tr()}، ${AppStrings.hizb.tr()}: ${((ayahs.first.hizbQuarter / 4).ceil()).toString().tr()} ",
                            style: Theme.of(context)
                                .textTheme
                                .labelSmall
                                ?.copyWith(
                                    fontFamily:
                                        FontConstants.uthmanTNFontFamily,
                                    color: Theme.of(context)
                                        .unselectedWidgetColor),
                          ),
                          Text(
                            surahNameOnScreen,
                            style: Theme.of(context)
                                .textTheme
                                .labelSmall
                                ?.copyWith(
                                    wordSpacing: AppSize.s5.w,
                                    letterSpacing: AppSize.s0_1.w,
                                    fontFamily: FontConstants.meQuranFontFamily,
                                    color: Theme.of(context)
                                        .unselectedWidgetColor),
                          ),
                        ],
                      ),
                      getSeparator(context),

                      //For the first two pages in the Quran
                      if (quranPageNumber == 1 || quranPageNumber == 2)
                        Expanded(
                          child: Center(
                            child: Text.rich(
                                textAlign: TextAlign.center,
                                textDirection: ui.TextDirection.rtl,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge
                                    ?.copyWith(
                                      height: AppSize.s1_5.h,
                                      fontFamily:
                                          FontConstants.meQuranFontFamily,
                                      fontSize:
                                          calculateQuranPageFontSize(ayahs, 1),
                                      wordSpacing: AppSize.s3.w,
                                    ),
                                TextSpan(
                                  children: [
                                    if (quranPageNumber == 1) //Surah Al-Fatiha

                                      for (var ayah in ayahs)
                                        TextSpan(
                                          text: ayah.numberInSurah == 1
                                              ? "$surahNameOnScreen\n${ayah.text}${getAyahNumberWithSymbol(ayah.numberInSurah)}\n\n"
                                              : "${ayah.text}${getAyahNumberWithSymbol(ayah.numberInSurah)}",
                                        ),
                                    if (quranPageNumber == 2) //Surah Al-Baqra
                                      for (var ayah in ayahs)
                                        TextSpan(
                                          text: ayah.numberInSurah == 1
                                              ? "$surahNameOnScreen\n${AppStrings.basmalah}\n\n${ayah.text.replaceAll("${AppStrings.basmalah}ِ", "")}${getAyahNumberWithSymbol(ayah.numberInSurah)}"
                                              : "${ayah.text}${getAyahNumberWithSymbol(ayah.numberInSurah)}",
                                        ),
                                  ],
                                )),
                          ),
                        ),
                      //Every page with only one surah in it except the first page of Al-Tawba Surah
                      if (quranPageNumber != 1 &&
                          quranPageNumber != 2 &&
                          quranPageNumber != 187 &&
                          pageSurahsList.length == 1)
                        Expanded(
                          child: Center(
                            child: Text.rich(
                                textDirection: ui.TextDirection.rtl,
                                textAlign: TextAlign.center,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge
                                    ?.copyWith(
                                      height: AppSize.s1_5.h,
                                      fontFamily:
                                          FontConstants.meQuranFontFamily,
                                      fontSize:
                                          calculateQuranPageFontSize(ayahs, 1),
                                      wordSpacing: AppSize.s3.w,
                                    ),
                                TextSpan(
                                  children: [
                                    for (var ayah in ayahs)
                                      if (ayah == ayahs.first)
                                        TextSpan(
                                            text: ayah.numberInSurah == 1
                                                ? "$surahNameOnScreen\n${AppStrings.basmalah}\n${ayah.text.replaceAll("${AppStrings.basmalah}ِ", "")}${getAyahNumberWithSymbol(ayah.numberInSurah)}"
                                                : "${ayah.text}${getAyahNumberWithSymbol(ayah.numberInSurah)}"),
                                    for (var ayah in ayahs)
                                      if (ayah != ayahs.first)
                                        TextSpan(
                                            text:
                                                "${ayah.text}${getAyahNumberWithSymbol(ayah.numberInSurah)}"),
                                  ],
                                )),
                          ),
                        ),

                      //Every page with two surah in it
                      if (pageSurahsList.length == 2)
                        Expanded(
                          child: Center(
                            child: Text.rich(
                                textDirection: ui.TextDirection.rtl,
                                textAlign: TextAlign.center,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge
                                    ?.copyWith(
                                      height: AppSize.s1_5.h,
                                      fontFamily:
                                          FontConstants.meQuranFontFamily,
                                      fontSize:
                                          calculateQuranPageFontSize(ayahs, 2),
                                      wordSpacing: AppSize.s3.w,
                                    ),
                                TextSpan(
                                  children: [
                                    for (var ayah in ayahs)
                                      if (ayah == ayahs.first)
                                        TextSpan(
                                            text: ayah.numberInSurah == 1
                                                ? "$surahNameOnScreen\n${AppStrings.basmalah}\n${ayah.text.replaceAll("${AppStrings.basmalah}ِ", "")}${getAyahNumberWithSymbol(ayah.numberInSurah)}"
                                                : "${ayah.text}${getAyahNumberWithSymbol(ayah.numberInSurah)}"),
                                    for (var ayah in ayahs)
                                      if (ayah != ayahs.first)
                                        TextSpan(
                                            text: ayah.numberInSurah == 1
                                                ? "\n\n${pageSurahsNamesList[1]}\n${AppStrings.basmalah}\n${ayah.text.replaceAll("${AppStrings.basmalah}ِ", "")}${getAyahNumberWithSymbol(ayah.numberInSurah)}"
                                                : "${ayah.text}${getAyahNumberWithSymbol(ayah.numberInSurah)}"),
                                  ],
                                )),
                          ),
                        ),

                      //Every page with three surah in it
                      if (pageSurahsList.length == 3)
                        Expanded(
                          child: Center(
                            child: Text.rich(
                                textDirection: ui.TextDirection.rtl,
                                textAlign: TextAlign.center,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge
                                    ?.copyWith(
                                      height: AppSize.s1_5.h,
                                      fontFamily:
                                          FontConstants.meQuranFontFamily,
                                      fontSize:
                                          calculateQuranPageFontSize(ayahs, 3),
                                      wordSpacing: AppSize.s3.w,
                                    ),
                                TextSpan(
                                  children: [
                                    for (var ayah
                                        in pageSurahsList.first.ayahs)
                                      if (ayah.page == quranPageNumber)
                                        TextSpan(
                                            text: ayah.numberInSurah == 1
                                                ? "${pageSurahsNamesList.first}\n${AppStrings.basmalah}\n${ayah.text.replaceAll("${AppStrings.basmalah}ِ", "")}${getAyahNumberWithSymbol(ayah.numberInSurah)}"
                                                : "${ayah.text}${getAyahNumberWithSymbol(ayah.numberInSurah)}"),
                                    for (var ayah in pageSurahsList[1].ayahs)
                                      if (ayah.page == quranPageNumber)
                                        TextSpan(
                                            text: ayah.numberInSurah == 1
                                                ? "\n\n${pageSurahsNamesList[1]}\n${AppStrings.basmalah}\n${ayah.text.replaceAll("${AppStrings.basmalah}ِ", "")}${getAyahNumberWithSymbol(ayah.numberInSurah)}"
                                                : "${ayah.text}${getAyahNumberWithSymbol(ayah.numberInSurah)}"),
                                    for (var ayah in pageSurahsList[2].ayahs)
                                      if (ayah.page == quranPageNumber)
                                        TextSpan(
                                            text: ayah.numberInSurah == 1
                                                ? "\n\n${pageSurahsNamesList[2]}\n${AppStrings.basmalah}\n${ayah.text.replaceAll("${AppStrings.basmalah}ِ", "")}${getAyahNumberWithSymbol(ayah.numberInSurah)}"
                                                : "${ayah.text}${getAyahNumberWithSymbol(ayah.numberInSurah)}"),
                                  ],
                                )),
                          ),
                        ),

                      //For the first page of Al-Tawba Surah
                      if (quranPageNumber == 187)
                        Expanded(
                          child: Center(
                            child: Text.rich(
                                textDirection: ui.TextDirection.rtl,
                                textAlign: TextAlign.center,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge
                                    ?.copyWith(
                                      height: AppSize.s1_5.h,
                                      fontFamily:
                                          FontConstants.meQuranFontFamily,
                                      fontSize:
                                          calculateQuranPageFontSize(ayahs, 1),
                                      wordSpacing: AppSize.s3.w,
                                    ),
                                TextSpan(
                                  children: [
                                    for (var ayah in ayahs)
                                      TextSpan(
                                        text: ayah.numberInSurah == 1
                                            ? "$surahNameOnScreen\n${ayah.text}${getAyahNumberWithSymbol(ayah.numberInSurah)}"
                                            : "${ayah.text}${getAyahNumberWithSymbol(ayah.numberInSurah)}",
                                      ),
                                  ],
                                )),
                          ),
                        ),
                      getSeparator(context),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: AppPadding.p8.h),
                        child: Text(
                          (quranPageNumber).toString().tr(),
                          textAlign: TextAlign.center,
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall
                              ?.copyWith(
                                  fontFamily: FontConstants.uthmanTNFontFamily,
                                  height: AppSize.s1.h,
                                  color:
                                      Theme.of(context).unselectedWidgetColor),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
