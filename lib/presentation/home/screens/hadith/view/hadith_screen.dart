import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:islamic_app/app/utils/extentions.dart';
import 'package:islamic_app/presentation/common/components/components.dart';
import 'package:islamic_app/presentation/home/screens/hadith/cubit/hadith_cubit.dart';
import 'package:islamic_app/presentation/resources/color_manager.dart';
import 'package:islamic_app/presentation/resources/font_manager.dart';

class HadithScreen extends StatelessWidget {
  const HadithScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HadithCubit()..getHadithData(),
      child: BlocConsumer<HadithCubit, HadithState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is HadithGetDataLoadingState) {
            return const Center(
                child: CircularProgressIndicator(color: ColorManager.gold));
          } else if (state is HadithGetDataSuccessState) {
            return ListView.separated(
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) => _hadithsIndexItem(
                  hadithId: (index + 1).toString(),
                  hadithName: state.hadithList[index].hadith.orEmpty().split('''

''')[0].orEmpty(),
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
      ),
    );
  }

  Widget _hadithsIndexItem(
      {required String hadithId,
      required String hadithName,
      // required String pageNo,
      required BuildContext context}) {
    return ListTile(
      style: ListTileStyle.list,
      leading: Text(
        hadithId,
        style: Theme.of(context)
            .textTheme
            .titleSmall
            ?.copyWith(fontFamily: FontConstants.meQuranFontFamily),
      ),
      title: Text(
        hadithName,
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
