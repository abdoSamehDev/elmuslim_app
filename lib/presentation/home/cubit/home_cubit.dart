import 'package:flutter_bloc/flutter_bloc.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  static HomeCubit get(context) => BlocProvider.of(context);

int currentIndex = 0;

  void changeBotNavIndex(int index) {
    currentIndex = index;
    emit(HomeChangeBotNavIndexState());
  }
}
