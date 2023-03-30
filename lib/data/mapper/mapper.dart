import 'package:islamic_app/app/utils/extensions.dart';
import 'package:islamic_app/data/responses/quran/quran_response.dart';
import 'package:islamic_app/domain/models/azkar/azkar_model.dart';
import 'package:islamic_app/domain/models/hadith/hadith_model.dart';
import 'package:islamic_app/domain/models/quran/quran_model.dart';
import '../responses/azkar/azkar_response.dart';
import '../responses/hadith/hadith_response.dart';

extension AyahResponseMapper on AyahResponse {
  AyahModel toDomain() {
    return AyahModel(
      number: number.orZero(),
      text: text.orEmpty(),
      numberInSurah: numberInSurah.orZero(),
      juz: juz.orZero(),
      page: page.orZero(),
      hizbQuarter: hizbQuarter.orZero(),
    );
  }
}

extension QuranResponseMapper on QuranResponse {
  QuranModel toDomain() {
    List<AyahModel> ayahs =
        (this.ayahs.map((ayahResponse) => ayahResponse.toDomain()))
            .cast<AyahModel>()
            .toList();
    return QuranModel(
      number: number.orZero(),
      name: name.orEmpty(),
      englishName: englishName.orEmpty(),
      englishNameTranslation: englishNameTranslation.orEmpty(),
      revelationType: revelationType.orEmpty(),
      ayahs: ayahs,
    );
  }
}

extension HadithResponseMapper on HadithResponse {
  HadithModel toDomain() {
    return HadithModel(
        description: description.orEmpty(), hadith: hadith.orEmpty());
  }
}

extension AzkarResponseMapper on AzkarResponse {
  AzkarModel toDomain() {
    return AzkarModel(
      category: category.orEmpty(),
      count: count.orEmpty(),
      description: description.orEmpty(),
      reference: reference.orEmpty(),
      zekr: zekr.orEmpty(),
    );
  }
}
