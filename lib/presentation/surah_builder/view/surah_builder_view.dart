import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islamic_app/app/utils/extensions.dart';
import 'package:islamic_app/domain/models/quran/quran_model.dart';
import 'package:islamic_app/presentation/common/components/components.dart';
import 'package:islamic_app/presentation/home/screens/quran/cubit/quran_cubit.dart';
import 'package:islamic_app/presentation/resources/font_manager.dart';
import 'package:islamic_app/presentation/resources/language_manager.dart';
import 'package:islamic_app/presentation/resources/strings_manager.dart';
import 'package:islamic_app/presentation/resources/values.dart';

class SurahBuilderView extends StatelessWidget {
  final List<QuranModel> quranList;
  final String surahName;
  final int pageNo;

  const SurahBuilderView(
      {Key? key,
      required this.quranList,
      required this.surahName,
      required this.pageNo})
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

                  final String surahNameOnScreen = pageSurahsNamesList[0];
                  final List<AyahModel> ayahs = cubit.getAyahsFromPageNo(
                      quranList: quranList, pageNo: quranPageNumber);
                  return Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "${AppStrings.juz.tr()}: ${ayahs.first.juz.toString().tr()}، ${AppStrings.hizb.tr()}: ${((ayahs.first.hizbQuarter / 4).ceil()).toString().tr()} ",
                            // "",
                            // textDirection: TextDirection.rtl,
                            style: Theme.of(context)
                                .textTheme
                                .labelSmall
                                ?.copyWith(
                                    fontFamily:
                                        FontConstants.uthmanTNFontFamily,
                                    // height: AppSize.s1.h,
                                    color: Theme.of(context)
                                        .unselectedWidgetColor),
                          ),
                          Text(
                            surahNameOnScreen,
                            // textDirection: TextDirection.RTL,
                            style: Theme.of(context)
                                .textTheme
                                .labelSmall
                                ?.copyWith(
                                    // height: AppSize.s1.h,
                                    wordSpacing: 5.w,
                                    letterSpacing: 0.1.w,
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
                                // textDirection: TextDirection.rtl,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge
                                    ?.copyWith(
                                      height: AppSize.s1_5.h,
                                      fontFamily: FontConstants.hafsFontFamily,
                                      fontSize: FontSize.s24
                                      // wordSpacing: 3,
                                      // letterSpacing: 0.1,
                                    ),
                                TextSpan(
                                  children: [
                                    if (quranPageNumber == 1) //Surah Al-Fatiha

                                      for (var ayah in ayahs)
                                        TextSpan(
                                          text: ayah.numberInSurah == 1
                                              ? "$surahNameOnScreen\n${ayah.text} ${ayah.numberInSurah.toArabic()} \n\n"
                                              : "${ayah.text} ${ayah.numberInSurah.toArabic()} ",
                                        ),
                                    if (quranPageNumber == 2) //Surah Al-Baqra
                                      for (var ayah in ayahs)
                                        TextSpan(
                                          text: ayah.numberInSurah == 1
                                              ? "$surahNameOnScreen\n${AppStrings.basmalah}\n\n${ayah.text.replaceAll("${AppStrings.basmalah}ِ", "")} ${ayah.numberInSurah.toArabic()} "
                                              : "${ayah.text} ${ayah.numberInSurah.toArabic()} ",
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
                          child: Column(
                            // mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // for (var ayah in ayahs)
                              Text.rich(
                                  textAlign: TextAlign.center,
                                  // textDirection: TextDirection.rtl,
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleLarge
                                      ?.copyWith(
                                        height: 1.23.h,
                                        fontFamily:
                                            FontConstants.hafsFontFamily,
                                        // fontSize: 20.sp
                                        // wordSpacing: 2,
                                        // letterSpacing: 0.1,
                                      ),
                                  TextSpan(
                                    // locale: arabicLocale,
                                    children: [
                                      for (var ayah in ayahs)
                                        if (ayah == ayahs[0])
                                          TextSpan(
                                              text: ayah.numberInSurah == 1
                                                  ? "$surahNameOnScreen\n${AppStrings.basmalah}\n${ayah.text.replaceAll("${AppStrings.basmalah}ِ", "")} ${ayah.numberInSurah.toArabic()} "
                                                  : "${ayah.text} ${ayah.numberInSurah.toArabic()} "),
                                      for (var ayah in ayahs)
                                        if (ayah != ayahs[0])
                                          TextSpan(
                                              text:
                                                  "${ayah.text} ${ayah.numberInSurah.toArabic()} "),
                                    ],
                                  )),
                            ],
                          ),
                        ),

                      //Every page with two surah in it
                      if (pageSurahsList.length == 2)
                        Expanded(
                          child: Column(
                            // mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text.rich(
                                  textAlign: TextAlign.center,
                                  // textDirection: TextDirection.rtl,
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleLarge
                                      ?.copyWith(
                                        height: 1.23.h,
                                        fontFamily:
                                            FontConstants.hafsFontFamily,
                                        // fontSize: 20.sp
                                        // wordSpacing: 2,
                                        // letterSpacing: 0.1,
                                      ),
                                  TextSpan(
                                    children: [
                                      for (var ayah in ayahs)
                                        if (ayah == ayahs[0])
                                          TextSpan(
                                              text: ayah.numberInSurah == 1
                                                  ? "$surahNameOnScreen\n${AppStrings.basmalah}\n${ayah.text.replaceAll("${AppStrings.basmalah}ِ", "")} ${ayah.numberInSurah.toArabic()} "
                                                  : "${ayah.text} ${ayah.numberInSurah.toArabic()} "),
                                      // for (var surah in pageSurahsList)
                                      for (var ayah in ayahs)
                                        if (ayah != ayahs[0])
                                          TextSpan(
                                              text: ayah.numberInSurah == 1
                                                  ? "\n\n${pageSurahsNamesList[1]}\n${AppStrings.basmalah}\n${ayah.text.replaceAll("${AppStrings.basmalah}ِ", "")} ${ayah.numberInSurah.toArabic()} "
                                                  : "${ayah.text} ${ayah.numberInSurah.toArabic()} "),
                                    ],
                                  )),
                            ],
                          ),
                        ),

                      //Every page with three surah in it
                      if (pageSurahsList.length == 3)
                        Expanded(
                          child: Column(
                            // mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text.rich(
                                  textAlign: TextAlign.center,
                                  // textDirection: TextDirection.rtl,
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleLarge
                                      ?.copyWith(
                                        height: 1.1.h,
                                        fontFamily:
                                            FontConstants.hafsFontFamily,
                                        fontSize: 22.sp
                                        // wordSpacing: 2,
                                        // letterSpacing: 0.1,
                                      ),
                                  TextSpan(
                                    children: [
                                      for (var ayah in pageSurahsList[0].ayahs)
                                        if (ayah.page == quranPageNumber)
                                          TextSpan(
                                              text: ayah.numberInSurah == 1
                                                  ? "${pageSurahsNamesList[0]}\n${AppStrings.basmalah}\n${ayah.text.replaceAll("${AppStrings.basmalah}ِ", "")} ${ayah.numberInSurah.toArabic()} "
                                                  : "${ayah.text} ${ayah.numberInSurah.toArabic()} "),
                                      for (var ayah in pageSurahsList[1].ayahs)
                                        if (ayah.page == quranPageNumber)
                                          TextSpan(
                                              text: ayah.numberInSurah == 1
                                                  ? "\n\n${pageSurahsNamesList[1]}\n${AppStrings.basmalah}\n${ayah.text.replaceAll("${AppStrings.basmalah}ِ", "")} ${ayah.numberInSurah.toArabic()} "
                                                  : "${ayah.text} ${ayah.numberInSurah.toArabic()} "),
                                      for (var ayah in pageSurahsList[2].ayahs)
                                        if (ayah.page == quranPageNumber)
                                          TextSpan(
                                              text: ayah.numberInSurah == 1
                                                  ? "\n\n${pageSurahsNamesList[2]}\n${AppStrings.basmalah}\n${ayah.text.replaceAll("${AppStrings.basmalah}ِ", "")} ${ayah.numberInSurah.toArabic()} "
                                                  : "${ayah.text} ${ayah.numberInSurah.toArabic()} "),
                                    ],
                                  )),
                            ],
                          ),
                        ),

                      //For the first page of Al-Tawba Surah
                      if (quranPageNumber == 187)
                        Expanded(
                          child: Column(
                            // mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // for (var ayah in ayahs)
                              Text.rich(
                                  textAlign: TextAlign.center,
                                  // textDirection: TextDirection.rtl,
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleLarge
                                      ?.copyWith(
                                        height: 1.23.h,
                                        fontFamily:
                                            FontConstants.hafsFontFamily,
                                        // fontSize: 18.sp
                                        // wordSpacing: 2,
                                        // letterSpacing: 0.1,
                                      ),
                                  TextSpan(
                                    // locale: arabicLocale,
                                    children: [
                                      for (var ayah in ayahs)
                                        TextSpan(
                                          text: ayah.numberInSurah == 1
                                              ? "$surahNameOnScreen\n${ayah.text} ${ayah.numberInSurah.toArabic()} "
                                              : "${ayah.text} ${ayah.numberInSurah.toArabic()} ",
                                        ),
                                    ],
                                  )),
                            ],
                          ),
                        ),
                      getSeparator(context),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: AppPadding.p8.h),
                        child: Text(
                          (quranPageNumber).toString().tr(),
                          // "\u06DD${794.toArabic()}\u06DD",
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

// Widget _surahsIndexItem(
//     {required surahId, required surahName, required surahNoOfAyahs}) {
//   return ListTile(
//     leading: Text(surahId),
//     title: Text(surahName),
//     trailing: Text(surahNoOfAyahs),
//     onTap: () {},
//   );
// }
//
// Widget _ayahBuilder(AyahModel ayah, BuildContext context) {
//   return Row(
//     mainAxisSize: MainAxisSize.min,
//     children: [
//       Text.rich(TextSpan(children: [
//         TextSpan(
//           text: ayah.text,
//           // textAlign: TextAlign.right,
//           // textDirection: TextDirection.rtl,
//           // style: Theme.of(context).textTheme.bodySmall?.copyWith(
//           //       height: AppSize.s1_5.h,
//           //       fontFamily: FontConstants.meQuranFontFamily,
//           //       wordSpacing: 3,
//           //       letterSpacing: 0.1,
//           //     ),
//         ),
//         // SizedBox(
//         //   width: AppSize.s5.w,
//         // ),
//         TextSpan(
//           text: "\uFD3F${ayah.numberInSurah}\uFD3E",
//           // textAlign: TextAlign.right,
//           // textDirection: TextDirection.rtl,
//           // style: Theme.of(context).textTheme.bodySmall?.copyWith(
//           //       height: AppSize.s1_5.h,
//           //       fontFamily: FontConstants.meQuranFontFamily,
//           //       wordSpacing: 3,
//           //       letterSpacing: 0.1,
//           //     ),
//         ),
//       ]))
//     ],
//   );
// }
}
