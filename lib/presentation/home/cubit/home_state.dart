part of 'home_cubit.dart';

abstract class HomeState extends Equatable {
  const HomeState();
}

class HomeInitial extends HomeState {
  @override
  List<Object> get props => [];
}

class HomeChangeBotNavIndexState extends HomeState {
  @override
  List<Object?> get props => [];
}

class HomeGetQuranDataLoadingState extends HomeState {
  @override
  List<Object?> get props => [];
}

class HomeGetQuranDataSuccessState extends HomeState {
  final List<QuranModel> quranList;

  const HomeGetQuranDataSuccessState(this.quranList);

  @override
  List<Object?> get props => [quranList];
}

class HomeGetQuranDataErrorState extends HomeState {
  final String error;

  const HomeGetQuranDataErrorState(this.error);

  @override
  List<Object?> get props => [error];
}

class HomeGetHadithDataLoadingState extends HomeState {
  @override
  List<Object?> get props => [];
}

class HomeGetHadithDataSuccessState extends HomeState {
  final List<HadithModel> hadithList;

  const HomeGetHadithDataSuccessState(this.hadithList);
  @override
  List<Object?> get props => [];
}

class HomeGetHadithDataErrorState extends HomeState {
  final String error;

  const HomeGetHadithDataErrorState(this.error);
  @override
  List<Object?> get props => [error];
}

class HomeGetAzkarDataLoadingState extends HomeState {
  @override
  List<Object?> get props => [];
}

class HomeGetAzkarDataSuccessState extends HomeState {
  final List<AzkarModel> azkarList;

  const HomeGetAzkarDataSuccessState(this.azkarList);
  @override
  List<Object?> get props => [];
}

class HomeGetAzkarDataErrorState extends HomeState {
  final String error;

  const HomeGetAzkarDataErrorState(this.error);
  @override
  List<Object?> get props => [error];
}


