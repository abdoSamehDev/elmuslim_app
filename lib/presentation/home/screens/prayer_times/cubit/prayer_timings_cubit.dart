import 'package:easy_localization/easy_localization.dart';
import 'package:elmuslim_app/app/utils/constants.dart';
import 'package:elmuslim_app/app/utils/di.dart';
import 'package:elmuslim_app/domain/models/prayer_timings/prayer_timings_model.dart';
import 'package:elmuslim_app/domain/usecase/get_prayer_timings_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:location/location.dart' as location_package;

part 'prayer_timings_state.dart';

class PrayerTimingsCubit extends Cubit<PrayerTimingsState> {
  final GetPrayerTimingsUseCase _getPrayerTimingsUseCase =
      instance<GetPrayerTimingsUseCase>();

  PrayerTimingsCubit() : super(PrayerTimesInitialState());

  static PrayerTimingsCubit get(context) => BlocProvider.of(context);

  location_package.Location location = location_package.Location();

  PrayerTimingsModel prayerTimingsModel =
      const PrayerTimingsModel(code: 0, status: "", data: null);

  Future<PrayerTimingsModel> getPrayerTimings() async {
    emit(GetPrayerTimesLoadingState());
    DateTime dateNow = DateTime.now();
    var formatter = DateFormat("dd-MM-yyy");
    String formattedDate = formatter.format(dateNow);
    final result =
        await _getPrayerTimingsUseCase(GetPrayerTimingsUseCaseUseCaseInput(
      date: formattedDate,
      city: recordLocation.$1,
      country: recordLocation.$2,
    ));
    result.fold((l) {
      prayerTimingsModel =
          PrayerTimingsModel(code: l.code!, status: l.message, data: null);
      emit(GetPrayerTimesErrorState(l.message));
    }, (r) {
      prayerTimingsModel = r;
      emit(GetPrayerTimesSuccessState(r));
    });
    return prayerTimingsModel;
  }
}
