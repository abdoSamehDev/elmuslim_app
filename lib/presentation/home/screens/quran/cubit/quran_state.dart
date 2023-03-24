part of 'quran_cubit.dart';

abstract class QuranState {
  const QuranState();
}

class QuranInitial extends QuranState {


}

class QuranGetDataLoadingState extends QuranState {


}

class QuranGetDataSuccessState extends QuranState {
  final List<QuranModel> quranList;

  const QuranGetDataSuccessState(this.quranList);


}

class QuranGetDataErrorState extends QuranState {
  final String error;

  const QuranGetDataErrorState(this.error);


}




