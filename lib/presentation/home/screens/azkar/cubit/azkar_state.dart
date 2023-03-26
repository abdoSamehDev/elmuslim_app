part of 'azkar_cubit.dart';

abstract class AzkarState {
  const AzkarState();
}

class AzkarInitial extends AzkarState {}

class AzkarGetDataLoadingState extends AzkarState {}

class AzkarGetDataSuccessState extends AzkarState {
  final List<AzkarModel> azkarList;

  const AzkarGetDataSuccessState(this.azkarList);
}

class AzkarGetDataErrorState extends AzkarState {
  final String error;

  const AzkarGetDataErrorState(this.error);
}

class AzkarCounterState extends AzkarState {}
