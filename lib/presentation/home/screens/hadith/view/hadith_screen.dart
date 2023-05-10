import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:elmuslim_app/presentation/resources/routes_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:elmuslim_app/app/utils/extensions.dart';
import 'package:elmuslim_app/domain/models/hadith/hadith_model.dart';
import 'package:elmuslim_app/presentation/common/components/components.dart';
import 'package:elmuslim_app/presentation/home/screens/hadith/cubit/hadith_cubit.dart';
import 'package:elmuslim_app/presentation/resources/color_manager.dart';
import 'package:elmuslim_app/presentation/resources/font_manager.dart';
import 'package:elmuslim_app/presentation/resources/values.dart';

class HadithScreen extends StatelessWidget {
  const HadithScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HadithCubit, HadithState>(
      listener: (context, state) {},
      builder: (context, state) {
        HadithCubit cubit = HadithCubit.get(context);
        List<HadithModel> hadithList = cubit.hadithList;
        return ConditionalBuilder(
          condition: hadithList.isNotEmpty,
          builder: (BuildContext context) {
            return ListView.separated(
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) => _hadithsIndexItem(
                  hadithModel: hadithList[index],
                  index: index,
                  context: context),
              separatorBuilder: (context, index) => getSeparator(context),
              itemCount: hadithList.length,
            );
          },
          fallback: (BuildContext context) {
            return const Center(
                child: CircularProgressIndicator(color: ColorManager.gold));
          },
        );
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
          padding: EdgeInsets.only(top: AppPadding.p5.h),
          child: Text(
            (index + 1).toString().tr(),
            style: Theme.of(context)
                .textTheme
                .titleSmall
                ?.copyWith(fontFamily: FontConstants.uthmanTNFontFamily),
          ),
        ),
        title: Text(
          hadithModel.hadith.orEmpty().split('''

''')[0].orEmpty(),
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontFamily: FontConstants.meQuranFontFamily,
              wordSpacing: AppSize.s5.w,
              letterSpacing: AppSize.s0_1.w),
        ),
        onTap: () {
          Navigator.pushNamed(
            context,
            Routes.hadithRoute,
            arguments: {
              'hadithModel': hadithModel,
            },
          );
        },
      ),
    );
  }
}
