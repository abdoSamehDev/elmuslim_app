import 'package:easy_localization/easy_localization.dart';
import 'package:elmuslim_app/app/utils/di.dart';
import 'package:elmuslim_app/domain/models/prayer_timings/prayer_timings_model.dart';
import 'package:elmuslim_app/domain/usecase/get_prayer_timings_usecase.dart';
import 'package:elmuslim_app/presentation/resources/strings_manager.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:location/location.dart' as location_package;

part 'prayer_timings_state.dart';

class PrayerTimingsCubit extends Cubit<PrayerTimingsState> {
  final GetPrayerTimingsUseCase _getPrayerTimingsUseCase =
      instance<GetPrayerTimingsUseCase>();

  PrayerTimingsCubit() : super(PrayerTimesInitialState());

  static PrayerTimingsCubit get(context) => BlocProvider.of(context);

  location_package.Location location = location_package.Location();

  Future<(String, String)> getLocation() async {
    String currentCountry = "";
    String currentCity = "";

    bool serviceEnabled;
    location_package.PermissionStatus permissionGranted;
    location_package.LocationData locationData;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return (AppStrings.enableLocation.tr(), AppStrings.enableLocation.tr());
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == location_package.PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != location_package.PermissionStatus.granted) {
        return (
          AppStrings.giveLocationAccessPermission.tr(),
          AppStrings.giveLocationAccessPermission.tr()
        );
      }
    }

    locationData = await location.getLocation();
    print("LocationData: $locationData");
    print("Latitude: ${locationData.latitude!}");
    print("Longtitude: ${locationData.longitude!}");

    List<Placemark> placeMarks = await placemarkFromCoordinates(
        locationData.latitude!, locationData.longitude!);

    print("placemarks: $placeMarks");
    if (placeMarks.isNotEmpty) {
      print("Current Location1: ${placeMarks[0].country.toString()}");
      currentCountry = placeMarks[0].country.toString();
      currentCity = placeMarks[0].subAdministrativeArea.toString();
    } else {
      currentCountry = AppStrings.noLocationFound.tr();
      currentCity = AppStrings.noLocationFound.tr();
    }

    return (currentCity, currentCountry);
  }

  Future<PrayerTimingsModel> getPrayerTimings() async {
    emit(GetPrayerTimesLoadingState());
    (String currentCity, String currentCountry) recordLocation =
        await getLocation();
    print("CURRENT CITY: ${recordLocation.$1}");
    print("CURRENT Country: ${recordLocation.$2}");
    DateTime dateNow = DateTime.now();
    var formatter = DateFormat("dd-MM-yyy");
    String formattedDate = formatter.format(dateNow);
    // print("Location: $currentLocation");
    print("Formatted Date: $formattedDate");
    // getPrayerTimingsObject.copyWith(
    //   city: currentLocation,
    // );
    PrayerTimingsModel prayerTimingsModel =
        PrayerTimingsModel(code: 0, status: "", timings: null, date: null);
    final result =
        await _getPrayerTimingsUseCase(GetPrayerTimingsUseCaseUseCaseInput(
      date: formattedDate,
      city: recordLocation.$1,
      country: recordLocation.$2,
    ));
    result.fold((l) {
      prayerTimingsModel = PrayerTimingsModel(
          code: l.code!, status: l.message, timings: null, date: null);
      emit(GetPrayerTimesErrorState(l.message));
    }, (r) {
      prayerTimingsModel = r;
      emit(GetPrayerTimesSuccessState());
    });
    return prayerTimingsModel;
  }
}
