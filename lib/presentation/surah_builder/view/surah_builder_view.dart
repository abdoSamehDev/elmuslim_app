import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islamic_app/app/utils/extentions.dart';
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

        return Scaffold(
          // appBar: AppBar(
          //   title: Text(
          //     surahName,
          //     style: Theme
          //         .of(context)
          //         .textTheme
          //         .titleLarge
          //         ?.copyWith(color: ColorManager.gold, fontFamily: FontConstants.meQuranFontFamily),
          //   ),
          // ),
          // floatingActionButton: FloatingActionButton(
          //   onPressed: () {
          //     // _pageController.animateToPage(3, curve: Curves.ease, duration: const Duration(milliseconds: 300));
          //     _count++;
          //   },
          //   enableFeedback: true,
          //   backgroundColor: Theme.of(context).secondaryHeaderColor,
          //   child: SvgPicture.asset(
          //     ImageAsset.azkarIcon,
          //     width: AppSize.s24.h,
          //     height: AppSize.s24.h,
          //     color: ColorManager.gold,
          //     // Theme.of(context).primaryColor,
          //   ),
          // ),
          // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
          // floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
          body: SafeArea(
            child: Padding(
              padding: EdgeInsets.all(AppPadding.p8.r),
              child: PageView.builder(
                controller: pageController,
                itemCount: 604,
                itemBuilder: (BuildContext context, int index) {
                  // final List<QuranModel> quranPageFromName =
                  //     cubit.getQuranPageFromName(
                  //         quranList: quranList,
                  //         surahName: surahName,
                  //         pageNo: index + 1);
                  final List<AyahModel> ayahs = cubit.getAyahsFromPageNo(
                      quranList: quranList, pageNo: index + 1);
                  final String surahNameOnScreen = cubit.getSurahNameFromPageNo(
                      quranList: quranList, pageNo: index + 1);
                  // int count = cubit.count;
                  return Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "${AppStrings.juz.tr()}: ${ayahs[0].juz.toString().tr()}، ${AppStrings.hizb.tr()}: ${ayahs[0].hizbQuarter.toString().tr()} ",
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
                                    fontFamily:
                                        FontConstants.uthmanTNFontFamily,
                                    color: Theme.of(context)
                                        .unselectedWidgetColor),
                          ),
                        ],
                      ),
                      getSeparator(context),
                      // Text("\u0668",
                      //     style: Theme.of(context)
                      //         .textTheme
                      //         .bodyLarge
                      //         ?.copyWith(
                      //       // fontWeight: FontWeightsManager.regular,
                      //       height: AppSize.s1_5.h,
                      //       // fontSize: 15,
                      //       fontFamily:
                      //       FontConstants.hafsFontFamily,
                      //       // wordSpacing: 2,
                      //       // letterSpacing: 0.1,
                      //     ),
                      // ),
                      // Text("۞ ٱلَّذِينَ يَنقُضُونَ عَهْدَ ٱللَّهِ مِنۢ بَعْدِ مِيثَـٰقِهِۦ وَيَقْطَعُونَ مَآ أَمَرَ ٱللَّهُ بِهِۦٓ أَن يُوصَلَ وَيُفْسِدُونَ فِى ٱلْأَرْضِ ۚ أُوْلَـٰٓئِكَ هُمُ ٱلْخَـٰسِرُونَ كَثِيرًۭا وَيَهْدِى ٣٠",
                      //   style: Theme.of(context)
                      //       .textTheme
                      //       .headlineLarge
                      //       ?.copyWith(
                      //     // fontWeight: FontWeightsManager.regular,
                      //     height: AppSize.s1_5.h,
                      //     // fontSize: 15,
                      //     fontFamily:
                      //     FontConstants.hafsFontFamily,
                      //     // wordSpacing: 2,
                      //     // letterSpacing: 0.1,
                      //   ),),
                      if (index + 1 == 1 || index + 1 == 2)
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
                                      fontFamily:
                                          FontConstants.hafsFontFamily,
                                      // wordSpacing: 3,
                                      // letterSpacing: 0.1,
                                    ),
                                TextSpan(
                                  children: [
                                    for (var ayah in ayahs)
                                      if (ayah.page == 1)
                                        TextSpan(
                                          text: ayah.numberInSurah == 1
                                              ? "$surahNameOnScreen\n${ayah.text} ${ayah.numberInSurah.toArabic()} \n\n"
                                              : "${ayah.text} ${ayah.numberInSurah.toArabic()} ",
                                        ),
                                    for (var ayah in ayahs)
                                      if (ayah.page != 1)
                                        TextSpan(
                                          text: ayah.numberInSurah == 1
                                              ? "$surahNameOnScreen\n${AppStrings.basmalah}\n\n${ayah.text.replaceAll("${AppStrings.basmalah}ِ", "")} ${ayah.numberInSurah} "
                                              : "${ayah.text} ${ayah.numberInSurah.toArabic()} ",
                                        ),
                                  ],
                                )),
                          ),
                        ),
                      if (index + 1 != 1 && index + 1 != 2)
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // for (var ayah in ayahs)
                                Text.rich(
                                    textAlign: TextAlign.center,
                                    // textDirection: TextDirection.rtl,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleLarge
                                        ?.copyWith(
                                          height: AppSize.s1_5.h,
                                          fontFamily:
                                              FontConstants.hafsFontFamily,
                                          // wordSpacing: 2,
                                          // letterSpacing: 0.1,
                                        ),
                                    TextSpan(

                                      locale: arabicLocale,
                                      children: [
                                        for (var ayah in ayahs)
                                          if (ayah.page != 187)
                                            TextSpan(

                                              text: ayah.numberInSurah == 1
                                                  ? "$surahNameOnScreen\n${AppStrings.basmalah}\n${ayah.text.replaceAll("${AppStrings.basmalah}ِ", "")} ${ayah.numberInSurah} "
                                                  : "${ayah.text} ${ayah.numberInSurah.toArabic()} ",
                                            ),
                                        for (var ayah in ayahs)
                                          if (ayah.page == 187)
                                            TextSpan(
                                              text: ayah.numberInSurah == 1
                                                  ? "$surahNameOnScreen\n${ayah.text} ${ayah.numberInSurah} "
                                                  : "${ayah.text} ${ayah.numberInSurah.toArabic()} ",
                                            ),
                                      ],
                                    )),
                            ],
                          ),
                        ),

                      // for (var ayah in ayahs)
                      // _ayahBuilder(ayah, context),
                      // Expanded(
                      //   child: Text.rich(
                      //       // style:
                      //       textAlign: TextAlign.center,
                      //       textDirection: TextDirection.rtl,
                      //       style: Theme.of(context)
                      //           .textTheme
                      //           .bodyLarge
                      //           ?.copyWith(
                      //             height: AppSize.s1_5.h,
                      //             fontFamily: FontConstants.elMessiriFontFamily,
                      //             wordSpacing: 3,
                      //             letterSpacing: 0.1,
                      //           ),
                      //       TextSpan(children: [
                      //         for (var ayah in ayahs)
                      //           TextSpan(
                      //             text:
                      //                 "${ayah.text} \uFD3F${ayah.numberInSurah.toArabic()}\uFD3E ",
                      //             // textAlign: TextAlign.right,
                      //             // textDirection: TextDirection.rtl,
                      //             // style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      //             //       height: AppSize.s1_5.h,
                      //             //       fontFamily: FontConstants.meQuranFontFamily,
                      //             //       wordSpacing: 3,
                      //             //       letterSpacing: 0.1,
                      //             //     ),
                      //           ),
                      //       ])),
                      // ),
                      //     for (var ayah in ayahs)
                      //       if (index == 0)
                      //         Row(
                      //           children: [
                      //             Text(
                      //                 ayah.text,
                      //                 textAlign: TextAlign.right,
                      //                 textDirection: TextDirection.rtl,
                      //                 style: Theme.of(context)
                      //                     .textTheme
                      //                     .bodyLarge
                      //                     ?.copyWith(
                      //                       height: AppSize.s1_5.h,
                      //                       fontFamily: FontConstants
                      //                           .meQuranFontFamily,
                      //                       wordSpacing: 3,
                      //                       letterSpacing: 0.1,
                      //                     )),
                      //             Text(
                      // "\uFD3F${ayah.numberInSurah}\uFD3E",
                      //                 textAlign: TextAlign.right,
                      //                 textDirection: TextDirection.rtl,
                      //                 style: Theme.of(context)
                      //                     .textTheme
                      //                     .bodyLarge
                      //                     ?.copyWith(
                      //                       height: AppSize.s1_5.h,
                      //                       fontFamily: FontConstants
                      //                           .meQuranFontFamily,
                      //                       wordSpacing: 3,
                      //                       letterSpacing: 0.1,
                      //                     )),
                      //           ],
                      //         ),
                      //     for (var ayah in ayahs)
                      //       if (index != 0)
                      //         Text(
                      //             ayah.text.replaceAll(
                      //                 "${AppStrings.basmalah}ِ",
                      //                 ""),
                      //             textAlign: TextAlign.right,
                      //             textDirection: TextDirection.rtl,
                      //             style: Theme.of(context)
                      //                 .textTheme
                      //                 .bodyLarge
                      //                 ?.copyWith(
                      //               height: AppSize.s1_5.h,
                      //               fontFamily: FontConstants
                      //                   .meQuranFontFamily,
                      //               wordSpacing: 3,
                      //               letterSpacing: 0.1,
                      //             )),
                      getSeparator(context),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: AppPadding.p8.h),
                        child: Text(
                          (index + 1).toString().tr(),
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
                      // Column(
                      //   mainAxisAlignment: MainAxisAlignment.center,
                      //   crossAxisAlignment: CrossAxisAlignment.center,
                      //   children: [
                      //     Padding(
                      //       padding: EdgeInsets.all(AppPadding.p12.h),
                      //       child: Column(
                      //         mainAxisAlignment: MainAxisAlignment.center,
                      //         crossAxisAlignment: CrossAxisAlignment.center,
                      //         children: [
                      //
                      //           Padding(
                      //             padding: EdgeInsets.all(AppPadding.p8.h),
                      //             child: Text(
                      //               "$count/${surahFromName[index].count
                      //                   .isEmpty
                      //                   ? "1"
                      //                   : surahFromName[index]
                      //                   .count}",
                      //               textAlign: TextAlign.center,
                      //               style: Theme
                      //                   .of(context)
                      //                   .textTheme
                      //                   .bodySmall
                      //                   ?.copyWith(
                      //                 height: AppSize.s1.h,
                      //                 // color:
                      //                 // // Theme.of(context).unselectedWidgetColor,
                      //                 // ColorManager.gold),
                      //               ),
                      //             ),
                      //           ),
                      //           ElevatedButton(
                      //             style: ElevatedButton.styleFrom(
                      //               backgroundColor:
                      //               Theme
                      //                   .of(context)
                      //                   .secondaryHeaderColor,
                      //               enableFeedback: true,
                      //               shape: RoundedRectangleBorder(
                      //                 borderRadius:
                      //                 BorderRadius.circular(AppSize.s8.r),
                      //               ),
                      //             ),
                      //             onPressed: () {
                      //               cubit.zekrCounter(int.parse(surahFromName[index].count
                      //                   .isEmpty
                      //                   ? "1"
                      //                   : surahFromName[index]
                      //                   .count), _pageController, index);
                      //             },
                      //             child: SvgPicture.asset(
                      //               ImageAsset.azkarIcon,
                      //               width: AppSize.s50.h,
                      //               height: AppSize.s50.h,
                      //               color: ColorManager.gold,
                      //               // Theme.of(context).primaryColor,
                      //             ),
                      //           ),
                      //
                      //         ],
                      //       ),
                      //     ),
                      //
                      //     // IconButton(
                      //     //   tooltip: "",
                      //     //   color: Theme.of(context).secondaryHeaderColor,
                      //     //   onPressed: () {},
                      //     //   icon: SvgPicture.asset(
                      //     //     ImageAsset.azkarIcon,
                      //     //     width: AppSize.s24.h,
                      //     //     height: AppSize.s24.h,
                      //     //     color: ColorManager.gold,
                      //     //     // Theme.of(context).primaryColor,
                      //     //   ),
                      //     // ),
                      //     // getSeparator(context),
                      //
                      //   ],
                      // ),
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
