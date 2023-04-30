import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:elmuslim_app/app/utils/app_prefs.dart';
import 'package:elmuslim_app/data/data_source/local/local_data_source.dart';
import 'package:elmuslim_app/data/repository/repository_impl.dart';
import 'package:elmuslim_app/domain/repository/repository.dart';
import 'package:elmuslim_app/domain/usecase/azkar_usecase.dart';
import 'package:elmuslim_app/domain/usecase/hadith_usecase.dart';
import 'package:elmuslim_app/domain/usecase/quran_usecase.dart';
import 'package:elmuslim_app/presentation/home/cubit/home_cubit.dart';
import 'package:elmuslim_app/presentation/home/screens/azkar/cubit/azkar_cubit.dart';
import 'package:elmuslim_app/presentation/home/screens/hadith/cubit/hadith_cubit.dart';
import 'package:elmuslim_app/presentation/home/screens/quran/cubit/quran_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../presentation/home/viewmodel/home_viewmodel.dart';

final instance = GetIt.instance;

Future initAppModule() async {
  // app module is a module where we put all generic dependencies.
  //shared prefs instance
  final sharedPrefs = await SharedPreferences.getInstance();
  instance.registerLazySingleton<SharedPreferences>(() => sharedPrefs);

  //app prefs instance
  instance.registerLazySingleton<AppPreferences>(() => AppPreferences());

  //BLoC
  instance.registerFactory<HomeCubit>(() => HomeCubit());
  instance.registerFactory<QuranCubit>(() => QuranCubit());
  instance.registerFactory<HadithCubit>(() => HadithCubit());
  instance.registerFactory<AzkarCubit>(() => AzkarCubit());

  //Repository
  instance.registerLazySingleton<Repository>(
      () => RepositoryImpl(instance<LocalDataSource>()));

  //Data Source
  instance.registerLazySingleton<LocalDataSource>(() => LocalDataSourceImpl());

  //Page Controller
  instance.registerFactory<PageController>(() => PageController());

  //Text Editing Controller
  instance.registerFactory<TextEditingController>(() => TextEditingController());
}

void initQuranModule() {
  if (!GetIt.I.isRegistered<QuranUseCase>()) {
    instance.registerFactory<QuranUseCase>(() => QuranUseCase());
    instance.registerFactory<HomeViewModel>(() => HomeViewModel());
  }
}

void initHadithModule() {
  if (!GetIt.I.isRegistered<HadithUseCase>()) {
    instance.registerFactory<HadithUseCase>(() => HadithUseCase());
  }
}

void initAzkarModule() {
  if (!GetIt.I.isRegistered<AzkarUseCase>()) {
    instance.registerFactory<AzkarUseCase>(() => AzkarUseCase());
  }
}
