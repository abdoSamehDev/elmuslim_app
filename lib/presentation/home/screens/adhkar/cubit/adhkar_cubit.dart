import 'package:elmuslim_app/domain/models/adhkar/adhkar_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:elmuslim_app/app/utils/di.dart';
import 'package:elmuslim_app/domain/usecase/adhkar_usecase.dart';
import 'package:elmuslim_app/domain/usecase/base_usecase.dart';
import '../../../../../app/utils/constants.dart';

part 'adhkar_state.dart';

class AdhkarCubit extends Cubit<AdhkarState> {
  final AdhkarUseCase _adhkarUseCase = instance<AdhkarUseCase>();

  AdhkarCubit() : super(AdhkarInitial());

  static AdhkarCubit get(context) => BlocProvider.of(context);

  List<AdhkarModel> adhkarList = [];

  Future getAdhkarData() async {
    emit(AdhkarGetDataLoadingState());
    final result = await _adhkarUseCase(const NoParameters());
    result.fold((l) => emit(AdhkarGetDataErrorState(l.message)),
        (r) {
      adhkarList = r;
          emit(AdhkarGetDataSuccessState(r));
        });
  }

  List<AdhkarModel> getAdhkarFromCategory(
      {required List<AdhkarModel> adhkarList, required String category}) {
    List<AdhkarModel> adhkar =
        List.from(adhkarList.where((e) => e.category == category));
    return adhkar;
  }

  List<String> getAdhkarCategories(
      {required List<AdhkarModel> adhkarList,}) {
    List<String> adhkarCategories =
    List.from(adhkarList.map((e) => e.category).toSet());
    return adhkarCategories;
  }

  int count = 0;

  void dhikrCounter(int maxCounts, PageController controller, int index) {
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

    emit(AdhkarCounterState());
  }

  void resetCounter(){
    count = 0;
    emit(AdhkarCounterResetState());
  }
}
