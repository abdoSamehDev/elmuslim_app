import 'package:elmuslim_app/presentation/home/screens/prayer_times/cubit/prayer_timings_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PrayerTimingsScreen extends StatelessWidget {
  const PrayerTimingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PrayerTimingsCubit, PrayerTimingsState>(
      listener: (BuildContext context, state) {},
      builder: (BuildContext context, Object? state) {
        return Placeholder();
      },
    );
  }
}
