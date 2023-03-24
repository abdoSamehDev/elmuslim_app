
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:islamic_app/app/utils/di.dart';
import 'package:islamic_app/domain/models/azkar/azkar_model.dart';
import 'package:islamic_app/domain/usecase/azkar_usecase.dart';
import 'package:islamic_app/domain/usecase/base_usecase.dart';

part 'azkar_state.dart';

class AzkarCubit extends Cubit<AzkarState> {
  final AzkarUseCase _azkarUseCase = instance<AzkarUseCase>();
  AzkarCubit() : super(AzkarInitial());

  static AzkarCubit get(context) => BlocProvider.of(context);

  Future getAzkarData() async {
    emit(AzkarGetDataLoadingState());
    final result = await _azkarUseCase(const NoParameters());
    result.fold((l) => emit(AzkarGetDataErrorState(l.message)), (r) => emit(AzkarGetDataSuccessState(r)));
  }
}
