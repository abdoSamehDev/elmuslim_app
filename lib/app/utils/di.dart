import 'package:elmuslim_app/domain/usecase/adhkar_usecase.dart';
import 'package:elmuslim_app/domain/usecase/del_all_custom_adhkar_usecase.dart';
import 'package:elmuslim_app/domain/usecase/del_custom_dhikr_by_id_usecase.dart';
import 'package:elmuslim_app/domain/usecase/get_all_custom_adhkar_usecase.dart';
import 'package:elmuslim_app/domain/usecase/get_custom_dhikr_by_id_usecase.dart';
import 'package:elmuslim_app/domain/usecase/insert_new_dhikr_usecase.dart';
import 'package:elmuslim_app/domain/usecase/update_custom_dhikr.dart';
import 'package:elmuslim_app/presentation/custom_adhkar/cubit/custom_adhkar_cubit.dart';
import 'package:elmuslim_app/presentation/home/screens/adhkar/cubit/adhkar_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:elmuslim_app/app/utils/app_prefs.dart';
import 'package:elmuslim_app/data/data_source/local/local_data_source.dart';
import 'package:elmuslim_app/data/repository/repository_impl.dart';
import 'package:elmuslim_app/domain/repository/repository.dart';
import 'package:elmuslim_app/domain/usecase/hadith_usecase.dart';
import 'package:elmuslim_app/domain/usecase/quran_usecase.dart';
import 'package:elmuslim_app/presentation/home/cubit/home_cubit.dart';
import 'package:elmuslim_app/presentation/home/screens/hadith/cubit/hadith_cubit.dart';
import 'package:elmuslim_app/presentation/home/screens/quran/cubit/quran_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:elmuslim_app/data/database/database.dart';
import '../../presentation/home/viewmodel/home_viewmodel.dart';

final instance = GetIt.instance;

Future initAppModule() async {
  // app module is a module where we put all generic dependencies.
  //shared prefs instance
  final sharedPrefs = await SharedPreferences.getInstance();
  instance.registerLazySingleton<SharedPreferences>(() => sharedPrefs);

  //app prefs instance
  instance.registerLazySingleton<AppPreferences>(() => AppPreferences());

  //Database instance
  final database = await $FloorAppDatabase.databaseBuilder('app_database.db').build();
  instance.registerLazySingleton<AppDatabase>(() => database);

  //BLoC
  instance.registerFactory<HomeCubit>(() => HomeCubit());
  instance.registerFactory<QuranCubit>(() => QuranCubit());
  instance.registerFactory<HadithCubit>(() => HadithCubit());
  instance.registerFactory<AdhkarCubit>(() => AdhkarCubit());
  instance.registerFactory<CustomAdhkarCubit>(() => CustomAdhkarCubit());

  //Repository
  instance.registerLazySingleton<Repository>(
      () => RepositoryImpl());

  //Data Source
  instance.registerLazySingleton<LocalDataSource>(() => LocalDataSourceImpl());

  //Page Controller
  instance.registerFactory<PageController>(() => PageController());

  //Text Editing Controller
  instance.registerFactory<TextEditingController>(() => TextEditingController());

  //Form Key
  instance.registerFactory<GlobalKey<FormState>>(() => GlobalKey<FormState>());



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

void initAdhkarModule() {
  if (!GetIt.I.isRegistered<AdhkarUseCase>()) {
    instance.registerFactory<AdhkarUseCase>(() => AdhkarUseCase());
  }
}

void initCustomAdhkarModule() {
  if (!GetIt.I.isRegistered<GetAllCustomAdhkarUseCase>()) {
    instance.registerFactory<GetAllCustomAdhkarUseCase>(() => GetAllCustomAdhkarUseCase());
  }
  if (!GetIt.I.isRegistered<GetCustomDhikrByIdUseCase>()) {
    instance.registerFactory<GetCustomDhikrByIdUseCase>(() => GetCustomDhikrByIdUseCase());
  }
  if (!GetIt.I.isRegistered<InsertNewDhikrUseCase>()) {
    instance.registerFactory<InsertNewDhikrUseCase>(() => InsertNewDhikrUseCase());
  }
  if (!GetIt.I.isRegistered<UpdateCustomDhikrUseCase>()) {
    instance.registerFactory<UpdateCustomDhikrUseCase>(() => UpdateCustomDhikrUseCase());
  }
  if (!GetIt.I.isRegistered<DelCustomDhikrByDhikrTextUseCase>()) {
    instance.registerFactory<DelCustomDhikrByDhikrTextUseCase>(() => DelCustomDhikrByDhikrTextUseCase());
  }
  if (!GetIt.I.isRegistered<DelAllCustomAdhkarUseCase>()) {
    instance.registerFactory<DelAllCustomAdhkarUseCase>(() => DelAllCustomAdhkarUseCase());
  }
}
