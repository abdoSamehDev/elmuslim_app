part of 'prayer_timings_cubit.dart';

abstract class PrayerTimingsState {
  const PrayerTimingsState();
}

class PrayerTimesInitialState extends PrayerTimingsState {}

class GetPrayerTimesLoadingState extends PrayerTimingsState {}

class GetPrayerTimesSuccessState extends PrayerTimingsState {
  final PrayerTimingsModel prayerTimingsModel;

  GetPrayerTimesSuccessState(this.prayerTimingsModel);
}

class GetPrayerTimesErrorState extends PrayerTimingsState {
  final String error;

  const GetPrayerTimesErrorState(this.error);
}

class GetTimingsListState extends PrayerTimingsState {}
