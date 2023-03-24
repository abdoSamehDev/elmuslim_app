import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:islamic_app/app/utils/extentions.dart';
import 'package:islamic_app/presentation/common/components/components.dart';
import 'package:islamic_app/presentation/home/screens/azkar/cubit/azkar_cubit.dart';
import 'package:islamic_app/presentation/resources/color_manager.dart';
import 'package:islamic_app/presentation/resources/font_manager.dart';

class AzkarScreen extends StatelessWidget {
  const AzkarScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AzkarCubit()..getAzkarData(),
      child: BlocConsumer<AzkarCubit, AzkarState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is AzkarGetDataLoadingState) {
            return const Center(
                child: CircularProgressIndicator(color: ColorManager.gold));
          } else if (state is AzkarGetDataSuccessState) {
            List<String> azkarCategoryList = List.from(state.azkarList.map((e) => e.category).toSet());
            return ListView.separated(
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) => _azkarIndexItem(
                  azkarId: (index + 1).toString(),
                  azkarName: azkarCategoryList[index].orEmpty(),
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
      ),
    );
  }

  Widget _azkarIndexItem(
      {required String azkarId,
        required String azkarName,
        // required String pageNo,
        required BuildContext context}) {
    return ListTile(
      style: ListTileStyle.list,
      leading: Text(
        azkarId,
        style: Theme.of(context)
            .textTheme
            .titleSmall
            ?.copyWith(fontFamily: FontConstants.meQuranFontFamily),
      ),
      title: Text(
          azkarName,
          style: Theme.of(context)
              .textTheme
              .titleLarge
        // ?.copyWith(fontFamily: FontConstants.meQuranFontFamily),
      ),
      // trailing: Text(
      //   pageNo,
      //   style: Theme.of(context)
      //       .textTheme
      //       .titleSmall
      //       ?.copyWith(fontFamily: FontConstants.meQuranFontFamily),
      // ),
      onTap: () {},
    );
  }
}
