part of 'home_cubit.dart';

abstract class HomeState {
  const HomeState();
}

class HomeInitial extends HomeState {


}

class HomeChangeBotNavIndexState extends HomeState {


}

class HomeGetQuranDataLoadingState extends HomeState {


}

class HomeGetQuranDataSuccessState extends HomeState {
  final List<QuranModel> quranList;

  const HomeGetQuranDataSuccessState(this.quranList);


}

class HomeGetQuranDataErrorState extends HomeState {
  final String error;

  const HomeGetQuranDataErrorState(this.error);


}

class HomeGetHadithDataLoadingState extends HomeState {

}

class HomeGetHadithDataSuccessState extends HomeState {
  final List<HadithModel> hadithList;

  const HomeGetHadithDataSuccessState(this.hadithList);

}

class HomeGetHadithDataErrorState extends HomeState {
  final String error;

  const HomeGetHadithDataErrorState(this.error);

}

class HomeGetAzkarDataLoadingState extends HomeState {

}

class HomeGetAzkarDataSuccessState extends HomeState {
  final List<AzkarModel> azkarList;

  const HomeGetAzkarDataSuccessState(this.azkarList);

}

class HomeGetAzkarDataErrorState extends HomeState {
  final String error;

  const HomeGetAzkarDataErrorState(this.error);

}


