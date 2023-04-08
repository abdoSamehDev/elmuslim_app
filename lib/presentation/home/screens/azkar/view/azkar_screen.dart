import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:elmuslim_app/app/utils/di.dart';
import 'package:elmuslim_app/app/utils/extensions.dart';
import 'package:elmuslim_app/domain/models/azkar/azkar_model.dart';
import 'package:elmuslim_app/presentation/common/components/components.dart';
import 'package:elmuslim_app/presentation/home/screens/azkar/cubit/azkar_cubit.dart';
import 'package:elmuslim_app/presentation/resources/color_manager.dart';
import 'package:elmuslim_app/presentation/resources/font_manager.dart';
import 'package:elmuslim_app/presentation/resources/values.dart';
import 'package:elmuslim_app/presentation/zekr_builder/view/zekr_builder_view.dart';

class AzkarScreen extends StatelessWidget {
  const AzkarScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => instance<AzkarCubit>()..getAzkarData()..resetCounter(),
      child: BlocConsumer<AzkarCubit, AzkarState>(
        listener: (context, state) {},
        builder: (context, state) {
          AzkarCubit cubit = AzkarCubit.get(context);
          if (state is AzkarGetDataLoadingState) {
            return const Center(
                child: CircularProgressIndicator(color: ColorManager.gold));
          } else if (state is AzkarGetDataSuccessState) {
            return ListView.separated(
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                return _azkarIndexItem(
                    azkarId: (index + 1).toString().tr(),
                    azkarName: cubit
                        .getAzkarCategories(azkarList: state.azkarList)[index]
                        .orEmpty(),
                    azkarList: state.azkarList,
                    index: index,
                    context: context);
              },
              separatorBuilder: (context, index) => getSeparator(context),
              itemCount:
                  cubit.getAzkarCategories(azkarList: state.azkarList).length,
            );
          } else if (state is AzkarGetDataErrorState) {
            return Container();
          } else {
            return Container();
          }
        },
      ),
    );
  }

  Widget _azkarIndexItem(
      {required String azkarId,
      required String azkarName,
      required List<AzkarModel> azkarList,
      required int index,
      // required String pageNo,
      required BuildContext context}) {
    return Padding(
      padding: EdgeInsets.only(bottom: AppPadding.p5.h),
      child: ListTile(
        style: ListTileStyle.list,
        leading: Padding(
          padding: EdgeInsets.only(top: AppPadding.p5.h),
          child: Text(
            azkarId,
            style: Theme.of(context)
                .textTheme
                .titleSmall
                ?.copyWith(fontFamily: FontConstants.uthmanTNFontFamily),
          ),
        ),
        title: Text(
          azkarName,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontFamily: FontConstants.meQuranFontFamily,
                wordSpacing: AppSize.s3.w,
                letterSpacing: AppSize.s0_1.w,
              ),
        ),
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ZekrBuilderView(
                        azkarList: azkarList,
                        category: azkarName,
                      )));
        },
      ),
    );
  }
}
