import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:islamic_app/presentation/common/components/components.dart';
import 'package:islamic_app/presentation/home/screens/quran/cubit/quran_cubit.dart';

class SurahBuilderView extends StatelessWidget {
  const SurahBuilderView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<QuranCubit, QuranState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state is QuranGetDataLoadingState) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is QuranGetDataSuccessState) {
          return ListView.separated(
            itemBuilder: (context, index) => _surahsIndexItem(
              surahId: index.toString(),
              surahName: state.quranList[index].name,
              surahNoOfAyahs: state.quranList[index].ayahs.length.toString(),
            ),
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

  Widget _surahsIndexItem({
    required surahId, required surahName, required surahNoOfAyahs
  }){
    return ListTile(
      leading: Text(surahId),
      title: Text(surahName),
      trailing: Text(surahNoOfAyahs),
      onTap: (){},
    );
  }
}
