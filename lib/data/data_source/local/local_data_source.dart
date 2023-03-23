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
    List<AzkarResponse> data = jsonDecode(jsonString);
    return data;
  }

  @override
  Future<List<HadithResponse>> getHadithData() async{
    final jsonString = await fetchDataFromJson(hadithPath);
    List<HadithResponse> data = jsonDecode(jsonString);
    return data;
  }

  @override
  Future<List<QuranResponse>> getQuranData()  async{
    final jsonString = await fetchDataFromJson(quranPath);
    List<QuranResponse> data = jsonDecode(jsonString);
    return data;
  }

}