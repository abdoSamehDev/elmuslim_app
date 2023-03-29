import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islamic_app/app/utils/extentions.dart';
import 'package:islamic_app/domain/models/hadith/hadith_model.dart';
import 'package:islamic_app/presentation/common/components/components.dart';
import 'package:islamic_app/presentation/hadith_builder/view/hadith_builder_view.dart';
import 'package:islamic_app/presentation/home/screens/hadith/cubit/hadith_cubit.dart';
import 'package:islamic_app/presentation/resources/color_manager.dart';
import 'package:islamic_app/presentation/resources/font_manager.dart';
import 'package:islamic_app/presentation/resources/values.dart';

class HadithScreen extends StatelessWidget {
  const HadithScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<HadithCubit, HadithState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is HadithGetDataLoadingState) {
            return const Center(
                child: CircularProgressIndicator(color: ColorManager.gold));
          } else if (state is HadithGetDataSuccessState) {
            return ListView.separated(
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) => _hadithsIndexItem(

                  hadithModel: state.hadithList[index],
                  index: index,
                  // pageNo: state.hadithList[index].ayahs[0].page.toString(),
                  context: context),
              separatorBuilder: (context, index) => getSeparator(context),
              itemCount: state.hadithList.length,
            );
          } else if (state is HadithGetDataErrorState) {
            return Container();
          } else {
            return Container();
          }
        },
    );
  }

  Widget _hadithsIndexItem(
      {required HadithModel hadithModel,
        required int index,
      required BuildContext context}) {
    return Padding(
      padding: EdgeInsets.only(bottom: AppPadding.p5.h),
      child: ListTile(
        style: ListTileStyle.list,
        leading: Padding(
          padding:  EdgeInsets.only(top: AppPadding.p5.h),
          child: Text(
              (index + 1).toArabic(),
            style: Theme.of(context)
                .textTheme
                .bodySmall
                // ?.copyWith(fontFamily: FontConstants.meQuranFontFamily),
          ),
        ),
        title: Text(
            hadithModel.hadith.orEmpty().split('''

''')[0].orEmpty(),
          style: Theme.of(context)
              .textTheme
              .titleLarge
              ?.copyWith(fontFamily: FontConstants.meQuranFontFamily, wordSpacing: 5, letterSpacing: 0.1),
        ),
        // trailing: Text(
        //   pageNo,
        //   style: Theme.of(context)
        //       .textTheme
        //       .titleSmall
        //       ?.copyWith(fontFamily: FontConstants.meQuranFontFamily),
        // ),
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => HadithBuilderView(hadithModel: hadithModel)));
        },
      ),
    );
  }
}
