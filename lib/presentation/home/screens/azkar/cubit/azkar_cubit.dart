import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:islamic_app/app/utils/di.dart';
import 'package:islamic_app/domain/models/azkar/azkar_model.dart';
import 'package:islamic_app/domain/usecase/azkar_usecase.dart';
import 'package:islamic_app/domain/usecase/base_usecase.dart';
import '../../../../../app/utils/constants.dart';

part 'azkar_state.dart';

class AzkarCubit extends Cubit<AzkarState> {
  final AzkarUseCase _azkarUseCase = instance<AzkarUseCase>();

  AzkarCubit() : super(AzkarInitial());

  static AzkarCubit get(context) => BlocProvider.of(context);

  Future getAzkarData() async {
    emit(AzkarGetDataLoadingState());
    final result = await _azkarUseCase(const NoParameters());
    result.fold((l) => emit(AzkarGetDataErrorState(l.message)),
        (r) => emit(AzkarGetDataSuccessState(r)));
  }

  List<AzkarModel> getAzkarFromCategory(
      {required List<AzkarModel> azkarList, required String category}) {
    List<AzkarModel> azkar =
        List.from(azkarList.where((e) => e.category == category));
    return azkar;
  }

  List<String> getAzkarCategories(
      {required List<AzkarModel> azkarList,}) {
    List<String> azkarCategories =
    List.from(azkarList.map((e) => e.category).toSet());
    return azkarCategories;
  }

  int count = 0;

  void zekrCounter(int maxCounts, PageController controller, int index) {
    if (count < maxCounts) {
      count++;
    }
    if (count == maxCounts) {
      controller.nextPage(
          curve: Curves.ease,
          duration: const Duration(milliseconds: Constants.nextPageDuration));
    }
    controller.addListener(() {
      count = 0;
    });

    emit(AzkarCounterState());
  }
}
