import 'package:dartz/dartz.dart';
import 'package:elmuslim_app/app/error/exception.dart';
import 'package:elmuslim_app/app/error/failure.dart';
import 'package:elmuslim_app/app/utils/di.dart';
import 'package:elmuslim_app/data/data_source/local/local_data_source.dart';
import 'package:elmuslim_app/data/data_source/remote/remote_data_source.dart';
import 'package:elmuslim_app/data/database/dao.dart';
import 'package:elmuslim_app/data/database/database.dart';
import 'package:elmuslim_app/data/mapper/mapper.dart';
import 'package:elmuslim_app/data/network/error_handler.dart';
import 'package:elmuslim_app/data/network/network_info.dart';
import 'package:elmuslim_app/domain/models/adhkar/adhkar_model.dart';
import 'package:elmuslim_app/domain/models/adhkar/custom_adhkar_model.dart';
import 'package:elmuslim_app/domain/models/hadith/hadith_model.dart';
import 'package:elmuslim_app/domain/models/prayer_timings/prayer_timings_model.dart';
import 'package:elmuslim_app/domain/models/quran/quran_model.dart';
import 'package:elmuslim_app/domain/models/quran/quran_search_model.dart';

import '../../domain/repository/repository.dart';

class RepositoryImpl implements Repository {
  final LocalDataSource _localDataSource = instance<LocalDataSource>();
  final RemoteDataSource _remoteDataSource = instance<RemoteDataSource>();
  final NetworkInfo _networkInfo = instance<NetworkInfo>();
  final CustomAdhkarDao _customAdhkarDao =
      instance<AppDatabase>().customAdhkarDao;

  RepositoryImpl();

  @override
  Future<Either<Failure, List<AdhkarModel>>> getAdhkarData() async {
    final data = await _localDataSource.getAdhkarData();
    try {
      return Right(data.map((e) => e.toDomain()).toList());
    } on LocalException catch (failure) {
      return Left(LocalFailure(null, failure.message));
    }
  }

  @override
  Future<Either<Failure, List<HadithModel>>> getHadithData() async {
    final data = await _localDataSource.getHadithData();
    try {
      return Right(data.map((e) => e.toDomain()).toList());
    } on LocalException catch (failure) {
      return Left(LocalFailure(null, failure.message));
    }
  }

  @override
  Future<Either<Failure, List<QuranModel>>> getQuranData() async {
    final data = await _localDataSource.getQuranData();
    try {
      return Right(data.map((e) => e.toDomain()).toList());
    } on LocalException catch (failure) {
      return Left(LocalFailure(null, failure.message));
    }
  }

  @override
  Future<Either<Failure, List<QuranSearchModel>>> getQuranSearchData() async {
    final data = await _localDataSource.getQuranSearchData();
    try {
      return Right(data.map((e) => e.toDomain()).toList());
    } on LocalException catch (failure) {
      return Left(LocalFailure(null, failure.message));
    }
  }

  @override
  Future<Either<Failure, PrayerTimingsModel>> getPrayerTimings(
      String date, String city, String country) async {
    if (await _networkInfo.isConnected) {
      try {
        final response =
            await _remoteDataSource.getPrayerTimings(date, city, country);

        if (response.code == ApiInternalStatus.success) {
          //success
          return Right(response.toDomain());
        } else {
          //failure (business)
          return Left(ServerFailure(response.code ?? ApiInternalStatus.failure,
              response.status ?? ResponseMessage.unknown));
        }
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      //failure (connection)
      return Left(DataSource.noInternetConnection.getServerFailure());
    }
  }

  @override
  Future<Either<Failure, void>> delDhikrByDhikrText(String dhikr) async {
    await _customAdhkarDao.delDhikrByDhikrText(dhikr);
    try {
      return const Right(null);
    } on LocalException catch (failure) {
      return Left(LocalFailure(null, failure.message));
    }
  }

  @override
  Future<Either<Failure, void>> deleteAll(List<CustomAdhkarEntity> list) async {
    await _customAdhkarDao.deleteAll(list);
    try {
      return const Right(null);
    } on LocalException catch (failure) {
      return Left(LocalFailure(null, failure.message));
    }
  }

  @override
  Future<Either<Failure, List<CustomAdhkarEntity>>> getAllCustomAdhkar() async {
    final data = await _customAdhkarDao.getAllCustomAdhkar();
    try {
      return Right(data);
    } on LocalException catch (failure) {
      return Left(LocalFailure(null, failure.message));
    }
  }

  @override
  Future<Either<Failure, CustomAdhkarEntity?>> getDhikrByDhikrText(
      String dhikr) async {
    CustomAdhkarEntity? resultDhikr =
        await _customAdhkarDao.getDhikrByDhikrText(dhikr);
    try {
      return Right(resultDhikr);
    } on LocalException catch (failure) {
      return Left(LocalFailure(null, failure.message));
    }
  }

  @override
  Future<Either<Failure, void>> insertDhikr(CustomAdhkarEntity dhikr) async {
    await _customAdhkarDao.insertDhikr(dhikr);
    try {
      return const Right(null);
    } on LocalException catch (failure) {
      return Left(LocalFailure(null, failure.message));
    }
  }

  @override
  Future<Either<Failure, void>> updateDhikr(CustomAdhkarEntity dhikr) async {
    await _customAdhkarDao.updateDhikr(dhikr);
    try {
      return const Right(null);
    } on LocalException catch (failure) {
      return Left(LocalFailure(null, failure.message));
    }
  }
}
