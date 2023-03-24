import 'dart:convert';

import 'package:islamic_app/app/utils/functions.dart';
import 'package:islamic_app/data/responses/azkar/azkar_response.dart';
import 'package:islamic_app/data/responses/hadith/hadith_response.dart';
import 'package:islamic_app/data/responses/quran/quran_response.dart';

const String quranPath = "assets/json/quran.json";
const String hadithPath = "assets/json/40_hadith_nawawi.json";
const String azkarPath = "assets/json/azkar.json";


abstract class LocalDataSource{
  Future<List<QuranResponse>> getQuranData();
  Future<List<HadithResponse>> getHadithData();
  Future<List<AzkarResponse>> getAzkarData();
}

class LocalDataSourceImpl implements LocalDataSource{
  @override
  Future<List<AzkarResponse>> getAzkarData() async{
    final jsonString = await fetchDataFromJson(azkarPath);
    final data = jsonDecode(jsonString);
    // return data;
    return List<AzkarResponse>.from((data as List).map((e) => AzkarResponse.fromJson(e)));
  }

  @override
  Future<List<HadithResponse>> getHadithData() async{
    final jsonString = await fetchDataFromJson(hadithPath);
    final data = jsonDecode(jsonString);
    return List<HadithResponse>.from((data as List).map((e) => HadithResponse.fromJson(e)));
  }

  @override
  Future<List<QuranResponse>> getQuranData()  async{
    final jsonString = await fetchDataFromJson(quranPath);
    final data = jsonDecode(jsonString);
    return List<QuranResponse>.from((data as List).map((e) => QuranResponse.fromJson(e)));
  }

}