import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:islamic_app/presentation/common/components/components.dart';
import 'package:islamic_app/presentation/home/screens/quran/cubit/quran_cubit.dart';
import 'package:islamic_app/presentation/resources/color_manager.dart';
import 'package:islamic_app/presentation/resources/font_manager.dart';

class QuranScreen extends StatelessWidget {
  const QuranScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => QuranCubit()..getQuranData(),
      child: BlocConsumer<QuranCubit, QuranState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is QuranGetDataLoadingState) {
            return const Center(
                child: CircularProgressIndicator(color: ColorManager.gold));
          } else if (state is QuranGetDataSuccessState) {
            return ListView.separated(
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) =>
                  _surahsIndexItem(
                      surahId: (index + 1).toString(),
                      surahName: state.quranList[index].name,
                      pageNo: state.quranList[index].ayahs[0].page.toString(),
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
      ),
    );
  }

  Widget _surahsIndexItem({required String surahId,
    required String surahName,
    required String pageNo,
    required BuildContext context}) {
    return ListTile(
      style: ListTileStyle.list,
      leading: Text(
        surahId,
        style: Theme
            .of(context)
            .textTheme
            .titleSmall
            ?.copyWith(fontFamily: FontConstants.meQuranFontFamily),
      ),
      title: Text(
        surahName,
        style: Theme
            .of(context)
            .textTheme
            .titleLarge
            ?.copyWith(fontFamily: FontConstants.meQuranFontFamily),
      ),
      trailing: Text(
        pageNo,
        style: Theme
            .of(context)
            .textTheme
            .titleSmall
            ?.copyWith(fontFamily: FontConstants.meQuranFontFamily),
      ),
      onTap: () {},
    );
  }
}
