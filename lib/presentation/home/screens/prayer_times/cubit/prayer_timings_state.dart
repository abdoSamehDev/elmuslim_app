part of 'prayer_timings_cubit.dart';

abstract class PrayerTimingsState {
  const PrayerTimingsState();
}

class PrayerTimesInitialState extends PrayerTimingsState {}

class GetPrayerTimesLoadingState extends PrayerTimingsState {}

class GetPrayerTimesSuccessState extends PrayerTimingsState {}

class GetPrayerTimesErrorState extends PrayerTimingsState {
  final String error;

  const GetPrayerTimesErrorState(this.error);
}
