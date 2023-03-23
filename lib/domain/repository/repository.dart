import 'package:dartz/dartz.dart';
import 'package:islamic_app/app/error/failure.dart';
import 'package:islamic_app/domain/models/azkar/azkar_model.dart';
import 'package:islamic_app/domain/models/hadith/hadith_model.dart';
import 'package:islamic_app/domain/models/quran/quran_model.dart';

abstract class Repository{
  Future<Either<Failure, List<QuranModel>>> getQuranData();
  Future<Either<Failure, List<HadithModel>>> getHadithData();
  Future<Either<Failure, List<AzkarModel>>> getAzkarData();
}