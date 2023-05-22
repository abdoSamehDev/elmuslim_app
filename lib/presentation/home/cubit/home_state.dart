part of 'home_cubit.dart';

abstract class HomeState {
  const HomeState();
}

class HomeInitial extends HomeState {}

class HomeChangeBotNavIndexState extends HomeState {}

class HomeChangeAppThemeState extends HomeState {}

class HomeChangeAppLanguageState extends HomeState {}

class QuranBookMarkPageState extends HomeState {}

class QuranRemoveBookMarkState extends HomeState {}

class CheckQuranBookMarkPageState extends HomeState {}

class GetQuranBookMarkPageState extends HomeState {}
