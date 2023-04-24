import 'package:easy_localization/easy_localization.dart';
import 'package:elmuslim_app/presentation/resources/routes_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:elmuslim_app/domain/models/quran/quran_model.dart';
import 'package:elmuslim_app/presentation/common/components/components.dart';
import 'package:elmuslim_app/presentation/home/screens/quran/cubit/quran_cubit.dart';
import 'package:elmuslim_app/presentation/resources/color_manager.dart';
import 'package:elmuslim_app/presentation/resources/font_manager.dart';
import 'package:elmuslim_app/presentation/resources/language_manager.dart';
import 'package:elmuslim_app/presentation/resources/values.dart';

class QuranScreen extends StatelessWidget {
  const QuranScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<QuranCubit, QuranState>(
      listener: (context, state) {},
      builder: (context, state) {
        //Get Current App Locale
        final currentLocale = context.locale;

        //Check if current app language is English
        bool isEnglish =
            currentLocale.languageCode == LanguageType.english.getValue();

        if (state is QuranGetDataLoadingState) {
          return const Center(
              child: CircularProgressIndicator(color: ColorManager.gold));
        } else if (state is QuranGetDataSuccessState) {
          return ListView.separated(
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) => _surahsIndexItem(
                surahId: (index + 1).toString().tr(),
                surahName: state.quranList[index].name,
                englishSurahName: state.quranList[index].englishName,
                pageNo: state.quranList[index].ayahs[0].page,
                quranList: state.quranList,
                isEnglish: isEnglish,
                context: context),
            separatorBuilder: (context, index) => getSeparator(context),
            itemCount: state.quranList.length,
          );
        } else if (state is QuranGetDataErrorState) {
          return Container();
        } else {
          return Container();
        }
      },
    );
  }

  Widget _surahsIndexItem(
      {required String surahId,
      required String surahName,
      required String englishSurahName,
      required int pageNo,
      required List<QuranModel> quranList,
      required bool isEnglish,
      required BuildContext context}) {
    return Padding(
      padding: EdgeInsets.only(bottom: AppPadding.p5.h),
      child: ListTile(
        style: ListTileStyle.list,
        leading: Padding(
          padding: EdgeInsets.only(top: AppPadding.p5.h),
          child: Text(
            surahId,
            style: Theme.of(context)
                .textTheme
                .titleSmall
                ?.copyWith(fontFamily: FontConstants.uthmanTNFontFamily),
          ),
        ),
        title: Padding(
          padding: EdgeInsets.symmetric(vertical: AppPadding.p5.h),
          child: Text(
            isEnglish ? englishSurahName : surahName,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontFamily: FontConstants.meQuranFontFamily,
                wordSpacing: AppSize.s5.w,
                letterSpacing: AppSize.s0_1.w),
          ),
        ),
        subtitle: Padding(
          padding: EdgeInsets.symmetric(vertical: AppPadding.p5.h),
          child: Text(
            isEnglish ? surahName : englishSurahName,
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                fontFamily: FontConstants.meQuranFontFamily,
                color: Theme.of(context).unselectedWidgetColor,
                wordSpacing: AppSize.s5.w,
                letterSpacing: AppSize.s0_1.w),
          ),
        ),
        trailing: Text(
          pageNo.toString().tr(),
          style: Theme.of(context)
              .textTheme
              .titleSmall
              ?.copyWith(fontFamily: FontConstants.uthmanTNFontFamily),
        ),
        onTap: () {
          Navigator.pushNamed(
            context,
            Routes.quranRoute,
            arguments: {
              'quranList': quranList,
              'pageNo': pageNo,
            },
          );
        },
      ),
    );
  }
}
