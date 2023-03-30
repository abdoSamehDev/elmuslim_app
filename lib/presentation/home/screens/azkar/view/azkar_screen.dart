import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islamic_app/app/utils/extensions.dart';
import 'package:islamic_app/domain/models/azkar/azkar_model.dart';
import 'package:islamic_app/presentation/common/components/components.dart';
import 'package:islamic_app/presentation/home/screens/azkar/cubit/azkar_cubit.dart';
import 'package:islamic_app/presentation/resources/color_manager.dart';
import 'package:islamic_app/presentation/resources/font_manager.dart';
import 'package:islamic_app/presentation/resources/values.dart';
import 'package:islamic_app/presentation/zekr_builder/view/zekr_builder_view.dart';

class AzkarScreen extends StatelessWidget {
  const AzkarScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AzkarCubit, AzkarState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state is AzkarGetDataLoadingState) {
          return const Center(
              child: CircularProgressIndicator(color: ColorManager.gold));
        } else if (state is AzkarGetDataSuccessState) {
          List<String> azkarCategoryList =
              List.from(state.azkarList.map((e) => e.category).toSet());
          return ListView.separated(
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) => _azkarIndexItem(
                azkarId: (index + 1).toString().tr(),
                azkarName: azkarCategoryList[index].orEmpty(),
                azkarList: state.azkarList,
                index: index,
                // pageNo: state.azkarList[index].ayahs[0].page.toString(),
                context: context),
            separatorBuilder: (context, index) => getSeparator(context),
            itemCount: azkarCategoryList.length,
          );
        } else if (state is AzkarGetDataErrorState) {
          return Container();
        } else {
          return Container();
        }
      },
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
          padding:  EdgeInsets.only(top: AppPadding.p5.h),
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
                wordSpacing: 3,
                letterSpacing: 0.1,
              ),
        ),
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => ZekrBuilderView(azkarList: azkarList, category: azkarName,)));
        },
      ),
    );
  }
}
