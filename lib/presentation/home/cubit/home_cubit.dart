
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:islamic_app/app/utils/di.dart';
import 'package:islamic_app/domain/models/azkar/azkar_model.dart';
import 'package:islamic_app/domain/models/hadith/hadith_model.dart';
import 'package:islamic_app/domain/models/quran/quran_model.dart';
import 'package:islamic_app/domain/usecase/base_usecase.dart';
import 'package:islamic_app/domain/usecase/quran_usecase.dart';

import '../../../domain/usecase/azkar_usecase.dart';
import '../../../domain/usecase/hadith_usecase.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final QuranUseCase _quranUseCase = instance<QuranUseCase>();
  final HadithUseCase _hadithUseCase = instance<HadithUseCase>();
  final AzkarUseCase _azkarUseCase = instance<AzkarUseCase>();
  HomeCubit() : super(HomeInitial());

  static HomeCubit get(context) => BlocProvider.of(context);

int currentIndex = 0;

  void changeBotNavIndex(int index) {
    currentIndex = index;
    emit(HomeChangeBotNavIndexState());
  }

  Future getQuranData() async {
    emit(HomeGetQuranDataLoadingState());
    final result = await _quranUseCase(const NoParameters());
    result.fold((l) => emit(HomeGetQuranDataErrorState(l.message)), (r) => emit(HomeGetQuranDataSuccessState(r)));
  }

  Future getHadithData() async {
    emit(HomeGetHadithDataLoadingState());
    final result = await _hadithUseCase(const NoParameters());
    result.fold((l) => emit(HomeGetHadithDataErrorState(l.message)), (r) => emit(HomeGetHadithDataSuccessState(r)));
  }

  Future getAzkarData() async {
    emit(HomeGetAzkarDataLoadingState());
    final result = await _azkarUseCase(const NoParameters());
    result.fold((l) => emit(HomeGetAzkarDataErrorState(l.message)), (r) => emit(HomeGetAzkarDataSuccessState(r)));
  }
}
