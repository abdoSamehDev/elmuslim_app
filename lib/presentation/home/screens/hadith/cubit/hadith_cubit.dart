import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:elmuslim_app/app/utils/di.dart';
import 'package:elmuslim_app/domain/models/hadith/hadith_model.dart';
import 'package:elmuslim_app/domain/usecase/base_usecase.dart';
import 'package:elmuslim_app/domain/usecase/hadith_usecase.dart';

part 'hadith_state.dart';

class HadithCubit extends Cubit<HadithState> {
  final HadithUseCase _hadithUseCase = instance<HadithUseCase>();

  HadithCubit() : super(HadithInitial());

  static HadithCubit get(context) => BlocProvider.of(context);

  Future getHadithData() async {
    emit(HadithGetDataLoadingState());
    final result = await _hadithUseCase(const NoParameters());
    result.fold((l) => emit(HadithGetDataErrorState(l.message)),
        (r) => emit(HadithGetDataSuccessState(r)));
  }
}
