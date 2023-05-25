import 'package:dio/dio.dart';
import 'package:elmuslim_app/app/utils/constants.dart';
import 'package:elmuslim_app/data/responses/prayer_timings/prayer_timings_response.dart';
import 'package:retrofit/http.dart';

part 'prayer_timings_api.g.dart';

@RestApi(baseUrl: Constants.baseUrl)
abstract class PrayerTimingsServiceClient {
  factory PrayerTimingsServiceClient(Dio dio, {String baseUrl}) =
      _PrayerTimingsServiceClient;

  @GET(Constants.prayerTimingPath)
  Future<PrayerTimingsResponse> getPrayerTimings(
    @Path("date") String date,
    @Path("city") String city,
    @Path("country") String country,
  );
}
